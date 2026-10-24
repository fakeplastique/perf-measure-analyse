SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -ec
.DELETE_ON_ERROR:

CORE ?= 2
# TILE swept 16..256 on N=1024: 64 ~ 128 ~ 256 (0.16s), 32 slower; 64 fits L1/L2
TILE ?= 64
N    ?= 1024
# measurement profile (defaults = full; `make quick` shrinks them to finish in ~100 s)
WIN    ?= 60
STATRUNS ?= 5
RUNS   ?= 5
IDLE_S ?= 30
PAUSE  ?= 5
COOL   ?= 20
WARM   ?= 3
export CORE N RUNS IDLE_S PAUSE COOL WARM
V    := v0 v1 v2

BASE := -g -fno-omit-frame-pointer
F_v0 := -O0 $(BASE)
F_v1 := -O3 -march=native $(BASE)
F_v2 := $(F_v1) -DOPT_SRC -DTILE=$(TILE)

.PHONY: quick build preflight check clean idle power-prog power-sys compare all setup time stat record calib flame flame-sys flame-diff fgcheck asm

build: $(addprefix build/,$(V))

build/%: src/pipeline.c Makefile
	@mkdir -p build
	gcc $(F_$*) -o $@ $<

# perf needs paranoid<=0 (resets on reboot); GNU time for `-v`
preflight:
	@command -v perf >/dev/null || { echo "perf missing: sudo pacman -S perf"; exit 1; }
	@test -x /usr/bin/time || { echo "GNU time missing: sudo pacman -S time"; exit 1; }
	@test "$$(cat /proc/sys/kernel/perf_event_paranoid)" -le 0 || { \
	  echo "run: sudo sysctl kernel.perf_event_paranoid=-1 kernel.kptr_restrict=0"; exit 1; }

# v1/v2 must match v0 within 1e-9 relative (FMA changes last bits)
check: build
	@c0=$$(build/v0 256 | sed 's/checksum=//'); \
	for v in v1 v2; do \
	  c=$$(build/$$v 256 | sed 's/checksum=//'); \
	  python3 scripts/stats.py rel_check $$c0 $$c || { echo "checksum mismatch $$v: $$c vs $$c0"; exit 1; }; \
	done; echo "check ok"

# also drops results/asm: they depend on N, CORE, TILE and the governor
clean:
	rm -rf build results asm

R      := results
.SECONDARY:
# -d is ignored when -e is given, so L2 events run as a second appended pass
# samples for perf record: v2 finishes in 0.17s, repeat it for a usable profile
RREPS_v0 := 1
RREPS_v1 := 1
RREPS_v2 ?= 20
L2EV   := -e l2_cache_req_stat.ic_dc_hit_in_l2,l2_cache_req_stat.ic_dc_miss_in_l2
RUN    := taskset -c $(CORE)

setup:
	@test -d tools/FlameGraph || git clone --depth 1 https://github.com/brendangregg/FlameGraph tools/FlameGraph

time: $(foreach v,$(V),$(R)/$(v)/time.txt)
stat: $(foreach v,$(V),$(R)/$(v)/stat.txt)
record: $(foreach v,$(V),$(R)/$(v)/report.txt)

$(R)/%/time.txt: build/% | preflight
	@mkdir -p $(R)/$*
	$(RUN) /usr/bin/time -v build/$* $(N) >/dev/null 2> $@

$(R)/%/stat.txt: build/% | preflight
	@mkdir -p $(R)/$*
	$(RUN) perf stat -d -r $(STATRUNS) -o $@ build/$* $(N) >/dev/null
	$(RUN) perf stat $(L2EV) -r $(STATRUNS) -o $@ --append build/$* $(N) >/dev/null

$(R)/%/perf.data: build/% | preflight
	@mkdir -p $(R)/$*
	perf record -F 997 -g -o $@ -- $(RUN) build/$* $(N) $(RREPS_$*) >/dev/null

$(R)/%/report.txt: $(R)/%/perf.data
	perf report --stdio -i $< > $@ 2>/dev/null

FG := tools/FlameGraph

# fail with a hint instead of "perl: not found"
fgcheck:
	@test -f $(FG)/flamegraph.pl || { echo "FlameGraph missing: run 'make setup'"; exit 1; }

# REPS so one power run lasts >=WIN s (min 1; timer floor 0.01s avoids /0)
calib: $(foreach v,$(V),$(R)/$(v)/reps)
$(R)/%/reps: build/% | preflight
	@mkdir -p $(R)/$*
	@t=$$($(RUN) /usr/bin/time -f %e build/$* $(N) 2>&1 >/dev/null); \
	[[ $$t =~ ^[0-9.]+$$ ]] || { echo "calib $*: bad time '$$t'"; exit 1; }; \
	awk -v t=$$t -v w=$(WIN) 'BEGIN{ if (t<0.01) t=0.01; r=int(w/t); if (r*t<w) r++; print r }' > $@; \
	echo "$*: $$t s/run -> reps=$$(cat $@)"

flame: $(foreach v,$(V),$(R)/$(v)/flame.svg)
$(R)/%/folded.txt: $(R)/%/perf.data | fgcheck
	perf script -i $< | $(FG)/stackcollapse-perf.pl > $@
$(R)/%/flame.svg: $(R)/%/folded.txt | fgcheck
	$(FG)/flamegraph.pl --title "$* ($(N)x$(N))" $< > $@

# whole system while v0 runs pinned: shows the program is one slice of the CPU
flame-sys: fgcheck preflight
	@mkdir -p $(R)
	perf record -a -F 997 -g -o $(R)/sys.data -- $(RUN) build/v0 $(N) >/dev/null
	perf script -i $(R)/sys.data | $(FG)/stackcollapse-perf.pl | $(FG)/flamegraph.pl --title "system-wide, v0 running" > $(R)/flame_sys.svg

# v0 ran 1 rep, v2 ran RREPS_v2: scale sample counts to the same work (RREPS_v2 reps)
WORK := $(RREPS_v2)
$(R)/%/folded_w.txt: $(R)/%/folded.txt
	awk -v k=$$(($(WORK)/$(RREPS_$*))) '{ n=$$NF; sub(/ [0-9]+$$/, ""); print $$0, n*k }' $< > $@
flame-diff: $(R)/v0/folded_w.txt $(R)/v2/folded_w.txt | fgcheck
	$(FG)/difffolded.pl $(R)/v0/folded_w.txt $(R)/v2/folded_w.txt | $(FG)/flamegraph.pl --title "diff v0 -> v2" > $(R)/flame_diff_v0_v2.svg

# assembly per version, matmul disassembly, instruction counts for 4.1/4.1.1
asm: $(foreach v,$(V),asm/$(v).s asm/$(v).matmul.dis) asm/counts.txt
asm/%.s: src/pipeline.c
	@mkdir -p asm
	gcc $(F_$*) -S -o $@ $<
asm/%.matmul.dis: build/%
	@mkdir -p asm
	objdump -d --no-show-raw-insn $< | awk '/^[0-9a-f]+ <matmul>:/{p=1} p&&/^$$/{p=0} p' > $@
asm/counts.txt: $(foreach v,$(V),asm/$(v).matmul.dis)
	@for v in $(V); do f=asm/$$v.matmul.dis; \
	  echo "$$v ymm=$$(grep -c ymm $$f) fma_packed=$$(grep -c -E 'vfmadd[0-9]+pd' $$f) fma_scalar=$$(grep -c -E 'vfmadd[0-9]+sd' $$f) mul_add_scalar=$$(grep -c -E '(v)?(mul|add)sd' $$f) insns=$$(grep -c '^ ' $$f)"; \
	done > $@

# energy: power-prog = RAPL minus idle (any power source); power-sys = BAT1, AC unplugged
idle: | preflight
	scripts/power_prog.sh idle
power-prog: $(foreach v,$(V),build/$(v)) | preflight
	scripts/power_prog.sh
power-sys: calib | preflight
	@for v in $(V); do scripts/power_sys.sh $$v || exit 1; done

compare: check
	python3 scripts/stats.py compare

# one-shot collection; run from battery after `sudo scripts/env.sh`
all: preflight check time stat record calib flame flame-sys flame-diff asm power-prog power-sys compare

# ~100 s profile: smaller matrices, 10 s battery window, short idle/cooldown, 3 runs.
# Weaker statistics than `make clean all`; overwrites results/.
quick:
	$(MAKE) clean
	$(MAKE) all N=512 WIN=10 STATRUNS=3 RUNS=3 IDLE_S=5 PAUSE=1 COOL=1 WARM=1 RREPS_v2=100

# Performance and Energy Characterisation of a Cache-Bound Numerical Kernel

A small, reproducible measurement harness that profiles a C workload at three optimisation levels and attributes the differences to compiler code generation (scalar vs. AVX2/FMA), memory access pattern (cache behaviour), and energy.

## Abstract

The workload is a four-stage pipeline (data generation, dense matrix multiplication, 3×3 stencil, checksum) that is dominated by `matmul`. It is built in three variants:

| Variant | Build | Change |
|---|---|---|
| `v0` | `-O0` | naive `ijk` matmul (baseline) |
| `v1` | `-O3 -march=native` | identical source; compiler optimisations only |
| `v2` | `-O3 -march=native -DOPT_SRC` | `ikj` loop order with cache blocking (`TILE=64`) |

For each variant the harness collects a CPU flame graph, wall-clock and resource statistics, hardware counters, a sampled profile, the disassembly of the hot kernel, and energy consumption at two scopes (whole system, CPU package attributable to the program). A comparison table and a differential flame graph are produced for `v0` vs. `v2`.

The test platform is an AMD Ryzen 5 5500U (Zen 3; AVX2 and FMA, no AVX-512) running Linux; the tooling assumes `perf` with RAPL energy events (`power/energy-pkg/`) and a laptop battery exposing `current_now`/`voltage_now`.

## Method

**Workload.** `gen_data → matmul → blur3x3 → checksum` on N×N `double` matrices (default N=1024; three matrices are 24 MB, well above the 512 KB per-core L2). Stages are `noinline` so they remain distinct frames at `-O3`. The binary takes `pipeline [N] [REPS]`; `REPS` repeats the pipeline to lengthen short runs.

**Numerical equivalence.** `v2` preserves the ascending-`k` summation order of the naive kernel. FMA contraction is allowed (so `vfmadd*` is generated), which can change the last bits; checksums of all variants are therefore required to agree within a relative tolerance of 1e-9, and `make check` / `make compare` abort otherwise. `-ffast-math` is not used.

**Profiling.** Call stacks come from frame pointers (`-fno-omit-frame-pointer`), sampled at 997 Hz with `perf record -g` and rendered with Brendan Gregg's FlameGraph scripts. A system-wide profile (`perf record -a`) shows the program's share of total CPU time. The differential flame graph scales both profiles to equal work (the `v2` profile repeats the pipeline several times) before `difffolded.pl`, so widths are comparable.

**Counters and resources.** `/usr/bin/time -v`; `perf stat -d -r N` for instructions, cycles, IPC and L1d misses; a second `perf stat` pass for AMD `l2_cache_req_stat.ic_dc_{hit,miss}_in_l2` (the `-d` set has no LLC/L2 events on Zen 3 and is ignored when `-e` is given).

**Disassembly.** `gcc -S` and `objdump -d` of `matmul` per variant; instruction counts (`ymm` operands, packed vs. scalar FMA) are written to `asm/counts.txt`.

**Energy.**
- *System scope:* power is `|current_now| × voltage_now` from `BAT1`, sampled at 1 Hz on battery (AC unplugged; the target refuses to run otherwise). `REPS` is calibrated so one measurement lasts at least `WIN` seconds, only samples inside the run window count, and energy is reported per pipeline run (J/run = E / REPS). The embedded controller refreshes the reading roughly every 3 s, so windows shorter than ~10 s are unreliable.
- *Program scope:* package energy from RAPL (`perf stat -a -e power/energy-pkg/`) for each run, minus idle power × run duration. Idle power is measured immediately before and after the block (a warning is printed if the two differ by more than 30%). Duration is taken from perf's own `duration_time`.
- RAPL on AMD is a model-based estimate, not a direct measurement; treat results as relative comparisons between variants.

## Reproducing

Prerequisites: `gcc`, `make`, `python3`, `perf`, GNU `time`, `git`.

```sh
sudo sysctl kernel.perf_event_paranoid=-1 kernel.kptr_restrict=0   # until reboot
sudo scripts/env.sh          # CPU governor -> performance (`sudo scripts/env.sh reset` to undo)
make setup                   # clones FlameGraph into tools/
# unplug AC, close background applications
make clean all               # full profile: N=1024, 60 s battery windows, 5 repeats (~20 min)
make quick                   # ~100 s profile: N=512, 10 s windows, 3 repeats (weaker statistics)
```

Individual targets: `build`, `check`, `time`, `stat`, `record`, `calib`, `flame`, `flame-sys`, `flame-diff`, `asm`, `idle`, `power-prog`, `power-sys`, `compare`. Tunables (`N`, `TILE`, `CORE`, `WIN`, `STATRUNS`, `RUNS`, `IDLE_S`, `PAUSE`, `COOL`, `WARM`, `RREPS_v2`) are Makefile variables; the program is pinned with `taskset -c $(CORE)`. `make clean` also removes `results/` and `asm/`, because results depend on the parameters and governor.

## Output layout

```
results/{v0,v1,v2}/   time.txt stat.txt report.txt perf.data folded.txt flame.svg
                      reps power_sys.{csv,txt} power_prog.txt
results/              flame_sys.svg flame_diff_v0_v2.svg idle_w.txt sys_idle.txt compare.md
asm/                  {v}.s {v}.matmul.dis counts.txt
```

`results/compare.md` tabulates time, instructions, cycles, IPC, cache counters, `ymm` instruction counts and both energy scopes, with a v0/v2 ratio column.

## Observed behaviour (N=512, `make quick`)

Single machine, battery power, governor `performance`; 3-run `perf stat`. Full table: `results/compare.md`.

| | v0 | v1 | v2 |
|---|---|---|---|
| Wall time (`perf stat`) | 0.58 s | 0.87 s | 0.027 s |
| Instructions | 4.42 G | 0.70 G | 0.15 G |
| IPC | 1.9 | 0.20 | 1.5 |
| L2 misses (`ic_dc`) | 137 M | 136 M | 1.6 M |
| System energy per run (battery) | 9.5 J | 17.1 J | 0.46 J |
| Package energy per run (RAPL − idle) | 2.5 ± 1.1 J | 3.5 ± 2.3 J | 0.14 ± 0.02 J |

- The compiler alone (`v1`) removes ~84% of the instructions but does not reduce runtime: the inner loop walks `B` with stride N, so it is bound by L2 misses (IPC drops to 0.2) and is not vectorised; `asm/counts.txt` shows only scalar FMA and no `ymm` code.
- Changing the loop order and blocking (`v2`) makes accesses unit-stride and cache-resident, enabling AVX2 (`vfmadd*pd` on `ymm`, four doubles per instruction): ~22× faster than `v0` and ~84× fewer L2 misses.
- System power is ≈21 W in every state, including idle: the display and platform baseline dominate, so system energy per run follows runtime rather than power. Package energy per run scales with the cycle count; its run-to-run spread for `v0`/`v1` is large at this problem size.
- At N=512 the three matrices (6 MB) fit largely in L3, which weakens the cache effect; why `v1` is slower than `v0` here was not established (hypothesis in `REPORT.md`).

## Repository layout

```
src/pipeline.c       workload (all three variants, selected by -D flags)
Makefile             build and every measurement target
scripts/stats.py     statistics, energy arithmetic, checksum check, compare.md (--selftest)
scripts/rapl.sh      one RAPL energy measurement of a command
scripts/power_prog.sh  idle baseline + repeated program-scope energy runs
scripts/power_sys.sh   battery-based system-scope energy
scripts/battery.sh   1 Hz BAT1 sampler
scripts/env.sh       governor switch (root)
docs/                design specification and implementation plan
```

## Limitations

- Single-threaded kernel; no OpenMP, no hand-written intrinsics (vectorisation is whatever GCC generates).
- Results are specific to one CPU model; AVX-512 is unavailable on this platform.
- RAPL package energy includes uncore and any concurrent activity on the machine; the idle subtraction mitigates but does not remove background noise.
- Battery-based power has coarse temporal resolution (≈3 s EC refresh) and requires the system to run unplugged.

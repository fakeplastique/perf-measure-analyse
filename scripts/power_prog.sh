#!/bin/bash
# power_prog.sh [idle]: RAPL energy of each version (RUNS runs, PAUSE s cooldown),
# idle baseline (IDLE_S s) measured before and after the block.
# Env: CORE, N. Writes results/idle.txt and results/{v}/power_prog{_raw,}.txt
cd "$(dirname "$0")/.." || exit 1
CORE=${CORE:-2}; N=${N:-1024}; R=results; mkdir -p $R
IDLE_S=${IDLE_S:-30}; RUNS=${RUNS:-5}; PAUSE=${PAUSE:-5}; COOL=${COOL:-20}
{ scripts/rapl.sh sleep "$IDLE_S"; } > $R/idle_before.txt
if [ "$1" != idle ]; then
  for v in v0 v1 v2; do
    mkdir -p $R/$v; : > $R/$v/power_prog_raw.txt
    for ((i = 0; i < RUNS; i++)); do
      scripts/rapl.sh taskset -c "$CORE" build/$v "$N" >> $R/$v/power_prog_raw.txt
      sleep "$PAUSE"
    done
  done
fi
sleep "$COOL"   # let the package cool before the closing baseline
scripts/rapl.sh sleep "$IDLE_S" > $R/idle_after.txt
# P_idle = mean(E_pkg/t) over before/after
cat $R/idle_before.txt $R/idle_after.txt | awk '{p+=$1/$3; n++} END{printf "%.4f\n", p/n}' > $R/idle_w.txt
awk '{p[NR]=$1/$3} END{d=(p[2]-p[1])/p[1]; if (d>0.3||d<-0.3) printf "WARNING: idle drift %.0f%% (before %.2f W, after %.2f W): close background apps, rerun\n", d*100, p[1], p[2]}' $R/idle_before.txt $R/idle_after.txt >&2
echo "idle_w=$(cat $R/idle_w.txt) (before: $(cat $R/idle_before.txt), after: $(cat $R/idle_after.txt))"
[ "$1" = idle ] && exit 0
for v in v0 v1 v2; do
  { echo "# rows: e_pkg_j e_core_j t_s (REPS=1, N=$N, core $CORE, runs=$RUNS); P_idle=$(cat $R/idle_w.txt) W"
    cat $R/$v/power_prog_raw.txt
    python3 scripts/stats.py net "$(cat $R/idle_w.txt)" $R/$v/power_prog_raw.txt; } > $R/$v/power_prog.txt
  echo "$v: $(tail -1 $R/$v/power_prog.txt)"
done

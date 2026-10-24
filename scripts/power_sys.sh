#!/bin/bash
# power_sys.sh VERSION : whole-system power from BAT1 (I*V) while VERSION runs
# REPS times (REPS from results/VERSION/reps). Needs AC unplugged.
cd "$(dirname "$0")/.." || exit 1
v=$1; CORE=${CORE:-2}; N=${N:-1024}; R=results
IDLE_S=${IDLE_S:-30}; PAUSE=${PAUSE:-5}; WARM=${WARM:-3}
if [ "$(cat /sys/class/power_supply/ACAD/online)" != 0 ]; then
  echo "unplug AC adapter first (ACAD online=1): battery power is only valid on battery"; exit 1
fi
reps=$(cat $R/$v/reps) || exit 1
mkdir -p $R/$v
if [ ! -s $R/sys_idle.csv ]; then   # system idle reference, once
  scripts/battery.sh $R/sys_idle.csv & bp=$!; sleep "$IDLE_S"; kill $bp; wait $bp 2>/dev/null
  echo "system idle: $(python3 scripts/stats.py battery $R/sys_idle.csv 1)" | tee $R/sys_idle.txt
fi
sleep "$PAUSE"
scripts/battery.sh $R/$v/power_sys.csv & bp=$!
sleep "$WARM"   # sampler warm-up; markers below exclude this padding from E
echo "# run_start=$(date +%s.%N)" >> $R/$v/power_sys.csv
taskset -c "$CORE" build/$v "$N" "$reps" >/dev/null
echo "# run_end=$(date +%s.%N)" >> $R/$v/power_sys.csv
sleep "$WARM"
kill $bp; wait $bp 2>/dev/null
echo "$v reps=$reps: $(python3 scripts/stats.py battery $R/$v/power_sys.csv $reps)" | tee $R/$v/power_sys.txt

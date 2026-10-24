#!/bin/bash
# sudo scripts/env.sh        -> governor=performance on all CPUs
# sudo scripts/env.sh reset  -> governor=powersave
gov=performance; [ "$1" = reset ] && gov=powersave
if [ "$EUID" -ne 0 ]; then echo "run: sudo $0 $1"; exit 1; fi
for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "$gov" > "$f"; done
echo "governor: $(sort -u /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor | tr '\n' ' ')"

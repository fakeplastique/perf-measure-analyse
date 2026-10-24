#!/bin/bash
# battery.sh OUT.csv : 1 Hz samples of BAT1 current/voltage until killed
out=$1; B=/sys/class/power_supply/BAT1
{
  echo "# $(date -Is) ac_online=$(cat /sys/class/power_supply/ACAD/online) capacity=$(cat $B/capacity)% brightness=$(cat /sys/class/backlight/*/brightness 2>/dev/null | head -1)"
  echo "# ts,current_ua,voltage_uv"
} > "$out"
while :; do
  echo "$(date +%s.%N),$(cat $B/current_now),$(cat $B/voltage_now)" >> "$out"
  sleep 1
done

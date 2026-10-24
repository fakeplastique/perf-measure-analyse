#!/bin/bash
# rapl.sh CMD... : prints "e_pkg_j e_core_j t_s" for CMD (system-wide RAPL via perf);
# t_s is perf's own duration_time, so P_idle*t does not include perf start/stop.
tmp=$(mktemp); trap 'rm -f "$tmp"' EXIT
perf stat -a -x, -e power/energy-pkg/,power_core/energy-core/,duration_time -o "$tmp" -- "$@" >/dev/null || exit 1
awk -F, '!/^#/ && NF { if ($3 ~ /energy-pkg/) p=$1; else if ($3 ~ /energy-core/) c=$1; else if ($3 ~ /duration_time/) t=$1/1e9 }
  END { if (p+0 <= 0 || t+0 <= 0) { print "rapl.sh: no RAPL/duration values from perf" > "/dev/stderr"; exit 1 }
        printf "%s %s %.3f\n", p, c, t }' "$tmp"

#!/usr/bin/env python3
"""Helpers for Lab 2 measurements: statistics, energy, checksum comparison."""
import csv
import os
import re
import statistics
import subprocess
import sys
import tempfile


def mean_std(xs):
    """Mean and sample std (n-1); std is 0.0 for a single value."""
    m = statistics.fmean(xs)
    return m, (statistics.stdev(xs) if len(xs) > 1 else 0.0)


def rel_close(a, b, tol=1e-9):
    return abs(a - b) <= tol * max(abs(a), abs(b))


def net_energy(e_pkg_j, t_s, p_idle_w):
    """Energy attributable to the program: package energy minus idle share."""
    return e_pkg_j - p_idle_w * t_s


def battery_energy(csv_path):
    """(avg watts, joules) from ts,current_ua,voltage_uv rows; P=|I|*V.
    If '# run_start=T' / '# run_end=T' markers exist, only samples inside that
    window count and E = avg_P * window (idle padding excluded). Zero-current
    rows (unreadable/stale EC) are skipped."""
    ts, ps, mark = [], [], {}
    with open(csv_path) as f:
        lines = f.read().splitlines()
    for l in lines:
        m = re.match(r"# (run_start|run_end)=([\d.]+)", l)
        if m:
            mark[m.group(1)] = float(m.group(2))
    lo, hi = mark.get("run_start", float("-inf")), mark.get("run_end", float("inf"))
    for r in csv.reader(l for l in lines if not l.startswith("#") and l.strip()):
        t, i, v = float(r[0]), float(r[1]), float(r[2])
        if i != 0 and lo <= t <= hi:
            ts.append(t)
            ps.append(abs(i) * v * 1e-12)
    if len(ts) < 2:
        raise ValueError(f"{csv_path}: need >=2 valid battery samples in the run window")
    avg = statistics.fmean(ps)
    span = (hi - lo) if mark.keys() >= {"run_start", "run_end"} else ts[-1] - ts[0]
    return avg, avg * span


def check_checksums(cs):
    """cs: {version: checksum}; raises ValueError unless all match v0 within 1e-9."""
    for v, c in cs.items():
        if not rel_close(cs["v0"], c):
            raise ValueError(f"checksum mismatch {v}: {c!r} vs v0 {cs['v0']!r}")


def _read(path):
    try:
        return open(path).read()
    except OSError:
        return ""


def _num(pattern, text):
    m = re.search(pattern, text, re.M)
    return float(m.group(1).replace(",", "")) if m else None


def _fmt(x, spec=".2f"):
    return "n/a" if x is None else format(x, spec)


def collect(v, R="results"):
    """Metrics of one version parsed from results/ and asm/ files."""
    t = _read(f"{R}/{v}/time.txt")
    st = _read(f"{R}/{v}/stat.txt")
    wall = re.search(r"Elapsed.*: (?:(\d+):)?(\d+):([\d.]+)", t)
    d = {"wall_s": (int(wall.group(1) or 0) * 3600 + int(wall.group(2)) * 60 + float(wall.group(3))) if wall else None,
         "rss_mb": (_num(r"Maximum resident set size \(kbytes\): (\d+)", t) or 0) / 1024 or None}
    for key, ev in [("instr", "instructions"), ("cycles", "cpu-cycles"), ("l1_miss", "L1-dcache-load-misses"),
                    ("l2_hit", "l2_cache_req_stat.ic_dc_hit_in_l2"), ("l2_miss", "l2_cache_req_stat.ic_dc_miss_in_l2")]:
        d[key] = _num(r"^\s*([\d,]+)\s+" + re.escape(ev), st)
    el = re.search(r"([\d.]+) \+- ([\d.]+) seconds time elapsed", st)
    d["el_s"], d["el_sd"] = (float(el.group(1)), float(el.group(2))) if el else (None, None)
    d["ipc"] = d["instr"] / d["cycles"] if d["instr"] and d["cycles"] else None
    cnt = re.search(rf"^{v} (.*)$", _read("asm/counts.txt"), re.M)
    d["ymm"] = float(re.search(r"ymm=(\d+)", cnt.group(1)).group(1)) if cnt else None
    ps = _read(f"{R}/{v}/power_sys.txt")
    d["sys_w"], d["sys_j"] = _num(r"avg_w=([\d.]+)", ps), _num(r"j_per_run=([\d.]+)", ps)
    pp = _read(f"{R}/{v}/power_prog.txt")
    d["prog_j"], d["prog_sd"] = _num(r"net_pkg_j mean=([-\d.]+)", pp), _num(r"std=([\d.]+)", pp)
    return d


def compare(R="results", N=256):
    """Verify checksums, then write results/compare.md (v0/v1/v2 table)."""
    cs = {}
    for v in ("v0", "v1", "v2"):
        out = subprocess.run([f"build/{v}", str(N)], capture_output=True, text=True, check=True).stdout
        cs[v] = float(out.split("=")[1])
    check_checksums(cs)
    m = {v: collect(v, R) for v in cs}
    rows = [("Час, с (`time -v`, 1 прогін)", "wall_s", ".2f"), ("Час, с (`perf stat -r 5`, ± SE)", "el_s", ".3f"), ("Інструкцій", "instr", ",.0f"),
            ("Циклів", "cycles", ",.0f"), ("IPC", "ipc", ".2f"), ("L1d load-misses", "l1_miss", ",.0f"),
            ("L2 hit (ic_dc)", "l2_hit", ",.0f"), ("L2 miss (ic_dc)", "l2_miss", ",.0f"),
            ("Макс. RSS, МБ", "rss_mb", ".1f"), ("`ymm`-інструкцій у matmul", "ymm", ".0f"),
            ("Система, середня P, Вт (BAT1)", "sys_w", ".2f"), ("Система, Дж/прогін (BAT1)", "sys_j", ".2f"),
            ("Програма, Дж/прогін (RAPL − idle, ± σ)", "prog_j", ".2f")]
    sd_key = {"el_s": "el_sd", "prog_j": "prog_sd"}
    lines = ["| Метрика | v0 | v1 | v2 | v0/v2 |", "|---|---|---|---|---|"]
    for label, k, spec in rows:
        a, b, c = (m[v][k] for v in ("v0", "v1", "v2"))
        ratio = _fmt(a / c, ".1f") + "×" if a and c and a > 0 and c > 0 else "n/a"
        cells = []
        for v in ("v0", "v1", "v2"):
            cell = _fmt(m[v][k], spec)
            if k in sd_key and m[v][k] is not None:
                cell += " ± " + _fmt(m[v][sd_key[k]], spec)
            cells.append(cell)
        lines.append(f"| {label} | {' | '.join(cells)} | {ratio} |")
    lines += ["", f"Checksum (N={N}) збігається у v0/v1/v2 в межах 1e-9: " + ", ".join(f"{v}={c:.12g}" for v, c in cs.items())]
    open(f"{R}/compare.md", "w").write("\n".join(lines) + "\n")
    print("\n".join(lines))


def selftest():
    assert mean_std([1, 2, 3]) == (2.0, 1.0)
    assert mean_std([5]) == (5.0, 0.0)
    assert rel_close(1.0, 1.0 + 1e-12) and not rel_close(1.0, 1.001)
    assert abs(net_energy(10.0, 2.0, 1.7) - 6.6) < 1e-9
    rows = ["# warn: test", "0,-1000000,12000000", "1,-1000000,12000000",
            "1.5,0,12000000", "2,-1000000,12000000"]
    with tempfile.NamedTemporaryFile("w", suffix=".csv", delete=False) as f:
        f.write("\n".join(rows) + "\n")
    try:
        w, j = battery_energy(f.name)
        assert abs(w - 12.0) < 1e-9 and abs(j - 24.0) < 1e-9, (w, j)
    finally:
        os.unlink(f.name)
    check_checksums({"v0": 1.0, "v1": 1.0 + 1e-12, "v2": 1.0})
    try:
        check_checksums({"v0": 1.0, "v1": 1.0, "v2": 1.001})
        raise SystemExit("mismatch not detected")
    except ValueError:
        pass
    # only samples inside run_start..run_end count (idle padding excluded), P*window = E
    rows = ["# run_start=10", "5,-1000000,12000000", "10,-2000000,12000000", "11,-2000000,12000000",
            "12,-2000000,12000000", "20,-1000000,12000000", "# run_end=12"]
    with tempfile.NamedTemporaryFile("w", suffix=".csv", delete=False) as f:
        f.write("\n".join(rows) + "\n")
    try:
        w, j = battery_energy(f.name)
        assert abs(w - 24.0) < 1e-9 and abs(j - 48.0) < 1e-9, (w, j)
    finally:
        os.unlink(f.name)
    print("selftest ok")


if __name__ == "__main__":
    if sys.argv[1:] == ["--selftest"]:
        selftest()
    elif sys.argv[1:] == ["compare"]:
        compare()
    elif sys.argv[1:2] == ["net"] and len(sys.argv) == 4:
        # net P_IDLE_W FILE: rows "e_pkg_j e_core_j t_s" -> mean/std of net pkg J
        p = float(sys.argv[2])
        rows = [list(map(float, l.split())) for l in open(sys.argv[3]) if l.strip()]
        m, sd = mean_std([net_energy(r[0], r[2], p) for r in rows])
        print(f"net_pkg_j mean={m:.3f} std={sd:.3f} n={len(rows)}")
    elif sys.argv[1:2] == ["battery"] and len(sys.argv) == 4:
        # battery CSV REPS
        w, j = battery_energy(sys.argv[2])
        print(f"avg_w={w:.3f} total_j={j:.1f} j_per_run={j / int(sys.argv[3]):.3f}")
    elif sys.argv[1:2] == ["rel_check"] and len(sys.argv) == 4:
        sys.exit(0 if rel_close(float(sys.argv[2]), float(sys.argv[3])) else 1)
    else:
        sys.exit(f"usage: {sys.argv[0]} --selftest | rel_check A B | net P_IDLE FILE | battery CSV REPS | compare")

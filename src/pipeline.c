// Lab 2 workload: gen_data -> matmul -> blur3x3 -> checksum.
// Build v0/v1: naive ijk matmul. Build v2 (-DOPT_SRC): ikj + TILE blocking.
#include <stdio.h>
#include <stdlib.h>

#ifndef TILE
#define TILE 64
#endif

#define NOINLINE __attribute__((noinline))

// Deterministic LCG fill in [0,1)
NOINLINE void gen_data(double *a, double *b, int n)
{
    unsigned long long s = 12345;
    for (long i = 0; i < (long)n * n; i++) {
        s = s * 6364136223846793005ULL + 1442695040888963407ULL;
        a[i] = (double)(s >> 11) / 9007199254740992.0;
        s = s * 6364136223846793005ULL + 1442695040888963407ULL;
        b[i] = (double)(s >> 11) / 9007199254740992.0;
    }
}

#ifndef OPT_SRC
NOINLINE void matmul(const double *restrict a, const double *restrict b,
                     double *restrict c, int n)
{
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            double s = 0.0;
            for (int k = 0; k < n; k++)
                s += a[(long)i * n + k] * b[(long)k * n + j];
            c[(long)i * n + j] = s;
        }
}
#else
static inline int imin(int x, int y) { return x < y ? x : y; }

// k ascends for every c[i][j], so summation order matches the naive version
NOINLINE void matmul(const double *restrict a, const double *restrict b,
                     double *restrict c, int n)
{
    for (long i = 0; i < (long)n * n; i++)
        c[i] = 0.0;
    for (int kk = 0; kk < n; kk += TILE)
        for (int ii = 0; ii < n; ii += TILE)
            for (int jj = 0; jj < n; jj += TILE)
                for (int i = ii; i < imin(ii + TILE, n); i++)
                    for (int k = kk; k < imin(kk + TILE, n); k++) {
                        double aik = a[(long)i * n + k];
                        for (int j = jj; j < imin(jj + TILE, n); j++)
                            c[(long)i * n + j] += aik * b[(long)k * n + j];
                    }
}
#endif

// 3x3 box blur on the interior; border copied
NOINLINE void blur3x3(const double *restrict c, double *restrict out, int n)
{
    for (long i = 0; i < (long)n * n; i++)
        out[i] = c[i];
    for (int i = 1; i < n - 1; i++)
        for (int j = 1; j < n - 1; j++) {
            double s = 0.0;
            for (int di = -1; di <= 1; di++)
                for (int dj = -1; dj <= 1; dj++)
                    s += c[(long)(i + di) * n + (j + dj)];
            out[(long)i * n + j] = s / 9.0;
        }
}

NOINLINE double checksum(const double *x, int n)
{
    double s = 0.0;
    for (long i = 0; i < (long)n * n; i++)
        s += x[i];
    return s;
}

int main(int argc, char **argv)
{
    int n = argc > 1 ? atoi(argv[1]) : 1024;
    int reps = argc > 2 ? atoi(argv[2]) : 1;
    if (n < 3 || reps < 1) {
        fprintf(stderr, "usage: %s [N>=3] [REPS>=1]\n", argv[0]);
        return 2;
    }
    size_t bytes = (size_t)n * n * sizeof(double);
    double *a = malloc(bytes), *b = malloc(bytes), *c = malloc(bytes), *o = malloc(bytes);
    if (!a || !b || !c || !o)
        return 1;
    gen_data(a, b, n);
    double sum = 0.0;
    for (int r = 0; r < reps; r++) {
        matmul(a, b, c, n);
        blur3x3(c, o, n);
        sum = checksum(o, n);
    }
    printf("checksum=%.17g\n", sum);
    return 0;
}

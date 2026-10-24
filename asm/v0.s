	.file	"pipeline.c"
	.text
.Ltext0:
	.file 0 "/home/fakeplastique/knu/sys_prog/lab2" "src/pipeline.c"
	.globl	gen_data
	.type	gen_data, @function
gen_data:
.LFB6:
	.file 1 "src/pipeline.c"
	.loc 1 14 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	.loc 1 15 24
	movq	$12345, -16(%rbp)
.LBB2:
	.loc 1 16 15
	movq	$0, -8(%rbp)
	.loc 1 16 5
	jmp	.L2
.L7:
	.loc 1 17 15
	movq	-16(%rbp), %rax
	movabsq	$6364136223846793005, %rdx
	imulq	%rdx, %rax
	.loc 1 17 11
	movabsq	$1442695040888963407, %rdx
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	.loc 1 18 27
	movq	-16(%rbp), %rax
	shrq	$11, %rax
	.loc 1 18 16
	testq	%rax, %rax
	js	.L3
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L4
.L3:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L4:
	.loc 1 18 10
	movq	-8(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	.loc 1 18 34
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	.loc 1 18 14
	movsd	%xmm0, (%rax)
	.loc 1 19 15
	movq	-16(%rbp), %rax
	movabsq	$6364136223846793005, %rdx
	imulq	%rdx, %rax
	.loc 1 19 11
	movabsq	$1442695040888963407, %rdx
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	.loc 1 20 27
	movq	-16(%rbp), %rax
	shrq	$11, %rax
	.loc 1 20 16
	testq	%rax, %rax
	js	.L5
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L6
.L5:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L6:
	.loc 1 20 10
	movq	-8(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	.loc 1 20 34
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	.loc 1 20 14
	movsd	%xmm0, (%rax)
	.loc 1 16 40 discriminator 1
	addq	$1, -8(%rbp)
.L2:
	.loc 1 16 26 discriminator 2
	movl	-36(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 16 34 discriminator 2
	movl	-36(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	.loc 1 16 24 discriminator 2
	cmpq	%rax, -8(%rbp)
	jl	.L7
.LBE2:
	.loc 1 22 1
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	gen_data, .-gen_data
	.globl	matmul
	.type	matmul, @function
matmul:
.LFB7:
	.loc 1 27 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	%ecx, -60(%rbp)
.LBB3:
	.loc 1 28 14
	movl	$0, -20(%rbp)
	.loc 1 28 5
	jmp	.L9
.L14:
.LBB4:
	.loc 1 29 18
	movl	$0, -16(%rbp)
	.loc 1 29 9
	jmp	.L10
.L13:
.LBB5:
	.loc 1 30 20
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
.LBB6:
	.loc 1 31 22
	movl	$0, -12(%rbp)
	.loc 1 31 13
	jmp	.L11
.L12:
	.loc 1 32 24
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 32 32
	movl	-60(%rbp), %eax
	cltq
	imulq	%rax, %rdx
	.loc 1 32 36
	movl	-12(%rbp), %eax
	cltq
	addq	%rdx, %rax
	.loc 1 32 23
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm1
	.loc 1 32 45
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 32 53
	movl	-60(%rbp), %eax
	cltq
	imulq	%rax, %rdx
	.loc 1 32 57
	movl	-16(%rbp), %eax
	cltq
	addq	%rdx, %rax
	.loc 1 32 44
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	.loc 1 32 41
	mulsd	%xmm1, %xmm0
	.loc 1 32 19
	movsd	-8(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	.loc 1 31 37 discriminator 1
	addl	$1, -12(%rbp)
.L11:
	.loc 1 31 31 discriminator 2
	movl	-12(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.L12
.LBE6:
	.loc 1 33 15
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 33 23
	movl	-60(%rbp), %eax
	cltq
	imulq	%rax, %rdx
	.loc 1 33 27
	movl	-16(%rbp), %eax
	cltq
	addq	%rdx, %rax
	.loc 1 33 14
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	.loc 1 33 32
	movsd	-8(%rbp), %xmm0
	movsd	%xmm0, (%rax)
.LBE5:
	.loc 1 29 33 discriminator 1
	addl	$1, -16(%rbp)
.L10:
	.loc 1 29 27 discriminator 2
	movl	-16(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.L13
.LBE4:
	.loc 1 28 29 discriminator 1
	addl	$1, -20(%rbp)
.L9:
	.loc 1 28 23 discriminator 2
	movl	-20(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.L14
.LBE3:
	.loc 1 35 1
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	matmul, .-matmul
	.globl	blur3x3
	.type	blur3x3, @function
blur3x3:
.LFB8:
	.loc 1 59 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movl	%edx, -52(%rbp)
.LBB7:
	.loc 1 60 15
	movq	$0, -16(%rbp)
	.loc 1 60 5
	jmp	.L16
.L17:
	.loc 1 61 19
	movq	-16(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	.loc 1 61 12
	movq	-16(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-48(%rbp), %rax
	addq	%rcx, %rax
	.loc 1 61 19
	movsd	(%rdx), %xmm0
	.loc 1 61 16
	movsd	%xmm0, (%rax)
	.loc 1 60 40 discriminator 1
	addq	$1, -16(%rbp)
.L16:
	.loc 1 60 26 discriminator 2
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 60 34 discriminator 2
	movl	-52(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	.loc 1 60 24 discriminator 2
	cmpq	%rax, -16(%rbp)
	jl	.L17
.LBE7:
.LBB8:
	.loc 1 62 14
	movl	$1, -32(%rbp)
	.loc 1 62 5
	jmp	.L18
.L25:
.LBB9:
	.loc 1 63 18
	movl	$1, -28(%rbp)
	.loc 1 63 9
	jmp	.L19
.L24:
.LBB10:
	.loc 1 64 20
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
.LBB11:
	.loc 1 65 22
	movl	$-1, -24(%rbp)
	.loc 1 65 13
	jmp	.L20
.L23:
.LBB12:
	.loc 1 66 26
	movl	$-1, -20(%rbp)
	.loc 1 66 17
	jmp	.L21
.L22:
	.loc 1 67 37
	movl	-32(%rbp), %edx
	movl	-24(%rbp), %eax
	addl	%edx, %eax
	.loc 1 67 28
	movslq	%eax, %rdx
	.loc 1 67 43
	movl	-52(%rbp), %eax
	cltq
	imulq	%rax, %rdx
	.loc 1 67 52
	movl	-28(%rbp), %ecx
	movl	-20(%rbp), %eax
	addl	%ecx, %eax
	cltq
	.loc 1 67 47
	addq	%rdx, %rax
	.loc 1 67 27
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	.loc 1 67 23
	movsd	-8(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	.loc 1 66 46 discriminator 1
	addl	$1, -20(%rbp)
.L21:
	.loc 1 66 38 discriminator 2
	cmpl	$1, -20(%rbp)
	jle	.L22
.LBE12:
	.loc 1 65 42 discriminator 1
	addl	$1, -24(%rbp)
.L20:
	.loc 1 65 34 discriminator 2
	cmpl	$1, -24(%rbp)
	jle	.L23
.LBE11:
	.loc 1 68 17
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 68 25
	movl	-52(%rbp), %eax
	cltq
	imulq	%rax, %rdx
	.loc 1 68 29
	movl	-28(%rbp), %eax
	cltq
	addq	%rdx, %rax
	.loc 1 68 16
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	.loc 1 68 38
	movsd	-8(%rbp), %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	.loc 1 68 34
	movsd	%xmm0, (%rax)
.LBE10:
	.loc 1 63 37 discriminator 1
	addl	$1, -28(%rbp)
.L19:
	.loc 1 63 31 discriminator 2
	movl	-52(%rbp), %eax
	subl	$1, %eax
	.loc 1 63 27 discriminator 2
	cmpl	%eax, -28(%rbp)
	jl	.L24
.LBE9:
	.loc 1 62 33 discriminator 1
	addl	$1, -32(%rbp)
.L18:
	.loc 1 62 27 discriminator 2
	movl	-52(%rbp), %eax
	subl	$1, %eax
	.loc 1 62 23 discriminator 2
	cmpl	%eax, -32(%rbp)
	jl	.L25
.LBE8:
	.loc 1 70 1
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	blur3x3, .-blur3x3
	.globl	checksum
	.type	checksum, @function
checksum:
.LFB9:
	.loc 1 73 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	.loc 1 74 12
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
.LBB13:
	.loc 1 75 15
	movq	$0, -8(%rbp)
	.loc 1 75 5
	jmp	.L27
.L28:
	.loc 1 76 15
	movq	-8(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	.loc 1 76 11
	movsd	-16(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	.loc 1 75 40 discriminator 1
	addq	$1, -8(%rbp)
.L27:
	.loc 1 75 26 discriminator 2
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 75 34 discriminator 2
	movl	-28(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	.loc 1 75 24 discriminator 2
	cmpq	%rax, -8(%rbp)
	jl	.L28
.LBE13:
	.loc 1 77 12
	movsd	-16(%rbp), %xmm0
	.loc 1 78 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	checksum, .-checksum
	.section	.rodata
.LC3:
	.string	"usage: %s [N>=3] [REPS>=1]\n"
.LC4:
	.string	"checksum=%.17g\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB10:
	.loc 1 81 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	.loc 1 82 38
	cmpl	$1, -68(%rbp)
	jle	.L31
	.loc 1 82 33 discriminator 1
	movq	-80(%rbp), %rax
	addq	$8, %rax
	.loc 1 82 24 discriminator 1
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -60(%rbp)
	jmp	.L32
.L31:
	.loc 1 82 9 discriminator 2
	movl	$1024, -60(%rbp)
.L32:
	.loc 1 83 41
	cmpl	$2, -68(%rbp)
	jle	.L33
	.loc 1 83 36 discriminator 1
	movq	-80(%rbp), %rax
	addq	$16, %rax
	.loc 1 83 27 discriminator 1
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -56(%rbp)
	jmp	.L34
.L33:
	.loc 1 83 9 discriminator 2
	movl	$1, -56(%rbp)
.L34:
	.loc 1 84 8
	cmpl	$2, -60(%rbp)
	jle	.L35
	.loc 1 84 15 discriminator 1
	cmpl	$0, -56(%rbp)
	jg	.L36
.L35:
	.loc 1 85 9
	movq	-80(%rbp), %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	leaq	.LC3(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	.loc 1 86 16
	movl	$2, %eax
	jmp	.L37
.L36:
	.loc 1 88 20
	movl	-60(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 88 30
	movl	-60(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	.loc 1 88 12
	salq	$3, %rax
	movq	%rax, -40(%rbp)
	.loc 1 89 17
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -32(%rbp)
	.loc 1 89 37 discriminator 1
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	.loc 1 89 57 discriminator 2
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -16(%rbp)
	.loc 1 89 77 discriminator 3
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	.loc 1 90 8
	cmpq	$0, -32(%rbp)
	je	.L38
	.loc 1 90 12 discriminator 1
	cmpq	$0, -24(%rbp)
	je	.L38
	.loc 1 90 18 discriminator 2
	cmpq	$0, -16(%rbp)
	je	.L38
	.loc 1 90 24 discriminator 3
	cmpq	$0, -8(%rbp)
	jne	.L39
.L38:
	.loc 1 91 16
	movl	$1, %eax
	jmp	.L37
.L39:
	.loc 1 92 5
	movl	-60(%rbp), %edx
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	gen_data
	.loc 1 93 12
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -48(%rbp)
.LBB14:
	.loc 1 94 14
	movl	$0, -52(%rbp)
	.loc 1 94 5
	jmp	.L40
.L41:
	.loc 1 95 9
	movl	-60(%rbp), %ecx
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	matmul
	.loc 1 96 9
	movl	-60(%rbp), %edx
	movq	-8(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	blur3x3
	.loc 1 97 15
	movl	-60(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	checksum
	movq	%xmm0, %rax
	movq	%rax, -48(%rbp)
	.loc 1 94 32 discriminator 1
	addl	$1, -52(%rbp)
.L40:
	.loc 1 94 23 discriminator 2
	movl	-52(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jl	.L41
.LBE14:
	.loc 1 99 5
	movq	-48(%rbp), %rax
	leaq	.LC4(%rip), %rdx
	movq	%rax, %xmm0
	movq	%rdx, %rdi
	movl	$1, %eax
	call	printf@PLT
	.loc 1 100 12
	movl	$0, %eax
.L37:
	.loc 1 101 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1128267776
	.align 8
.LC2:
	.long	0
	.long	1075970048
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/stddef.h"
	.file 3 "/usr/include/bits/types.h"
	.file 4 "/usr/include/bits/types/struct_FILE.h"
	.file 5 "/usr/include/bits/types/FILE.h"
	.file 6 "/usr/include/stdio.h"
	.file 7 "/usr/include/stdlib.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x6a3
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x13
	.long	.LASF64
	.byte	0x1d
	.byte	0x3
	.long	0x31647
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x7
	.long	.LASF9
	.byte	0x2
	.byte	0xe5
	.byte	0x17
	.long	0x3f
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x6
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x14
	.byte	0x8
	.uleb128 0x6
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x6
	.byte	0x2
	.byte	0x7
	.long	.LASF5
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x6
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0x15
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF8
	.uleb128 0x7
	.long	.LASF10
	.byte	0x3
	.byte	0x2d
	.byte	0x1b
	.long	0x3f
	.uleb128 0x7
	.long	.LASF11
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.long	0x72
	.uleb128 0x7
	.long	.LASF12
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.long	0x72
	.uleb128 0x3
	.long	0xa2
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF13
	.uleb128 0xb
	.long	0xa2
	.uleb128 0x16
	.long	.LASF65
	.byte	0xd8
	.byte	0x4
	.byte	0x33
	.byte	0x8
	.long	0x23f
	.uleb128 0x1
	.long	.LASF14
	.byte	0x35
	.byte	0x7
	.long	0x6b
	.byte	0
	.uleb128 0x1
	.long	.LASF15
	.byte	0x38
	.byte	0x9
	.long	0x9d
	.byte	0x8
	.uleb128 0x1
	.long	.LASF16
	.byte	0x39
	.byte	0x9
	.long	0x9d
	.byte	0x10
	.uleb128 0x1
	.long	.LASF17
	.byte	0x3a
	.byte	0x9
	.long	0x9d
	.byte	0x18
	.uleb128 0x1
	.long	.LASF18
	.byte	0x3b
	.byte	0x9
	.long	0x9d
	.byte	0x20
	.uleb128 0x1
	.long	.LASF19
	.byte	0x3c
	.byte	0x9
	.long	0x9d
	.byte	0x28
	.uleb128 0x1
	.long	.LASF20
	.byte	0x3d
	.byte	0x9
	.long	0x9d
	.byte	0x30
	.uleb128 0x1
	.long	.LASF21
	.byte	0x3e
	.byte	0x9
	.long	0x9d
	.byte	0x38
	.uleb128 0x1
	.long	.LASF22
	.byte	0x3f
	.byte	0x9
	.long	0x9d
	.byte	0x40
	.uleb128 0x1
	.long	.LASF23
	.byte	0x42
	.byte	0x9
	.long	0x9d
	.byte	0x48
	.uleb128 0x1
	.long	.LASF24
	.byte	0x43
	.byte	0x9
	.long	0x9d
	.byte	0x50
	.uleb128 0x1
	.long	.LASF25
	.byte	0x44
	.byte	0x9
	.long	0x9d
	.byte	0x58
	.uleb128 0x1
	.long	.LASF26
	.byte	0x46
	.byte	0x16
	.long	0x258
	.byte	0x60
	.uleb128 0x1
	.long	.LASF27
	.byte	0x48
	.byte	0x14
	.long	0x25d
	.byte	0x68
	.uleb128 0x1
	.long	.LASF28
	.byte	0x4a
	.byte	0x7
	.long	0x6b
	.byte	0x70
	.uleb128 0x17
	.long	.LASF66
	.byte	0x4
	.byte	0x4b
	.byte	0x7
	.long	0x6b
	.byte	0x18
	.value	0x3a0
	.uleb128 0x1
	.long	.LASF29
	.byte	0x4d
	.byte	0x8
	.long	0x262
	.byte	0x77
	.uleb128 0x1
	.long	.LASF30
	.byte	0x4e
	.byte	0xb
	.long	0x85
	.byte	0x78
	.uleb128 0x1
	.long	.LASF31
	.byte	0x51
	.byte	0x12
	.long	0x56
	.byte	0x80
	.uleb128 0x1
	.long	.LASF32
	.byte	0x52
	.byte	0xf
	.long	0x5d
	.byte	0x82
	.uleb128 0x1
	.long	.LASF33
	.byte	0x53
	.byte	0x8
	.long	0x262
	.byte	0x83
	.uleb128 0x1
	.long	.LASF34
	.byte	0x55
	.byte	0xf
	.long	0x272
	.byte	0x88
	.uleb128 0x1
	.long	.LASF35
	.byte	0x5d
	.byte	0xd
	.long	0x91
	.byte	0x90
	.uleb128 0x1
	.long	.LASF36
	.byte	0x5f
	.byte	0x17
	.long	0x27c
	.byte	0x98
	.uleb128 0x1
	.long	.LASF37
	.byte	0x60
	.byte	0x19
	.long	0x286
	.byte	0xa0
	.uleb128 0x1
	.long	.LASF38
	.byte	0x61
	.byte	0x14
	.long	0x25d
	.byte	0xa8
	.uleb128 0x1
	.long	.LASF39
	.byte	0x62
	.byte	0x9
	.long	0x4d
	.byte	0xb0
	.uleb128 0x1
	.long	.LASF40
	.byte	0x63
	.byte	0x15
	.long	0x28b
	.byte	0xb8
	.uleb128 0x1
	.long	.LASF41
	.byte	0x64
	.byte	0x7
	.long	0x6b
	.byte	0xc0
	.uleb128 0x1
	.long	.LASF42
	.byte	0x66
	.byte	0x7
	.long	0x6b
	.byte	0xc4
	.uleb128 0x1
	.long	.LASF43
	.byte	0x68
	.byte	0xe
	.long	0x79
	.byte	0xc8
	.uleb128 0x1
	.long	.LASF44
	.byte	0x6d
	.byte	0x8
	.long	0x290
	.byte	0xd0
	.byte	0
	.uleb128 0x7
	.long	.LASF45
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0xae
	.uleb128 0x18
	.long	.LASF67
	.byte	0x4
	.byte	0x2d
	.byte	0xe
	.uleb128 0x9
	.long	.LASF46
	.uleb128 0x3
	.long	0x253
	.uleb128 0x3
	.long	0xae
	.uleb128 0xc
	.long	0xa2
	.long	0x272
	.uleb128 0xd
	.long	0x3f
	.byte	0
	.byte	0
	.uleb128 0x3
	.long	0x24b
	.uleb128 0x9
	.long	.LASF47
	.uleb128 0x3
	.long	0x277
	.uleb128 0x9
	.long	.LASF48
	.uleb128 0x3
	.long	0x281
	.uleb128 0x3
	.long	0x25d
	.uleb128 0xc
	.long	0xa2
	.long	0x2a0
	.uleb128 0xd
	.long	0x3f
	.byte	0x7
	.byte	0
	.uleb128 0x3
	.long	0xa9
	.uleb128 0x3
	.long	0x23f
	.uleb128 0x19
	.long	.LASF68
	.byte	0x6
	.byte	0x9b
	.byte	0xe
	.long	0x2a5
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF49
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF50
	.uleb128 0xa
	.long	.LASF51
	.byte	0x6
	.value	0x172
	.byte	0xc
	.long	0x6b
	.long	0x2dc
	.uleb128 0x8
	.long	0x2a0
	.uleb128 0xe
	.byte	0
	.uleb128 0xa
	.long	.LASF52
	.byte	0x7
	.value	0x2a4
	.byte	0xe
	.long	0x4d
	.long	0x2f3
	.uleb128 0x8
	.long	0x3f
	.byte	0
	.uleb128 0xa
	.long	.LASF53
	.byte	0x6
	.value	0x16c
	.byte	0xc
	.long	0x6b
	.long	0x310
	.uleb128 0x8
	.long	0x2a5
	.uleb128 0x8
	.long	0x2a0
	.uleb128 0xe
	.byte	0
	.uleb128 0x1a
	.long	.LASF54
	.byte	0x7
	.byte	0x6d
	.byte	0xc
	.long	0x6b
	.long	0x326
	.uleb128 0x8
	.long	0x2a0
	.byte	0
	.uleb128 0x1b
	.long	.LASF60
	.byte	0x1
	.byte	0x50
	.byte	0x5
	.long	0x6b
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x3ee
	.uleb128 0xf
	.long	.LASF55
	.byte	0x50
	.byte	0xe
	.long	0x6b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0xf
	.long	.LASF56
	.byte	0x50
	.byte	0x1b
	.long	0x3ee
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x2
	.string	"n"
	.byte	0x52
	.byte	0x9
	.long	0x6b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.uleb128 0x10
	.long	.LASF57
	.byte	0x53
	.byte	0x9
	.long	0x6b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x10
	.long	.LASF58
	.byte	0x58
	.byte	0xc
	.long	0x33
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x2
	.string	"a"
	.byte	0x59
	.byte	0xd
	.long	0x3f3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x2
	.string	"b"
	.byte	0x59
	.byte	0x21
	.long	0x3f3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x2
	.string	"c"
	.byte	0x59
	.byte	0x35
	.long	0x3f3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x2
	.string	"o"
	.byte	0x59
	.byte	0x49
	.long	0x3f3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x2
	.string	"sum"
	.byte	0x5d
	.byte	0xc
	.long	0x3fd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x4
	.quad	.LBB14
	.quad	.LBE14-.LBB14
	.uleb128 0x2
	.string	"r"
	.byte	0x5e
	.byte	0xe
	.long	0x6b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.byte	0
	.byte	0
	.uleb128 0x3
	.long	0x9d
	.uleb128 0x3
	.long	0x3fd
	.uleb128 0x11
	.long	0x3f3
	.uleb128 0x6
	.byte	0x8
	.byte	0x4
	.long	.LASF59
	.uleb128 0xb
	.long	0x3fd
	.uleb128 0x1c
	.long	.LASF61
	.byte	0x1
	.byte	0x48
	.byte	0x11
	.long	0x3fd
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x46e
	.uleb128 0x5
	.string	"x"
	.byte	0x48
	.byte	0x28
	.long	0x46e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x5
	.string	"n"
	.byte	0x48
	.byte	0x2f
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x2
	.string	"s"
	.byte	0x4a
	.byte	0xc
	.long	0x3fd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x4
	.quad	.LBB13
	.quad	.LBE13-.LBB13
	.uleb128 0x2
	.string	"i"
	.byte	0x4b
	.byte	0xf
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x3
	.long	0x404
	.uleb128 0x11
	.long	0x46e
	.uleb128 0x12
	.long	.LASF62
	.byte	0x3a
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x576
	.uleb128 0x5
	.string	"c"
	.byte	0x3a
	.byte	0x2e
	.long	0x473
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x5
	.string	"out"
	.byte	0x3a
	.byte	0x42
	.long	0x3f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x5
	.string	"n"
	.byte	0x3a
	.byte	0x4b
	.long	0x6b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x1d
	.quad	.LBB7
	.quad	.LBE7-.LBB7
	.long	0x4dd
	.uleb128 0x2
	.string	"i"
	.byte	0x3c
	.byte	0xf
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x4
	.quad	.LBB8
	.quad	.LBE8-.LBB8
	.uleb128 0x2
	.string	"i"
	.byte	0x3e
	.byte	0xe
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x4
	.quad	.LBB9
	.quad	.LBE9-.LBB9
	.uleb128 0x2
	.string	"j"
	.byte	0x3f
	.byte	0x12
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x4
	.quad	.LBB10
	.quad	.LBE10-.LBB10
	.uleb128 0x2
	.string	"s"
	.byte	0x40
	.byte	0x14
	.long	0x3fd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x4
	.quad	.LBB11
	.quad	.LBE11-.LBB11
	.uleb128 0x2
	.string	"di"
	.byte	0x41
	.byte	0x16
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x4
	.quad	.LBB12
	.quad	.LBE12-.LBB12
	.uleb128 0x2
	.string	"dj"
	.byte	0x42
	.byte	0x1a
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.long	.LASF63
	.byte	0x19
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x63d
	.uleb128 0x5
	.string	"a"
	.byte	0x19
	.byte	0x2d
	.long	0x473
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x5
	.string	"b"
	.byte	0x19
	.byte	0x47
	.long	0x473
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x5
	.string	"c"
	.byte	0x1a
	.byte	0x27
	.long	0x3f8
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x5
	.string	"n"
	.byte	0x1a
	.byte	0x2e
	.long	0x6b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.uleb128 0x4
	.quad	.LBB3
	.quad	.LBE3-.LBB3
	.uleb128 0x2
	.string	"i"
	.byte	0x1c
	.byte	0xe
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x4
	.quad	.LBB4
	.quad	.LBE4-.LBB4
	.uleb128 0x2
	.string	"j"
	.byte	0x1d
	.byte	0x12
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x4
	.quad	.LBB5
	.quad	.LBE5-.LBB5
	.uleb128 0x2
	.string	"s"
	.byte	0x1e
	.byte	0x14
	.long	0x3fd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x4
	.quad	.LBB6
	.quad	.LBE6-.LBB6
	.uleb128 0x2
	.string	"k"
	.byte	0x1f
	.byte	0x16
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	.LASF69
	.byte	0x1
	.byte	0xd
	.byte	0xf
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x5
	.string	"a"
	.byte	0xd
	.byte	0x20
	.long	0x3f3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x5
	.string	"b"
	.byte	0xd
	.byte	0x2b
	.long	0x3f3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x5
	.string	"n"
	.byte	0xd
	.byte	0x32
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x2
	.string	"s"
	.byte	0xf
	.byte	0x18
	.long	0x2bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x4
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x2
	.string	"i"
	.byte	0x10
	.byte	0xf
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 15
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x90
	.uleb128 0xb
	.uleb128 0x91
	.uleb128 0x6
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0x6b
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF51:
	.string	"printf"
.LASF11:
	.string	"__off_t"
.LASF15:
	.string	"_IO_read_ptr"
.LASF52:
	.string	"malloc"
.LASF27:
	.string	"_chain"
.LASF9:
	.string	"size_t"
.LASF61:
	.string	"checksum"
.LASF33:
	.string	"_shortbuf"
.LASF21:
	.string	"_IO_buf_base"
.LASF50:
	.string	"long long unsigned int"
.LASF36:
	.string	"_codecvt"
.LASF49:
	.string	"long long int"
.LASF6:
	.string	"signed char"
.LASF28:
	.string	"_fileno"
.LASF16:
	.string	"_IO_read_end"
.LASF8:
	.string	"long int"
.LASF14:
	.string	"_flags"
.LASF22:
	.string	"_IO_buf_end"
.LASF31:
	.string	"_cur_column"
.LASF47:
	.string	"_IO_codecvt"
.LASF59:
	.string	"double"
.LASF30:
	.string	"_old_offset"
.LASF35:
	.string	"_offset"
.LASF58:
	.string	"bytes"
.LASF46:
	.string	"_IO_marker"
.LASF29:
	.string	"_short_backupbuf"
.LASF3:
	.string	"unsigned int"
.LASF39:
	.string	"_freeres_buf"
.LASF53:
	.string	"fprintf"
.LASF2:
	.string	"long unsigned int"
.LASF19:
	.string	"_IO_write_ptr"
.LASF5:
	.string	"short unsigned int"
.LASF23:
	.string	"_IO_save_base"
.LASF34:
	.string	"_lock"
.LASF66:
	.string	"_flags2"
.LASF41:
	.string	"_mode"
.LASF20:
	.string	"_IO_write_end"
.LASF40:
	.string	"_prevchain"
.LASF67:
	.string	"_IO_lock_t"
.LASF65:
	.string	"_IO_FILE"
.LASF68:
	.string	"stderr"
.LASF10:
	.string	"__uint64_t"
.LASF64:
	.string	"GNU C23 16.2.1 20260810 -mtune=generic -march=x86-64 -g -O0 -fno-omit-frame-pointer"
.LASF26:
	.string	"_markers"
.LASF54:
	.string	"atoi"
.LASF4:
	.string	"unsigned char"
.LASF7:
	.string	"short int"
.LASF48:
	.string	"_IO_wide_data"
.LASF32:
	.string	"_vtable_offset"
.LASF45:
	.string	"FILE"
.LASF63:
	.string	"matmul"
.LASF13:
	.string	"char"
.LASF12:
	.string	"__off64_t"
.LASF17:
	.string	"_IO_read_base"
.LASF25:
	.string	"_IO_save_end"
.LASF44:
	.string	"_unused2"
.LASF42:
	.string	"_unused3"
.LASF56:
	.string	"argv"
.LASF24:
	.string	"_IO_backup_base"
.LASF57:
	.string	"reps"
.LASF55:
	.string	"argc"
.LASF62:
	.string	"blur3x3"
.LASF38:
	.string	"_freeres_list"
.LASF69:
	.string	"gen_data"
.LASF37:
	.string	"_wide_data"
.LASF60:
	.string	"main"
.LASF18:
	.string	"_IO_write_base"
.LASF43:
	.string	"_total_written"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/fakeplastique/knu/sys_prog/lab2"
.LASF0:
	.string	"src/pipeline.c"
	.ident	"GCC: (GNU) 16.2.1 20260810"
	.section	.note.GNU-stack,"",@progbits

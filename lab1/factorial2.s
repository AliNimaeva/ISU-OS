	.file	"factorial.c"
	.text
	.p2align 4
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	je	.L4
	movl	$1, %eax
	movl	$1, %edx
	.p2align 4,,10
	.p2align 3
.L3:
	imull	%eax, %edx
	addl	$1, %eax
	movl	%edx, %r8d
	cmpl	%eax, %edi
	jnb	.L3
	movl	%r8d, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$1, %r8d
	movl	%r8d, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

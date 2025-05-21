	.file	"factorial.c"
	.text
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
.L3:
	imull	%eax, %edx
	addl	$1, %eax
	cmpl	%eax, %edi
	jnb	.L3
.L2:
	movl	%edx, %eax
	ret
.L4:
	movl	$1, %edx
	jmp	.L2
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

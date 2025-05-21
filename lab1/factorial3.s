	.file	"factorial.c"
	.text
	.p2align 4
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc			;начало проц
	endbr64
	testl	%edi, %edi		;n==0?
	je	.L4					;если да, то переход на L4
	movl	$1, %eax		;счетчик = 1 (i)
	movl	$1, %edx		;факториал = 1 (fact)
	.p2align 4,,10
	.p2align 3
.L3:
	imull	%eax, %edx		;fact *= i
	addl	$1, %eax		;i++
	movl	%edx, %r8d		;сохранение промежуточного рез-та
	cmpl	%eax, %edi		;сравнение i и n
	jnb	.L3					;если i <= n, то продолжение цикла
	movl	%r8d, %eax		;перенос результата в возвращаемое значение
	ret						;выход из функции
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$1, %r8d		;fact = 1 (n=0)
	movl	%r8d, %eax		;возвращаемое равно 1
	ret						;выход
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

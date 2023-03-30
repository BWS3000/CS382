	.arch armv8-a
	.file	"test.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w0, 10
	str	w0, [sp, 4]
	mov	w0, 15
	str	w0, [sp, 8]
	ldr	w1, [sp, 4]
	ldr	w0, [sp, 8]
	add	w0, w1, w0
	str	w0, [sp, 12]
	ldr	w0, [sp, 12]
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-5ubuntu1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits

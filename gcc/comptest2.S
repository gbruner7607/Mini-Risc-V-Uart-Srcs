.global main
main:
	li a0, 0
	li a1, 0
	xor a0,x0,x0
	xor a1,x0,x0
	addi a0,a0,10
	nop
	add a1, a1, a0
	beq a0, a1, cont
	ret
cont:
	nop
	nop
	nop
	xor a0,a0,a1
	ret

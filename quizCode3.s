.section .rodata
addsubResp2: .asciz "r4 = %d, r5 = %d, r6 = %d\n"

.section .text
.global main
main:
	push {lr}

	MOV r0, #5
	MOV r1, #8
	ADD r4, r0, r1
	MUL r5, r4, r1
	SUB r6, r5, r0

	LDR r0, =addsubResp2
	MOV r1, r4
	MOV r2, r5
	MOV r3, r6
	bl printf

	MOV r0, #0
	pop {pc}

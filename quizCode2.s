.section .rodata
addsubResp: .asciz "r4 = %d, r5 = %d, r6 = %d\n"

.section .text
.global main
main:
	push {lr}

	MOV r0, #18
	MOV r1, #17
	ADD r4, r0, r0
	ADD r5, r1, r1
	SUB r6, r5, r4

	ldr r0, =addsubResp
	MOV r1, r4
	MOV r2, r5
	MOV r3, r6
	bl printf

	MOV r0, #0
	pop {pc} 

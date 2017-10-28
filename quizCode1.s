// and orr eor

.section .rodata

aoeOutput: .asciz "The and= %d, the orr= %d, the eor= %d\n"

.section .data
v1: .word 0
v2: .word 0
v3: .word 0

.global main
.section .text
main:
	push {lr}

	MOV r0, #101
	MOV r1, #1
	LDR r4, =v1
	LDR r5, =v2
	LDR r6, =v3
	AND r4, r0, r1
	ORR r5, r0, r1
	EOR r6, r0, r1

	ldr r0, =aoeOutput
	mov r1, r4
	mov r2, r5
	mov r3, r6
	//ldr r1, =v1
	//ldr r1, [r1]
	//ldr r2, =v2
	//ldr r2, [r2]
	//ldr r3, =v3
	//ldr r3, [r3]
	bl printf

	mov r0, #0
	pop {pc}

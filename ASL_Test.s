.global main

.section .rodata
response: .asciz "mov r1, r1, asl #3  ->  %d\n"

.section .text
main:
	PUSH {lr}		//save return address

	MOV r1, #4		//set value 2 in register 1
	MOV r1, r1, ASL #3	// what do?

	LDR r0, =response	//set the response to register 0
	BL printf		//print the reponse

	MOV r0, #0		//exit the program with zero
	POP {pc}

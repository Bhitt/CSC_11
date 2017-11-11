//This is to test r1, r2, asr #4 for output
.global main

.section .rodata
response: .asciz "add r1, r2 asr #4  -> %d\n"

.section .text

main:
	PUSH {lr}		//save return address

	MOV r4, #5		//move 5 into register r4
	MOV r5, #64		//move 64 into register r5
	ADD r4, r5, ASR #4	// what do?

	LDR r0, =response	//load pointer to response
	MOV r1, r4		//mov value of r4 into r1
	BL printf		//print the response

	MOV r0, #0		//exit program with 0
	POP {pc}


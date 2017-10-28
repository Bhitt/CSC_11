.global main
// sum of numbers, sum of squares
.section .rodata
// prompt message
posIntPrompt: .asciz "Enter in a positive integer value ( >= 1)\n"

// response message
sumIntsResp: .asciz "The sum of numbers from 1 to %d is %d\n"
sumSqrsResp: .asciz "The sum of squares from 1 to %d is %d\n"
testResp: .asciz "counter = %d, userInp = %d, sumTotal = %d\n"

// format pattern for scanf
pattern: .asciz "%d"

.section .data
userInp: .word	0
counter: .word	1
sumTotal: .word	0

.section .text
main:
	PUSH {lr}		//save return address
validate:
	LDR r0, =posIntPrompt	//r0 is given pointer to prompt message
	BL printf		//call printf to output the message

	LDR r0, =pattern	//load pointer to pattern into r0
	LDR r1, =userInp	//load pointer to userInp into r1
	BL scanf		//call scanf to read in number

	LDR r0, =userInp	//load pointer to userInp in r0
	LDR r0, [r0]		//dereference value into r0
	MOV r1, #0		//set r1 to 0
	CMP r0, r1		//compare r0 and r1
	BLE validate		//if r0 <= r1 branch to validate

	MOV r1, #1		//throw counter 1 into r1
	MOV r2, #0		//set total 0 in r2

sum_while:

	CMP r1, r0		//compare counter to userInp
	BGT done_1		//if counter > userInp branch to done_1

	ADD r2, r2, r1		//else add counter into r2
	ADD r1, r1, #1		//increment counter by 1

	BAL sum_while		//branch to top of loop to compare again
done_1:

	LDR r0, =sumTotal	//load r0 with pointer to sumTotal
	STR r2, [r0]		//str r2 value into sumTotal

	LDR r0, =sumIntsResp	//load r0 with pointer to sumIntsResp
	LDR r1, =userInp	//load r1 with userInp
	LDR r1, [r1]
	LDR r2, =sumTotal	//load r2 with sumTotal
	LDR r2, [r2]
	BL printf		//print to screen

	LDR r0, =userInp	//grab user input
	LDR r0, [r0]
	MOV r1, #1		//set counter to 1
	MOV r2, #0		//set r2 to 0

sum_while_2:

	CMP r1, r0		//compare counter to userInp
	BGT done_2		//if counter > userInp branch to done_2

	MLA r2, r1, r1, r2	// r2 = (r1 *r1) +r2
	ADD r1, r1, #1		//increment counter by 1

	BAL sum_while_2		//branch to top of loop to compare again
done_2:
	LDR r0, =sumTotal	//grab sumTotal
	STR r2, [r0]		//store sum of squares into sumTotal

	LDR r0, =sumSqrsResp	//load pointer to sumSqrsResp
	LDR r1, =userInp	//load r1 with userInp
	LDR r1, [r1]
	LDR r2, =sumTotal	//load r2 with sumTotal
	LDR r2, [r2]
	BL printf		//print to screen

	mov r0, #0		//exit program with 0
	pop {pc}

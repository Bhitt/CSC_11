.section .rodata
/* Prompt message */
prompt: .asciz "Enter an integer for first number:"
prompt2: .asciz "Enter an integer for second number:"

/* Response message */
response: .asciz "Your first number is %d\n\n"
response2: .asciz "Your second number is %d\n\n"
response3: .asciz "The sum of %d and %d is %d\n\n"
response4: .asciz "The difference of %d and %d is %d\n\n"
response5: .asciz "The product of %d and %d is %d\n\n"

/*  Format pattern for scanf */
pattern: .asciz "%d"

.section .data
/* Where scanf will store the number read */
v1: .word 0
v2: .word 0
v3: .word 0
v4: .word 0
v5: .word 0

.section .text
.global main
main:
	push {lr}		/*save our return address */

	ldr r0, =prompt		/*r0 contains pointer to prompt message */
	bl printf		/*call printf to output the first prompt */

	ldr r0, =pattern	/*r0 contains pointer to format string for pattern*/
	ldr r1, =v1		/*r1 contains pointer to var label where # stored*/
	bl scanf		/*call to scanf*/

	ldr r0, =response	/*r0 contains pointer to response message */
	ldr r1, =v1		/*r1 contains pointer to v1*/
	ldr r1, [r1]		/*r1 contains val deref from r1 in prev instr*/
	bl printf		/*call printf to output response*/

	ldr r0, =prompt2	/*r0 contains pointer to prompt2 message */
	bl printf		/*call printf to output the second prompt */

	ldr r0, =pattern	/*repeat previous steps to get second input*/
	ldr r1, =v2
	bl scanf

	ldr r0, =response2
	ldr r1, =v2
	ldr r1, [r1]
	bl printf

	ldr r0, =v1		/*set r0 to address of v1*/
	ldr r1, =v2		/*set r1 to address of v2*/
	ldr r2, =v3		/*set r2 to address of v3*/
	ldr r3, =v4		/*set r3 to address of v4*/
	ldr r4, =v5		/*set r4 to address of v5*/

	ldr r0, [r0]		/*grab the value of v1*/
	ldr r1, [r1]		/*grab the value of v2*/

	ADD r5, r0, r1		/*r5 = r0 + r1 */
	STR r5, [r2]		/*store value of r5 into v3*/

	SUB r5, r0, r1		/*r5 = r0 - r1 */
	STR r5, [r3]		/*store value of r5 into v4*/

	MUL r5, r0, r1		/*r5 = r0 * r1 */
	STR r5, [r4]		/*store value of r5 into v5*/

	ldr r0, =response3	/*r0 contains pointer to response3*/
	ldr r1, =v1		/*r1 contains pointer to v1*/
	ldr r2, =v2		/*r2 contains pointer to v2*/
	ldr r3, =v3		/*r3 contains pointer to v3*/
	ldr r1, [r1]		/*grab value of v1*/
	ldr r2, [r2]		/*grab value of v2*/
	ldr r3, [r3]		/*grab value of v3*/
	bl printf 		/*output sum */

	ldr r0, =response4	/*repeat above for output of v4*/
	ldr r1, =v1
	ldr r2, =v2
	ldr r3, =v4
	ldr r1, [r1]
	ldr r2, [r2]
	ldr r3, [r3]
	bl printf		/*output difference*/

	ldr r0, =response5	/*repeat above for output of v5*/
	ldr r1, =v1
	ldr r2, =v2
	ldr r3, =v5
	ldr r1, [r1]
	ldr r2, [r2]
	ldr r3, [r3]
	bl printf		/*output product*/

	mov r0, #0		/*exit code 0 = program terminated normally*/
	pop {pc}		/*exit our main function */

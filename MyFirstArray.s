.text
.balign 4
.global main
main:
	push {lr}		// save the return address

	ldr r1, =a		// r1 points to beginning of array a[0]
	mov r2, #0

a_loop:		// populate array a of 100 bytes (25 words - 4 bytes a word)
	cmp r2, #100		// 100 bytes filled?
	beq a_done		// if equal branch to a_done
	strb r2, [r1,+r2]	// store content of r2 at [r1+r2]
	add r2, #1		// increment r2 by 1
	bal a_loop		// jump to start of loop

a_done:		// output contents of the array with a function name output_array
	ldr r0, =a		// r0 contains base address of a
	mov r1, #100		// r1 contains number of elements in the array
	bl output_array
	pop {pc}

output_array:
	push {r4,r5,lr}
	mov r4, #0		// r4 contains starting index for output
oa_loop:
	cmp r4, r1		// is r4 equal to the number of elements to output?
	beq oa_done		// if so, then done looping
	push {r0-r3}		// save the current state of registers since printf won't
	ldrb r2, [r0,+r4]	// r1 contains a [r0+r4]
	mov r1, r4		// output index as well
	ldr r0, =output_str	// r0 contains pointer to output string
	bl printf

	pop {r0-r3}		// restore state of registers r0-r3 after printf call
	add r4, #1		// increment index by 1
	bal oa_loop		// jump back to beginning of loop

oa_done:
	pop {r4,r5,pc}

.data
.balign 4

a: .skip 100 // array of 100 bytes (no initialization)

output_str: .asciz "a[%d]=%d\n"

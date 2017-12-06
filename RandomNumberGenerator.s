//-------------------------------
// Random number generator (0-999)
//--------------------------------
.equ LOW, 0
.equ HIGH, 1
.equ INPUT, 0
.equ OUTPUT, 1

.equ INDEX_TACTILE, 4		// wipi pin 4 - bcm 23
.equ EXIT_TACTILE, 5		// wipi pin 5 - bcm 24
.equ LED_GREEN, 0		// wipi pin 0 - bcm 17
.equ LED_BLUE, 2		// wipi pin 2 - bcm 27
.equ LED_YELLOW, 3		// wipi pin 3 - bcm 22

.text
.balign 4
.global main
main:
	push {lr}		// save return address
	bl wiringPiSetup	// import library for wiring pi

	bl create_array		// create the array and set values to 0-999 

	bl led_setup		// setup the LED's for input/output

	bl greeting_fun		// call welcome function

	bl randoming_function	// random numbers til done

	bl exit_function	// finishing touches

	mov r0, #0		//exit the program
	pop {pc}

//------------------------//
// Grab number function	  //
//------------------------//
grab_num:
	push {r4,lr}
	push {r0-r3}		// save the current state of registers since printf won't

	mov r2, r1
	ldrb r2, [r0,+r4]	// r1 contains a[r0+r4]
	ldr r0, =output_str	// r0 contains pointer to output string
	bl printf

	mov r0, #LED_BLUE	// turn off blue LED during the delay
	mov r1, #INPUT
	bl digitalWrite

	mov r0, #LED_YELLOW	// light the yellow LED during the delay
	mov r1, #OUTPUT
	bl digitalWrite

	ldr r0, =#1000		// delay another button press for 3 seconds
	bl delay

	mov r0, #LED_YELLOW	// turn off the yellow LED
	mov r1, #INPUT
	bl digitalWrite

	mov r0, #LED_BLUE	// relight the blue LED
	mov r1, #OUTPUT
	bl digitalWrite

	pop {r0-r3}		// restore state of registers r0-r3 after printf call
	pop {r4,pc}
//-----------------------//
//   greeting function   //
//-----------------------//
greeting_fun:
	push {lr}

	ldr r0, =welcome_str	// print out welcome string
	bl printf

	mov r0, #LED_GREEN	// light the green LED while the program is running
	mov r1, #OUTPUT
	bl digitalWrite

	mov r0, #LED_BLUE	// light the blue LED during the rand loop
	mov r1, #OUTPUT
	bl digitalWrite

	pop {pc}

//------------------------//
//  create array function //
//------------------------//
create_array:
	push {lr}
	ldr r1, =a		// r1 points to beginning of array a[0]
	mov r2, #0		// array index starts at zero

array_fill_loop:		// populate array 'a' of 1000 bytes (250 words - 4 bytes a word)
	cmp r2, #1000		// 1000 bytes filled?
	beq array_fill_done	// stop looping if done filling array
	strb r2, [r1,+r2]	// store content of r2 at a[r1+r2]
	add r2, #1		// increment r2 by 1
	bal array_fill_loop	// jump to start of loop

array_fill_done:
	pop {pc}

//------------------------//
//   LED setup function   //
//------------------------//
led_setup:
	push {lr}

	mov r0, #INDEX_TACTILE	// set up button for index input
	mov r1, #INPUT
	bl pinMode

	mov r0, #EXIT_TACTILE	// set up button for exit input
	mov r1, #INPUT
	bl pinMode

	mov r0, #LED_GREEN	// set up led for output
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #LED_BLUE	//set up led for output
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #LED_YELLOW	//set up led for output
	mov r1, #OUTPUT
	bl pinMode

	pop {pc}

//-------------------------//
//  Randoming function	   //
//-------------------------//
randoming_function:
	push {lr}

rand_loop:
	mov r0, #EXIT_TACTILE	// check to see if the exit button is pressed
	bl digitalRead
	cmp r0, #HIGH		// if the index button is presed
	beq rand_done		//exit the program

	mov r0, #INDEX_TACTILE  // check to see if the index button is pressed
	bl digitalRead
	mov r4, r0

	mov r0, #LED_YELLOW	// light up red LED if index button is pressed
	mov r1, r4
	bl digitalWrite

	mov r1, r5 		// save the index value into r1
	cmp r4, #HIGH		// check for button press
	bleq grab_num		// if button pressed, run function grab_num

	add r5, #1		// increment index in r5 by 1
	cmp r5, #1000		// keep index in array bounds by looping back to zero
	moveq r5, #0

	bal rand_loop		// jump to beginning of random number loop
rand_done:
	pop {pc}

//-------------------------//
//     Exit function       //
//-------------------------//
exit_function:
	push {lr}

	ldr r0, =exit_str	// print out exit message
	bl printf

	mov r0, #LED_BLUE	// turn off blue light if needed
	mov r1, #INPUT
	bl digitalWrite

	mov r0, #LED_GREEN	//turn off green LED
	mov r1, #INPUT
	bl digitalWrite

	pop {pc}

//-------------------------//
// data variables go here

.data
.balign 4

a: .skip 1000			// array of 1000 bytes (no initialization)

output_str: .asciz "Your random number is %d\n"
welcome_str: .asciz "Press the top button to random a number from 0 to 999\n"
exit_str: .asciz "Goodbye friend\n"

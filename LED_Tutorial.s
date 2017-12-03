.equ LOW, 0
.equ HIGH, 1
.equ INPUT, 0
.equ OUTPUT, 1

.equ LED_TACTILE, 4		// wipi pin 4 - bcm 23
.equ EXIT_TACTILE, 5		// wipi pin 5 - bcm 24
.equ LED_GREEN, 0		// wipi pin 0 - bcm 17
.equ LED_BLUE, 2		// wipi pin 2 - bcm 27
.equ LED_YELLOW, 3		// wipi pin 3 - bcm 22

.data
out_msg: .asciz "%d\n"

.text
.global main
main:
	push {lr}
	bl wiringPiSetup		// import library

	mov r0, #LED_TACTILE		// set up button for led input
	mov r1, #INPUT
	bl pinMode

	mov r0, #EXIT_TACTILE		// set up second button for exit input
	mov r1, #INPUT
	bl pinMode

	mov r0, #LED_GREEN		// set up led for output
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #LED_BLUE		// set up led for output
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #LED_YELLOW		// set up led for output
	mov r1, #OUTPUT
	bl pinMode

whl_loop:	// while the exit button has not been pressed
	mov r0, #EXIT_TACTILE	// check signal of exit button
	bl digitalRead
	cmp r0, #HIGH
	beq whl_done		// if exit button is pressed then branch to done

	mov r0, #LED_TACTILE	// check if led button is being pressed
	bl digitalRead
	mov r4, r0

	mov r1, r0
	ldr r0, =out_msg	// output state of led button (if pressed 1, else 0)
	bl printf

	mov r0, #LED_GREEN	// light led if button is pressed
	mov r1, r4
	bl digitalWrite

	mov r0, #LED_BLUE	//light led if button is pressed
	mov r1, r4
	bl digitalWrite

	mov r0, #LED_YELLOW	//light led if button is pressed
	mov r1, r4
	bl digitalWrite

	bal whl_loop		// jump to beginning of loop
whl_done:
	mov r0, #0		//exit program
	pop {pc}


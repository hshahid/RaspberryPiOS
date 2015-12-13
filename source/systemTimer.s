//code that interacts with the system timer and implements the wait functions

//return base address of the system timer region as a physical address in a register
.globl GetSystemTimerBase
GetSystemTimerBase: 
	ldr r0,=0x20003000
	mov pc,lr


//get current timestamp of the timer and save it in specified registers
.globl GetTimeStamp
GetTimeStamp:
	push {lr}
	bl GetSystemTimerBase
	ldrd r0,r1,[r0,#4]
	pop {pc}


//wait a specified number of microseconds before running
.globl Wait
Wait:
	delay .req r2
	mov delay,r0	
	push {lr}
	bl GetTimeStamp
	start .req r3
	mov start,r0

	loop$:
		bl GetTimeStamp
		elapsed .req r1
		sub elapsed,r0,start
		cmp elapsed,delay
		.unreq elapsed
		bls loop$
		
	.unreq delay
	.unreq start
	pop {pc}

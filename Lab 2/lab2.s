@ ARM Assembly - lab 2

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	
	@ Write YOUR CODE HERE
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------

	mov r5,#0				@ Sum = 0	
	mov r1,#0				@ i = 0

Loop_1:	
	cmp r1,#10		
	bge Exit				@ jump to Exit lable if i is greater than or equal 10 
	mov r2,#5       		@ j = 5
	

Loop_2:						@ inside for loop	

	cmp r2,#15	
	bge Exit_Inside_Loop	@ jump to Exit_Inside_Loop if j is greater than or equal 15
	
	add r3,r1,r2			@ i + j
	
	cmp r3,#10				@ if statement
	bge Else				@ jump to Else lable if (i+j) is greater than or equal 10
	
	add r5,r5,r1,lsl #1		@ Sum = Sum + i*2
	
	b Exit_if_else			@ jump to Exit_if_else lable	


Else:						@ else statement

	and r4,r1,r2			@ i & j
	add r5,r5,r4			@ Sum = Sum + (i&j)	
	
	b Exit_if_else          @ jump to Exit_if_else lable


Exit_if_else:
	
	add r2,r2,#1            @ increase the j by 1
	b Loop_2                @ jump to Loop_2 lable


Exit_Inside_Loop:

	add r1,r1,#1			@ increase the i by 1
	b Loop_1				@ jump to Loop_1 lable


Exit:



	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 300 if correct)\n"


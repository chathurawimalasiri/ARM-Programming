@ ARM Assembly - lab 3.1
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	
@
@ int mypow(int x, int n){
@	int value = 1;	
@	
@	if( n == 0 ){
@		return value;
@	}	
@
@	for(int i = 1; i <= n; i++){
@		value *= x;
@	}
@
@	return value;
@ }
@ ---------------------	
mypow:

	mov r3,#1		@ put 1 to r3
	mov r12,#1		@ put 1 to r12 for base case 
	
	cmp r1,#0		
	beq Exit		@ if n is equal to 0 then jump to Exit lable
	
Loop :
	cmp r3,r1		
	bhi Exit		@ if r3 is higher than r1 jump to Exit lable
	
	mul r12,r0,r12		@ r12 = r12 * r0 
	add r3,r3,#1		@ increased r3 by 1
	b Loop

Exit:

	mov r0,r12		@ put final result to r0
	mov pc,lr		@ return 




@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "%d^%d is %d\n"


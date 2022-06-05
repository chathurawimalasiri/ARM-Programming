@ ARM Assembly - lab 3.2 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	
@ int gcd(int n1, int n2){
@ 	if(n2 == 0){
@		return n1;	
@	}
@
@	return gcd( n2 , n1 % n2 );
@ ---------------------	
gcd:	
	sub sp, sp, #4			@ Adjust stack for 1 items
	str lr, [sp,#0]			@ Save return address
	
	cmp r1,#0
	bne L2				@ if r1 is not equal to zero then jump to L2 lable		
	b L4				@ unconditional branch to L4 lable
	
L2:
	mov r12,r1			@ put r1 value to r12 
	mov r3, r0			@ put r0 value to r3
	
	mov r0,r12			@ put r12 value to r0
	b Mod				@ jump to find the Mod of the two numbers  n1 % n2
L3:
	bl gcd				@ Nested call

L4 :
	ldr lr, [sp,#0]			@ Restore return address
	add sp,sp,#4			@ pop 1 items from stack
	mov pc,lr			@ Return


Mod:
	mov r2,#0			@ put zero to r2

	Loop:
		cmp r2,r3	
		bhi Exit		@ if r2 is higher than r3 then jump to Exit lable
		
		add r2,r2,r12		@ r2 = r2 + r12 
		b Loop			@ jump to Loop lable

	Exit:
		sub r2,r2,r12		@ r2 = r2 - r12
		sub r1,r3,r2		@ r1 = r3 - r2

		b L3			@ jump to L3 lable



@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64  	@the value a
	mov r5, #24	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
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
format: .asciz "gcd(%d,%d) = %d\n"


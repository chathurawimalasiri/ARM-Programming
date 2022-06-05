@
@
@ 
@
@

        .text   @ instruction memory

        .global main


main:
	@ stack handling
	sub sp, sp, #4			@ Adjust stack for items
	str lr, [sp,#0]			@ store lr to the stack 
	
	sub sp, sp, #4			@ allocate for integer

	@ print for number of string
	ldr r0, =format1		@ "Enter the number of strings:\n"
	bl printf

	@ scanf for integer 
	ldr r0, =formats		@ "%d%*c"
	mov r1,sp
	bl scanf

	ldr r4,[sp]			@ copy integer from stack to r4

	add sp, sp, #4			@ release stack
	
	cmp r4,#0
	beq Exit			@ if number is 0 then jump to Exit lable
	
	blt Negative_Check		@ if number is negative then jumo to Negative_Check lable


	mov r5,#0			@ i = 0
Loop:
	cmp r5,r4
	bge Exit			@ if r5 is higher than or equal to r4 then jump to Exit lable
	
	ldr r0, =formatInpStr		@ print formated string	--> "Enter input string %d:\n"
	mov r1, r5
	bl printf
	
	mov r0, r5
	bl ReverseString

	add r5, r5, #1			@ i = i + 1

	b Loop				@ jump to Loop lable

	
Negative_Check:
	
	ldr r0, =format2		@ print Invalid Input --> "Invalid Number\n"
	bl printf		
	b Exit

Exit:	
	ldr lr, [sp,#0]			
        add sp, sp, #4			@ pop items from stack
	mov r0, #0
        mov pc,lr			@ restore return address


ReverseString :
	
	sub sp, sp, #212		@ Adjust stack for items
	str lr, [sp, #200]
	str r6, [sp, #204]
	str r0, [sp, #208]		@ i value

	mov r0, #0			@ put 0 to r0 to avoid empty string conflict					
	strb r0,[sp]	

	ldr r0, =formatstring		@ take the string --> "%[^\n]%*c"
	mov r1, sp
	bl scanf
	

	@Output String	
				 
	ldr r1, [sp, #208]		@ store i in r1
	ldr r0, =formatInputOut		@ "Output string %d is :\n"
	bl printf	
	
	mov r6,sp			@ move stack pointer to r6



FindEnd:				@ find the ending char of the string 
	
	
	ldrb r1, [r6, #0]
	

	cmp r1, #0			@ check null character
	beq EmptyString
	
	add r6, r6, #1			@ move to next char
	b FindEnd


EmptyString :				@ check empty string
	
	cmp r6, sp			
	bgt PrintReverseOrder		@ if r6 is greater than sp then jump to PrintReverseOrder lable
	
	bl getchar			@ reads a single character

	ldr r0, =formatNewLine		@ "\n"
	bl printf	

	b StackRestore			@ jump to StackRestore lable

	

PrintReverseOrder:
	
	sub r6, r6, #1			@ last char 
	cmp r6, sp						
	ble EndReverseOrder		@ if r6 is less than or equal to sp then jump to EndReverseOrder lable

	ldrb r1, [r6,#0]		@ load character to r1 and print
	ldr r0, =formatOut		@ "%c"
	bl printf
	b PrintReverseOrder


EndReverseOrder:
	
	ldrb r1, [r6,#0]		@load last character and print
	ldr r0, =formatOutLast		@ "%c\n"
	bl printf
	b StackRestore

StackRestore:

	ldr r0, [sp, #208]		@ restore i value
	ldr r6, [sp, #204]		@ restore original r6
	ldr lr, [sp, #200]		@ restore return address
	add sp, sp, #212		@ pop items from stack
	mov pc,lr



	.data 	@data memory
format1: 	.asciz "Enter the number of strings:\n"
format2: 	.asciz "Invalid Number\n"
formatInpStr: 	.asciz "Enter input string %d:\n"
formats: 	.asciz "%d%*c"
formatstring:	.asciz "%[^\n]%*c"
formatInputOut:	.asciz "Output string %d is :\n"
formatOut:	.asciz "%c"
formatOutLast:	.asciz "%c\n"
formatNewLine:	.asciz "\n"



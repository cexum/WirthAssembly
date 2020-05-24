*
* itoa.s	an exercise in stack tracing + recursion
*

main	MOV	$stackb,R14	*load stack base
	MOV	$num,R1		*load num addr
	MOV	0(R1),R2	*move num value into R2
	MOV	$buf,R6		*load buf addr into R6
	JMPL	itoa
	JMP	exit

itoa	SUB	R14,$8,R14	*allocate space on stack
	MOV	R15,4(R14)	*store link
	DIV	R2,$10,R2	*remove right most digit
	MOV	H,R3		*get digit
	MOV	R3,8(R14)	*store digit
	SUB	R2,$0,R2	*determine if there are more digits
	JNEL	itoa		*recurse
	MOV	8(R14),R3	*load digit
	ADD	R3,$0X30,R3	*convert to ascii
	MOVB	R3,0(R6)	*store ascii in buf
	ADD	R6,$1,R6	*increment buf addr
	MOV	4(R14),R15	*load link
	ADD	R14,$8,R14	*move stack frame for next iteration
	JMP	(R15)		*jump link
	
exit	MOV	$4,R0
		SYSCALL	

test	STRINGZ	'1234'		*compare with buf for match
stackb	EQU	0xffff		*starting address of stack
num	WORD	1234		*convert to ascii
buf	BSS	1000		*store the ascii vals here.

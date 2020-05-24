*
* atoi.s	an exercise in recursion and stack tracing
*

main	MOV	$input,R1	*load input addr
	MOV	$stackb,R14	*load stack base addr
	MOV	$buf,R6		*load buf addr
	JMPL	atoi
	JMP	exit

atoi	SUB	R14,$8,R14	*allocate stack space
	MOV	R15,4(R14)	*store link
	MOVB	0(R1),R2	*get char
	MOV	R2,8(R14)	*store dec
	ADD	R1,$1,R1	*increment input addr
	SUB	R2,$0,R2	*check for end of STRINGZ
	JNEL	atoi
	MOV	8(R14),R2	*load dec
	MOVB	R2,0(R6)	*populate buf
	ADD	R6,$1,R6	*increment buf addr
	MOV	4(R14),R15	*load link
	ADD	R14,$8,R14	*move stack frame
	JMP	(R15)		*jump link

exit	MOV	$4,R0		
	SYSCALL

input	STRINGZ	'1234'	
buf	BSS	1000	*destination buffer
stackb	EQU	0Xffff	*stack base

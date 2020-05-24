*
* isalpha.s	determine if a char is, or is not A-Z | a-z
*

	MOV	$char,R1
	MOVB	0(R1),R2
	SUB	R2,$41,R3
	JLEL	true
	MOV	$5a,R4
	SUB	R4,R2,R3
	JGEL	true


exit	MOV	$4,R0
	SYSCALL

true	MOV	$1,R7
	JMP	(R15)

char STRINGZ 'D'

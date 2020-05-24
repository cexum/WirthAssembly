*
* prog1.s: Our first assembler program
*
start	EQU	.
	MOV	$1,R0		comments are here
	MOV	$2,R1
	MUL	R0,R1,R2
	MOV	R2,ANS(R3)	move R2 to asnwer
here	JMP	here
	JMP	start
	
ONE	WORD	2
TWO	WORD	5
ANS	WORD	0

end	EQU	.
bignum	EQU	0x234566

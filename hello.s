*
* hello.s: Charles' first assembly program
*
start	JMP	str
	JMP	mult 
	JMP	STOP

	
COA	WORD	2
COB	WORD	5
PRO	WORD	0
SUM	WORD	0
RES	WORD	0
		
end	EQU	.
bignum	EQU	0x234566

*multiply numbers*
mult	MUL 	R0,R1,R2
	MOV 	R2,R3
	ADD 	R3,R4,R4

*stop program*
STOP	MOV $4,R0

*test*
str	EQU	-
	MOV $2,R0
	MOV $5,R1
*move sh!t to registers*
init	EQU	-
	MOV	COA(R14),R0
	MOV	COB(R15),R1
	MOV	PRO(R13),R3
	MOV	SUM(R12),R4
	MOV	RES(R11),R5

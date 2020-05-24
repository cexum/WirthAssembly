*
* prog2.s: use memory to storage data
*/
	MOV	$0,R0
	MOV	one(R0),R1
	MOV	two(R0),R2
	ADD	R1,R2,R3
	MOV	R3,answer(R0)
here	JMP	here

one	WORD	1
two	WORD	2
answer	WORD	0

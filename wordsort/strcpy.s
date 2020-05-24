	MOV	$str,R2
	MOV	$buf,R4
cpy	MOVB	0(R2),R3
	MOVB	R3,0(R4)
	ADD	R2,$1,R2
	ADD	R4,$1,R4
	JMP	cpy

exit	MOV	$4,R0
	SYSCALL



str	STRINGZ 'abcd '
sptr	WORD	0
buf	BSS	8
bptr	WORD	0

start	MOV	$7,R1
	DIV	R1,$2,R1
	MOV	H,R2
	SUB	R2,$0,R2
	JNE	pos
end	MOV	$4,R0
	SYSCALL

pos	MOV	$1,R0
	JMP	(R15) 	*infinite loop in this case

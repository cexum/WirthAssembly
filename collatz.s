start	MOV	$0,R0
	MOV	$int,R1
	JMPL	iter		* update pc

iter	ADD	R0,$1,R0	* iteration count
	MOV	0(R1),R2	* load int
	DIV	R2,$2,R3	* determine if even
	MOV	H,R4		* move remainder into R4
	SUB	R4,$0,R4	* determine if H = 1
	JNE	odd		* if H = 1, int is odd
	JMP	even		* else int is even

odd	MOV	R2,R5		*check if R2 = 1; exit condition
	SUB	R5,$1,R5	
	JEQ	end
	MUL	R2,$3,R2
	ADD	R2,$1,R2
	MOV	R2,0(R1)
	JMP	(R15)

even	DIV	R2,$2,R2
	MOV	R2,0(R1)
	JMP	(R15)

end	MOV	$res,R7
	MOV	R0,0(R7)
	MOV	$4,R0	
	SYSCALL

int	WORD	0x7fed0000	*initial value
res	WORD	0






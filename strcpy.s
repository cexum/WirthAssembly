start	MOV	$str1,R1	*store str1 addr in R1
	MOV	$str2,R3	*store str2 addr in R3
	JMPL	cpychar
	JMP	end

cpychar MOVB	0(R1),R2	* str must be pre loaded
	MOVB	R2,0(R3)	* copy byte over
	SUB	R2,$0,R2	
	JEQ	(R15)		* if terminus, exit function
	ADD	R1,$1,R1	* increment addr
	ADD	R3,$1,R3	* increment addr
	JMP	cpychar		* continue

getchar MOVB	0(R1),R2	*str must be pre loaded
	SUB	R2,$0,R2	
	JEQ	(R15)		* if terminus, exit function
	ADD	R1,$1,R1
	JMP	getchar		* continue

end	MOV	$0,R0
	SYSCALL

str0	STRINGZ	'string literal0'
str1	STRINGZ	'string literal0' 
str2	STRINGZ				*empty

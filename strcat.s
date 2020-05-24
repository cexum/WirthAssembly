*
* strcat.s	concat 2 STRINGZ store in BSS
*

start	MOV	$0,R0
	MOV	$str1,R1
	MOV	0(R1),R2
	MOV	$str2,R3
	MOV	0(R3),R4
	MOV	$buf,R5

getword	MOV	0(R1),R2
	SUB	R2,$0,R2
	JEQ	(R15)
	

getch	

putch			

end	MOV	$4,R0
	SYSCALL

str1	STRINGZ	'big0'
str2	STRINGZ	'data0'
buf	BSS	4096
bptr	WORD	buf

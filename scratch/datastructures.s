start	MOV	$bptr,R1
	MOV	R1,R13		*keep start of buf in R13
	MOV	$5,R2
	MOV	R2,0(R1)	*push R2 in buf
	ADD	R1,$4,R1
	MOV	$10,R2
	MOV	R2,0(R1)
	MOV	0(R13),R3
	ADD	R13,$4,R13
	MOV	0(R13),R4
end	MOV	$4,R0
	SYSCALL



buf	BSS	2048
bptr	WORD	buf

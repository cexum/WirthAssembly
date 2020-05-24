*
* stdout.s	put some ascii on the screen
*

write	MOV	$1,R1
	MOV	R1,0(R14)
	MOV	$data,R1
	MOV	R1,4(R14)
	MOV	$len,R1
	MOV	R1,8(R14)
	MOV	$2,R0
	SYSCALL
end	MOV	$4,R0
	SYSCALL

data	STRINGZ	'SOME ASCII OUTPUT FOR YOU\n'
out	EQU	1
len	EQU	32

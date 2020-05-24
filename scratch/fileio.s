*
* fileio.s	open and read a file
*

main	MOV	$stackb,R14

getchar	SUB	R14,$12,R14
	MOV	$fd,R1
	MOV	R1,4(R14)
	MOV	$buf,R1
	MOV	R1,8(R14)
	MOV	$len,R1
	MOV	R1,12(R14)
	MOV	$1,R0
	SYSCALL

exit	MOV	$4,R0
	SYSCALL

path	STRINGZ	/usr/cde/wirth/scratch/data

buf	BSS	1024
len	EQU	1024
read	EQU	1
fd	EQU	0
stackb	EQU	0XFFFF

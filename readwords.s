*
* readwords.s	read a text file; store words in a buffer spaced by null
*
main	MOV	$stackb,R14
	JMPL	openf
	JMPL	readf
	JMPL	closef
	JMP	exit

openf	SUB	R14,$8,R14	*allocate stack
	MOV	R15,8(R14)	*push link
	MOV	$path,R1
	MOV	R1,0(R14)	*push path
	MOV	$mode,R1
	MOV	R1,4(R14)	*push mode
	MOV	$open,R0
	SYSCALL
	MOV	$fd,R1
	MOV	R0,0(R1)	*save fd
	MOV	8(R14),R15	*pop link
	ADD	R14,$8,R14	*move stack frame
	JMP	(R15)		

test	ADD	R7,$1,R7
	JMP	exit

readf	SUB	R14,$12,R14	*allocate stack
	MOV	R15,12(R14)	*push link
	MOV	$fd,R1
	MOV	0(R1),R2	
	MOV	R2,0(R14)	*push fd
	MOV	$fbuf,R1
	MOV	R1,4(R14)	*push file buf
	MOV	$len,R1
	MOV	R1,8(R14)	*push len
	MOV	$read,R0	*read file
	SYSCALL			*get WORD from file
	MOV	12(R14),R15	*pop link
	ADD	R14,$12,R14	*move stack frame
	JMP	(R15)

closef	SUB	R14,$4,R14	*allocate stack
	MOV	R15,4(R14)	*push link
	MOV	$fd,R1
	MOV	0(R1),R2
	MOV	R2,0(R14)	*push fd
	MOV	$close,R0
	SYSCALL
	MOV	4(R14),R15
	ADD	R14,$4,R14	*move stack frame
	JMP	(R15)

exit	MOV	$4,R0
		SYSCALL

stackb	EQU	0XFFFF
fd	WORD	0
mode	EQU	0		*read mode
open	EQU	0		*SYSCALL
close	EQU	3		*SYSCALL
read	EQU	1		*SYSCALL
path	STRINGZ	'/usr/cde/wirth/words
fbuf	BSS	512			
len	EQU	4	

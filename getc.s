*
* getc.s	a routine which fetches next char from a file 'till 0
*		(EOF) is reached
*

main	MOV	$buf,R8
	MOV	$rptr,R9
	MOV	$eptr,R10
	MOV	R8,0(R9)	*point rptr to buf
	MOV	R8,0(R10)	*point eptr to buf
	MOV	$0,R8
	MOV	$0,R9
	MOV	$0,R10
	MOV	$dest,R7
	JMPL	openf
storef	JMPL	getc
	MOV	R0,R6
	MOVB	R0,0(R7)
	ADD	R7,$1,R7
	SUB	R0,$0,R0
	JNE	storef
	JMPL	closef
	JMP	exit

openf	SUB	R14,$8,R14	*allocate stack space
	MOV 	R15,8(R14)	*push link
	MOV	$in,R1
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

closef	SUB	R14,$4,R14	*allocate stack space
	MOV	R15,4(R14)	*push link
	MOV	$fd,R1
	MOV	0(R1),R2
	MOV	R2,0(R14)	*push fd
	MOV	$close,R0
	SYSCALL
	MOV	4(R14),R15	*pop link
	ADD	R14,$4,R14	*move stack frame
	JMP	(R15)

getc	MOV	$rptr,R8
	MOV	$eptr,R9
	MOV	0(R8),R10
	MOV	0(R9),R11
	SUB	R10,R11,R12
	JGE	readf
rtnc	MOVB	0(R10),R0
	ADD	R10,$1,R10
	MOV	R10,0(R8)
	JMP	(R15)

rtn0	MOV	$0,R0
	JMP	(R15)

readf	SUB	R14,$8,R14
	MOV	$fd,R1
	MOV	0(R1),R2
	MOV	R2,0(R14)	*push fd
	MOV	$buf,R1
	MOV	R1,4(R14)	*push buf
	MOV	$len,R1
	MOV	R1,8(R14)	*push len
	MOV	$read,R0
	SYSCALL
	MOV	$n,R1		*technically can do this w/o label n
	MOV	R0,0(R1)	*save n
	MOV	0(R1),R2
	SUB	R2,$0,R2
	JEQ	rtn0		*if nothing read, return 0
	MOV	$rptr,R8
	MOV	$eptr,R9
	MOV	$buf,R10
	MOV	R10,0(R8)	*rptr is at buf[0]
	MOV	R10,R12
	MOV	0(R8),R13
	MOV	R10,R11
	ADD	R2,R11,R11	*add n to eptr to shift address limit
	MOV	R11,0(R9)	*store updated eptr
	ADD	R14,$8,R14	*move stack frame
	JMP	rtnc		*made read, continue with getc
	
exit	MOV	$4,R0
	SYSCALL

in	STRINGZ '/usr/cde/wirth/words'
mode	EQU	0	*read
open	EQU	0	*SYSCALL
close	EQU	3	*SYSCALL
read	EQU	1	*SYSCALL
n	WORD	0	*bytes read by readf
fd	WORD	0
buf	BSS	8192
len	EQU	1
eptr	WORD	0
rptr	WORD	0
dest	BSS	24

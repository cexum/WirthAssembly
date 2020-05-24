*
* stringlog.s	read from stdin, append to file
*
main	MOV	$stackb,R14
	JMPL	openf
	JMPL	readf
	JMPL	closef
	JMPL	getchar
	JMPL	concat
	JMPL	openf
	JMPL	writef
	JMPL	closef
	JMP	exit

getchar	SUB	R14,$12,R14	*allocate stack
	MOV	R15,12(R14)	*push link
	MOV	$stdin,R1	
	MOV	R1,0(R14)	*push fd
	MOV	$ibuf,R1
	MOV	R1,4(R14)	*push buf
	MOV	$len,R1
	MOV	R1,8(R14)	*push len
	MOV	$read,R0	*read stdin
		SYSCALL
	MOV	12(R14),R15	*pop link
	ADD	R14,$12,R14
	JMP	(R15)

openf	SUB	R14,$8,R14	*allocate stack
	MOV	R15,8(R14)	*push link
	MOV	$path,R1
	MOV	R1,0(R14)	*push path
	MOV	$mode,R1
	MOV	R1,4(R14)	*push mode
	MOV	$open,R0	*open file
		SYSCALL
	MOV	$fd,R1	
	MOV	R0,0(R1)	*store fd
	MOV	8(R14),R15	*pop link
	ADD	R14,$8,R14	*move stack frame
	JMP	(R15)

writef	SUB	R14,$12,R14	*allocate stack
	MOV	R15,12(R14)	*push link
	MOV	$fd,R1
	MOV	0(R1),R2
	MOV	R2,0(R14)	*push fd
	MOV	$tbuf,R1
	MOV	R1,4(R14)	*push buf
	MOV	$tlen,R1
	MOV	R1,8(R14)	*push len
	MOV	$write,R0	*write buf to file
		SYSCALL
	MOV	12(R14),R15	*pop link
	ADD	R14,$12,R14	*move stack frame
	JMP	(R15)

closef	SUB 	R14,$4,R14
	MOV	R15,4(R14)	*push link
	MOV	$fd,R1
	MOV	0(R1),R2
	MOV	R2,0(R14)	*push fd
	MOV	$close,R0
		SYSCALL
	MOV	4(R14),R15
	ADD	R14,$4,R14	*move stack frame
	JMP	(R15)
	
readf	SUB	R14,$12,R14	*allocate stack
	MOV	R15,12(R14)	*push link
	MOV	$fd,R1
	MOV	0(R1),R2	
	MOV	R2,0(R14)	*push fd
	MOV	$fbuf,R1
	MOV	R1,4(R14)	*push fbuf
	MOV	$flen,R1
	MOV	R1,8(R14)	*push flen
	MOV	$read,R0	*read fd
		SYSCALL
	MOV	12(R14),R15	*pop link
	ADD	R14,$12,R14
	JMP	(R15)

concat	MOV	$fbuf,R1	*concat fbuf and ibuf
	MOV	$tbuf,R3	*load addresses
cpyf	MOVB	0(R1),R2	*copy fbuf to tbuf
	MOVB	R2,0(R3)
	SUB	R2,$0,R2	*check for end of buf
	JEQ	loadi			
	ADD	R1,$1,R1
	ADD	R3,$1,R3
	JMP	cpyf
loadi	MOV	$ibuf,R1	*load address of ibuf
cpyi	MOVB	0(R1),R2	*concat ibuf to tbuf
	MOVB	R2,0(R3)
	SUB	R2,$0,R2
	JEQ	(R15)		*end of input, jump to link
	ADD	R1,$1,R1
	ADD	R3,$1,R3
	JMP	cpyi

exit	MOV	$4,R0
		SYSCALL

path	STRINGZ	'/usr/cde/wirth/log'
open	EQU	0
close	EQU	3
mode	EQU	2		*open mode 2: read and write
fd	WORD	0		*store fd
read	EQU	1
write	EQU	2
stdin	EQU	0
stackb	EQU	0XFFFF
ibuf	BSS	1024		*store line from stdin
len	EQU	1024
fbuf	BSS	10000		*store contents of log
flen	EQU	10000
tbuf	BSS	10000		*concatenate fbuf + ibuf
tlen	BSS	10000


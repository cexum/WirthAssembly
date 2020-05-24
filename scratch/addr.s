*
*addr.s	an exercise in keeping up with addresses
*

main	MOV	$buf,R1		*load buff addr
	MOV	$rptr,R2	*load pointer addr
	ADD	R1,$n,R7	*calculate end of buf
	MOV	R7,0(R6)	*store end of buf in eptr
	MOV	R1,0(R2)	*store buf[0] in rptr
	MOV	$dest,R11	*load address of dest
	MOV	$dptr,R12	*load dptr
	MOV	R11,0(R12)	*store dest[0] in dptr

getc	MOV	0(R2),R3	*load buf[c] via ptr
	MOVB	0(R3),R4	*pop first byte...
	MOVB	R4,0(R12)	*push byte into dest
	ADD	R12,$1,R12	*messy way to keep up with dest "ptr"
	ADD	R3,$1,R3	*increment addr
	MOV	R3,0(R2)	*store buf[c + 1] in rptr
	MOV	0(R2),R8	*load address of rptr for comparison
	MOV	0(R6),R9	*load address of eptr for comparison
	SUB	R9,R8,R10
	JNE	getc

exit	MOV	$4,R0
	SYSCALL


buf	STRINGZ	'abcdefgh'	*pretend it propogates from file open
dest	STRINGZ	''		*copy buf into dest
n	EQU	8		*here, i know len is 9...
rptr	WORD	0		*read pointer
eptr	WORD	0		*figure out how to point at end of buf
dptr	WORD	0		*dest pointer

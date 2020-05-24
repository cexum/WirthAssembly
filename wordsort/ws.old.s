*
* ws.s	read in a list of words; build and print a bst.
*

main	JMPL	getlist
	JMP	strt
	JMP	exit
strt	MOV	$bst,R1
	MOV	$root,R2	
	MOV	$ptr,R3
	MOV	0(R3),R4
	MOV	0(R4),R5
	MOV	$data,R8
	MOV	$ptr,R13	*debugging information
	JMPL	insnode
	JMPL	insnode
	JMPL	insnode
	JMPL	insnode
	JMPL	insnode
	JMPL	insnode
	JMPL	insnode
	JMP	exit

insnode	SUB	R14,$16,R14	*allocate stack space
	MOV	R15,0(R14)	*push link
	MOVB	0(R8),R9
	MOV	R9,4(R14)	*push data
	ADD	R8,$1,R8	*increment data addr to next byte
	MOV	$bst,R1		*load address of bst
	MOV	$ptr,R2		*load address of pointer
	MOV	R1,0(R2)	*store head of bst in ptr
	MOV	R2,8(R14)
insert	MOV	8(R14),R2	*insert routine
	MOV	0(R2),R3	*load val of pointer (its an address)
	MOV	0(R3),R4	*get value of the node
	SUB	R4,$0,R4	*see if node is 0 (null)
	JEQ	newnode
pop	SUB	R4,R9,R12	*R12 wasn't being used..
	JEQ	fndlft		*new node is equal (discard in ws)
	JPL	fndlft		*new val is < node, find left leaf
	JMP	fndrgt

fndrgt	MOV	8(R14),R1	*get ptr address (set by caller)
here	MOV	0(R1),R2	*get address of (current) node
	ADD	R2,$8,R2	*increment to address of right leaf
	MOV	R2,12(R14)	*push leaf address
	MOV	0(R2),R3	*load leaf (address to another node)
	SUB	R3,$0,R3	*see if value (addr) is 0 (null node)
	JEQ	insleaf		*null case
	MOV	12(R14),R1	*load leaf addr
	MOV	0(R1),R2	*load node addr
	MOV	8(R14),R3	*load ptr
	MOV	R2,0(R3)	*push node addr to ptr
	MOV	R3,8(R14)	*push ptr back on stack
	JMP	insert		*!null case

fndlft	MOV	8(R14),R1	*get ptr address (set by caller)
there	MOV	0(R1),R2	*get address of (current) node
	ADD	R2,$4,R2	*increment to address of left leaf
	MOV	R2,12(R14)	*push leaf address
	MOV	0(R2),R3	*load leaf (address to another node)
	SUB	R3,$0,R3	*see if value (addr) is 0 (null node)
	JEQ	insleaf		*null case
	MOV	12(R14),R1	*load leaf addr
	MOV	0(R1),R2	*load node addr
	MOV	8(R14),R3	*load ptr
	MOV	R2,0(R3)	*push node addr to ptr
	MOV	R3,8(R14)	*push ptr back on stack
	JMP	insert		*!null case

fndopen	MOV	8(R14),R1	*load ptr
	MOV	0(R1),R2	*load current addr of pointer
	ADD	R2,$12,R2	*increment to next data node addr
	MOV	R2,0(R1)	*update ptr
	MOV	R1,8(R14)	*put updated ptr back on the stack
	MOV	0(R2),R1	*load data
	SUB	R1,$0,R1	*test for null (0)
	JNE	fndopen		*if !null, get next node
	JMP	(R15)		*else return with open node addr in 8(R14)

insleaf	JMPL	fndopen		*locate next open node
	MOV	12(R14),R1	*load address of leaf
	MOV	8(R14),R2	*load node addr
	MOV	0(R2),R3	*load open node address
	MOV	R3,0(R1)	*store open node addr in the leaf
	JMP	insert

debug	ADD	R7,$1,R7	*debugging information
	JMP	exit

newnode MOV	8(R14),R1	*assumes ptr has been set by caller
	MOV	0(R1),R2	*load node address
	MOV	4(R14),R3	*pop data
	MOV	R3,0(R2)	*populate node
	MOV	0(R14),R15
	ADD	R14,$16,R14	*shift stack frame
	JMP	(R15)

getword	MOV	$dptr,R1	
	MOV	0(R1),R2	*address of dest
	MOV	0(R1),R7	*first index of new word
	MOV	$wptr,R3
popb	MOVB	0(R2),R5	*pop byte (char)
	ADD	R2,$1,R2	*increment addr to next byte
	SUB	R5,$0,R5	*check for null terminus
	JEQ	saveptr		*return
	JMP	popb
saveptr	MOV	R2,0(R1)	*dptr now points to next word
	MOV	R7,0(R3)	*wptr now points to current word
	JMP	(R15)		*return
		

getlist MOV	$rtrn,R13
	MOV	R15,0(R13)
	MOV	$buf,R8
	MOV	$rptr,R9
	MOV	$eptr,R10
	MOV	R8,0(R9)	*point rptr to buf
	MOV	R8,0(R10)	*point eptr to buf
	MOV	$0,R8
	MOV	$0,R9
	MOV	$0,R10
	MOV	$dest,R7
	JMPL	openf
getwd	JMPL	getc
	MOV	R0,R3
	MOV	$65,R4
	SUB	R3,R4,R5	*if c >= 'A'
	JPL	isupr
	SUB	R3,$32,R2	*if c == ' ' add null space to dest
	JEQ	addnull		
	SUB	R0,$0,R0	*if c < 'A', check for EOF(0)
	JNE	getwd
	JEQ	finish

addnull	MOV	$0,R0		*found ' ', interpret as end of word
	JMP	store	

store	MOVB	R0,0(R7)
	ADD	R7,$1,R7
	JMP	getwd
	
finish	JMPL	closef
	MOV	$rtrn,R13
	MOV	0(R13),R15
	JMP	(R15)

isupr	MOV	$25,R4	
	SUB	R4,R5,R5
	JPL	store
	JMP	islwr		

islwr	MOV	$97,R4
	SUB	R3,R4,R5
	JMI	getwd		*c >= 91 && c <= 96 
	MOV	$25,R4
	SUB	R4,R5,R5
	JPL	store
	JMP	getwd		*c >= 122

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

stackb	EQU	FFFF
rtrn	WORD	0
in	STRINGZ '/usr/cde/wirth/wordsort/words'
in2	STRINGZ	'/usr/jcf/awk/lorem'
mode	EQU	0	*read
open	EQU	0	*SYSCALL
close	EQU	3	*SYSCALL
read	EQU	1	*SYSCALL
n	WORD	0	*bytes read by readf
fd	WORD	0
buf	BSS	8192
len	EQU	256
eptr	WORD	0
rptr	WORD	0
dest	BSS	8192	*a list of null terminated words
dptr	WORD	dest	*keep track of index in dest (to next new word)
wptr	WORD	dest	*a temp pointer to current word (push to tree)
plist	BSS	1024	*a list of pointers (to null terminated words)
lptr	WORD 	plist
bst	BSS	8192		*populate me
root	EQU	bst
ptr	WORD	root
leftlf	EQU	4
rghtlf	EQU	8 
data	STRINGZ	'fgebach'

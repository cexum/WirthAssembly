*
* bst.s	make a bst tree
*
strt	MOV	$bst,R1
	MOV	$root,R2	
	MOV	$ptr,R3
	MOV	0(R3),R4
	MOV	0(R4),R5
	MOV	$data,R8
	JMPL	insnode
	MOV	$ptr,R1
break	ADD	R1,$4,R1
	MOV	0(R1),R2
	JMPL	insnode
	JMP	exit

insnode	SUB	R14,$12,R14	*allocate stack space
	MOV	R15,0(R14)	*push link
	MOVB	0(R8),R9
	MOVB	R9,4(R15)	*push data
	ADD	R8,$1,R8	*increment data addr to next byte
	MOV	$ptr,R1		*load address of pointer
	MOV	0(R1),R2	*load val of pointer (its an address)
	MOVB	0(R2),R3	*get value of the node
	SUB	R3,$0,R3	*see if node is 0 (null)
	JEQ	newnode
	SUB	R3,R9,R12	*R12 wasn't being used..
	JEQ	fndlft		*new node is equal (discard in ws)
	JNE	fndlft		*new val is < node, find left leaf
	JMP	fndrgt

fndlft	ADD	R7,$1,R7	*debugging information
	MOV	$ptr,R1		*get ptr address
	ADD	R1,$4,R2	*increment addr to point to left leaf
	MOV	0(R2),R3	*get address of left leaf
	MOV	0(R3),R4	*get value at addess of left leaf
	SUB	R4,$0,R4	*see if value is 0 (null node)
	JEQ	debug		*test
	JMP	exit

debug	ADD	R7,$1,R7	*debuggin information
	JMP	exit

fndrgt	JMP	exit

newnode MOV	$ptr,R1		*assumes ptr has been set by caller
	MOV	0(R1),R2
	MOVB	4(R15),R3
	MOVB	R3,0(R2)	*populate node
	MOV	0(R14),R15
	ADD	R14,$12,R14	*shift stack frame
	JMP	(R15)
	
exit	MOV	$4,R0
	SYSCALL

bst	BSS	8192		*populate me
root	EQU	bst
ptr	WORD	root
leftlf	EQU	4
rghtlf	EQU	8 
data	STRINGZ	'dcbaefghijk'

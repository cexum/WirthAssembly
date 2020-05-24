*
* bst.s	make a bst tree
*
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
	
exit	MOV	$4,R0
	SYSCALL

bst	BSS	8192		*populate me
root	EQU	bst
ptr	WORD	root
leftlf	EQU	4
rghtlf	EQU	8 
data	STRINGZ	'fgebach'

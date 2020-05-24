*
* struct.s	manually create a bin tree; print the tree.
*

main	JMPL	insnode
	MOV	$data,R1	*load start of data
	ADD	R1,$4,R1	*move address to next datum
	JMPL	insnode		*insert a new node into BST
	JMP	exit


insnode SUB	R14,$8,R14	*allocate stack frame
	MOV	$data,R1	*load address of data
	MOV	0(R1),R2
	MOV	R2,8(R14)	*push data
	MOV	R15,4(R14)	*push link
	MOV	$root,R13	*load address of root node
fndnode	MOV	0(R13),R8	*recur through BST until node == NULL
	SUB	R8,$0,R8	*look for Z flag
	JEQ	newnode		*if node == NULL, call newnode
	SUB	R8,R2,R9
	JLE	left		*if JLE, find open left leaf
	JMP	right		*else find open right leaf
	JMP	exit

fndleft	ADD	R7,$1,R7
	
	JMP	exit

right	JMP	exit

newnode	MOV	8(R14),R1	*move address of data into R1
	ADD	R7,$1,R7	*debugging information
	MOV	R1,0(R13)	*push address of data into node
	MOV	4(R14),R15	*pop link
	ADD	R14,$8,R14	*move stack frame
	JMP	(R15)		*return

exit	MOV	$4,R0
	SYSCALL

tree	BSS	8192
root	EQU	32768
ptr	WORD	0
data	WORD	11
	WORD	7
	WORD	6
	WORD	3
str1	STRINGZ	'd'
str2	STRINGZ	'a'
str3	STRINGZ	't'
str4	STRINGZ	'a'

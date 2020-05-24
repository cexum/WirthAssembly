#!/bin/wpemu -r -f
                *
                * bst.s	make a bst tree
                *
000000 41000154	strt	MOV	$bst,R1
000004 42000154		MOV	$root,R2	
000008 43002154		MOV	$ptr,R3
00000c 84300000		MOV	0(R3),R4
000010 85400000		MOV	0(R4),R5
000014 48002158		MOV	$data,R8
000018 4d002154		MOV	$ptr,R13	*debugging information
00001c f7000007		JMPL	insnode
000020 f7000006		JMPL	insnode
000024 f7000005		JMPL	insnode
000028 f7000004		JMPL	insnode
00002c f7000003		JMPL	insnode
000030 f7000002		JMPL	insnode
000034 f7000001		JMPL	insnode
000038 e7000044		JMP	exit

00003c 4ee90010	insnode	SUB	R14,$16,R14	*allocate stack space
000040 afe00000		MOV	R15,0(R14)	*push link
000044 99800000		MOVB	0(R8),R9
000048 a9e00004		MOV	R9,4(R14)	*push data
00004c 48880001		ADD	R8,$1,R8	*increment data addr to next byte
000050 41000154		MOV	$bst,R1		*load address of bst
000054 42002154		MOV	$ptr,R2		*load address of pointer
000058 a1200000		MOV	R1,0(R2)	*store head of bst in ptr
00005c a2e00008		MOV	R2,8(R14)
000060 82e00008	insert	MOV	8(R14),R2	*insert routine
000064 83200000		MOV	0(R2),R3	*load val of pointer (its an address)
000068 84300000		MOV	0(R3),R4	*get value of the node
00006c 44490000		SUB	R4,$0,R4	*see if node is 0 (null)
000070 e100002f		JEQ	newnode
000074 0c490009	pop	SUB	R4,R9,R12	*R12 wasn't being used..
000078 e100000f		JEQ	fndlft		*new node is equal (discard in ws)
00007c e800000e		JPL	fndlft		*new val is < node, find left leaf
000080 e7000000		JMP	fndrgt

000084 81e00008	fndrgt	MOV	8(R14),R1	*get ptr address (set by caller)
000088 82100000	here	MOV	0(R1),R2	*get address of (current) node
00008c 42280008		ADD	R2,$8,R2	*increment to address of right leaf
000090 a2e0000c		MOV	R2,12(R14)	*push leaf address
000094 83200000		MOV	0(R2),R3	*load leaf (address to another node)
000098 43390000		SUB	R3,$0,R3	*see if value (addr) is 0 (null node)
00009c e100001c		JEQ	insleaf		*null case
0000a0 81e0000c		MOV	12(R14),R1	*load leaf addr
0000a4 82100000		MOV	0(R1),R2	*load node addr
0000a8 83e00008		MOV	8(R14),R3	*load ptr
0000ac a2300000		MOV	R2,0(R3)	*push node addr to ptr
0000b0 a3e00008		MOV	R3,8(R14)	*push ptr back on stack
0000b4 e7ffffea		JMP	insert		*!null case

0000b8 81e00008	fndlft	MOV	8(R14),R1	*get ptr address (set by caller)
0000bc 82100000	there	MOV	0(R1),R2	*get address of (current) node
0000c0 42280004		ADD	R2,$4,R2	*increment to address of left leaf
0000c4 a2e0000c		MOV	R2,12(R14)	*push leaf address
0000c8 83200000		MOV	0(R2),R3	*load leaf (address to another node)
0000cc 43390000		SUB	R3,$0,R3	*see if value (addr) is 0 (null node)
0000d0 e100000f		JEQ	insleaf		*null case
0000d4 81e0000c		MOV	12(R14),R1	*load leaf addr
0000d8 82100000		MOV	0(R1),R2	*load node addr
0000dc 83e00008		MOV	8(R14),R3	*load ptr
0000e0 a2300000		MOV	R2,0(R3)	*push node addr to ptr
0000e4 a3e00008		MOV	R3,8(R14)	*push ptr back on stack
0000e8 e7ffffdd		JMP	insert		*!null case

0000ec 81e00008	fndopen	MOV	8(R14),R1	*load ptr
0000f0 82100000		MOV	0(R1),R2	*load current addr of pointer
0000f4 4228000c		ADD	R2,$12,R2	*increment to next data node addr
0000f8 a2100000		MOV	R2,0(R1)	*update ptr
0000fc a1e00008		MOV	R1,8(R14)	*put updated ptr back on the stack
000100 81200000		MOV	0(R2),R1	*load data
000104 41190000		SUB	R1,$0,R1	*test for null (0)
000108 e9fffff8		JNE	fndopen		*if !null, get next node
00010c c700000f		JMP	(R15)		*else return with open node addr in 8(R14)

000110 f7fffff6	insleaf	JMPL	fndopen		*locate next open node
000114 81e0000c		MOV	12(R14),R1	*load address of leaf
000118 82e00008		MOV	8(R14),R2	*load node addr
00011c 83200000		MOV	0(R2),R3	*load open node address
000120 a3100000		MOV	R3,0(R1)	*store open node addr in the leaf
000124 e7ffffce		JMP	insert

000128 47780001	debug	ADD	R7,$1,R7	*debugging information
00012c e7000007		JMP	exit

000130 81e00008	newnode MOV	8(R14),R1	*assumes ptr has been set by caller
000134 82100000		MOV	0(R1),R2	*load node address
000138 83e00004		MOV	4(R14),R3	*pop data
00013c a3200000		MOV	R3,0(R2)	*populate node
000140 8fe00000		MOV	0(R14),R15
000144 4ee80010		ADD	R14,$16,R14	*shift stack frame
000148 c700000f		JMP	(R15)

00014c 40000004	exit	MOV	$4,R0
000150 c7000010		SYSCALL

               	bst	BSS	8192		*populate me
       00000154	root	EQU	bst
002154 00000154	ptr	WORD	root
       00000004	leftlf	EQU	4
       00000008	rghtlf	EQU	8 
002158 62656766	data	STRINGZ	'fgebach'
00215c 00686361	

                Symbol Table
S 0x000000 strt
S 0x00003c insnode
S 0x000060 insert
S 0x000074 pop
S 0x000084 fndrgt
S 0x000088 here
S 0x0000b8 fndlft
S 0x0000bc there
S 0x0000ec fndopen
S 0x000110 insleaf
S 0x000128 debug
S 0x000130 newnode
S 0x00014c exit
S 0x000154 bst
S 0x000154 root
S 0x002154 ptr
S 0x000004 leftlf
S 0x000008 rghtlf
S 0x002158 data

*
* getchar.s	iterate through a string literal one char (nibble) a time
*

start	MOV	$iter,R5	* iteration limit
	MOV	$str,R1		* move addr of string into R1
	MOV	$0,R7		* storing addr increments in R7
getword	MOV	0(R1),R2	* shift 4 bytes of string into R2
	SUB	R2,$0,R2	* if 0, byte is empty; jump to end
	JEQ	end
	ADD	R7,$4,R7	* increment addr
	ADD	R1,R7,R1	* point address at next 4 bytes
	MOV	$0,R4		* (re)set iteration counter to 0
getchar	LSL	R2,$24,R3	* zero out first 24 bits, store in R3
	ASR	R3,$24,R3	* isolate right most 8 bits. (got char..)
	ROR	R2,$8,R2	* move next byte into right most 8 bits
	ADD	R4,$1,R4	* increment counter
	SUB	R5,R4,R6	* attempt to throw flags ~(N!=V)
	JEQ	getword		* get the next WORD
	JMP	getchar		* or get the next byte
end	MOV	$4,R0
	SYSCALL

str	STRINGZ	'abcdefgh'
iter	EQU	4

*
* strcmp.s	compare two STRINGZ (using '0' as terminus)
*

strt	MOV 	$0,R6		*result of cmp is in R6
	MOV	$str1,R1	*store addr of str1 in R1
	MOV	$0,R2		*store WORDs from str1 in R2
	MOV	$str2,R3	*store addr of str2 in R3
	MOV	$0,R4		*store WORDs from str2 in R4
cmp	MOV	0(R1),R2	*shift WORD from str1 into R2
	MOV	0(R3),R4	*shift WORD from str2 into R4
	ADD	R1,$4,R1	*increment str1 addr for next iteration
	ADD	R3,$4,R3	*increment str2 addr for next iteration
	SUB	R4,R2,R5	*compare WORDs
	JEQ	term		*if WORDs are equal check for terminus
	MOV	$-1,R6		*else STRINGZ are not equal: R6 = -1
end	MOV 	$4,R0
	SYSCALL
term	SUB	R2,$48,R2	*check for terminus: 48=X30='0'
	JEQ	end
	JMP	cmp

str1	STRINGZ 'data0'
str2	STRINGZ	'data0'

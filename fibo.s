*
* fibo.s: an exercise in looping and decision making to
* implement a fibonacci sequence
*

init	MOV	$0,R0	
	MOV	$count,R3
	MOV	$0,R0
	MOV	$1,R1
	MOV	$1,R2
fibo	ADD	R1,R2,R0
	MOV	R2,R1
	MOV	R0,R2
	SUB	R3,$1,R3
	JEQ	end
cont	JMP	fibo
end	MOV	$4,R0
	SYSCALL 		*$4 = exit

count	EQU	5

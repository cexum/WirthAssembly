*
* fibo.s: an exercise in looping and decision making to
* implement a fibonacci sequence
*
init	MOV	$0,R0
	MOV	$1,R1
	MOV	$1,R2
	MOV	$MAX,R4
fibo	ADD	R1,R2,R0
	MOV	R2,R1
	MOV	R0,R2
	SUB	R4,R2,R3 	*subtract max from last fib
	JLT	end
cont	JMP	fibo
end	MOV	$4,R0
	SYSCALL

MAX	EQU	10

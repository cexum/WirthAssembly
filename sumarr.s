*
* sumarr.s	sum values in arr until reaching sentinal value
*

strt	EQU	.
	MOV	$0,R2		* store sum in R2
	MOV	$arr,R1
sum	MOV	0(R1),R2
	SUB	R2,$0,R2	*0 defines end point
	JEQ	end
	ADD	R2,R3,R3
	ADD	R1,$4,R1
	JMP	sum				
end	MOV	$4,R0
	SYSCALL

arr	WORD	1
	WORD	2
	WORD	3
	WORD	5
	WORD	0

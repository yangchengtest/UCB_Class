.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:

    # Prologue
    addi sp,sp,-4
    sw ra,0(sp)

    addi t0,x0,1
    blt a1,t0,exit

loop_start:
	addi t0,t0,-1
	li t1,4
	mul t2,t0,t1
	add t2,a0,t2
	lw t3,0(t2)
	addi s0,x0,0
	addi s1,t3,0

loop_continue:
	addi t0,t0,1
	bge t0,a1,loop_end
	mul t2,t0,t1
	add t2,a0,t2
	lw t3,0(t2)
	blt s1,t3,record
	j loop_continue

record:
	mv s0,t0
	mv s1,t3
	j loop_continue

loop_end:
    # Epilogue
    mv a0,s0
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

exit:
	addi a0, x0, 17
    addi a1, x0, 7
    ecall
.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    # Prologue
    addi sp,sp,-4
    sw ra,0(sp)

    addi t0,x0,1
    blt a1,t0,exit

loop_start:
	addi t1,t0,-1
	bge t1,a1,loop_end
	li t2,4
	mul t2,t1,t2
	add t2,a0,t2
	lw t3,0(t2)
	blt t3,x0,reverse

loop_continue:
	addi t0,t0,1
	j loop_start	

reverse:
	sw x0,0(t2)
	j loop_continue

loop_end:
	# Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4
	ret

exit:
	addi a0, x0, 17
    addi a1, x0, 8
    ecall
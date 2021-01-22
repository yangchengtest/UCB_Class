.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error checks
    li t0, 1
    blt a1, t0, exit_2
    blt a2, t0, exit_2
    blt a4, t0, exit_3
    blt a5, t0, exit_3
    bne a2, a4, exit_4

    # Prologue
    addi sp,sp,-8
    sw ra,0(sp)
    sw s0,4(sp)

    li t0,0
    li s0,4

outer_loop_start:
	bge t0,a1,outer_loop_end
	li t1,0

inner_loop_start:
	bge t1,a5,inner_loop_end
	li t2,0
	li t6,0
count_loop_start:
	bge t2,a2,count_loop_end
	mul t3,t0,a2
	add t3,t3,t2 #A
	mul t3,t3,s0
	add t3,a0,t3

	mul t4,t2,a5 #B
	add t4,t4,t1
	mul t4,t4,s0
	add t4,a3,t4

	lw t3,0(t3)
	lw t4,0(t4)

	mul t3,t3,t4
	add t6,t6,t3
	addi t2,t2,1
	j count_loop_start

count_loop_end:
	mul t3,t0,a5 #C
	add t3,t3,t1 
	mul t3,t3,s0
	add t3,a6,t3
	sw t6,0(t3)
	addi t1,t1,1
	j inner_loop_start

inner_loop_end:
	addi t0,t0,1
	j outer_loop_start

outer_loop_end:

    # Epilogue
    lw ra,0(sp)
    lw s0,4(sp)
    addi sp,sp,8
    ret

exit_2:
    li a0, 17
    li a1, 2
    ecall

exit_3:
    li a0, 17
    li a1, 3
    ecall

exit_4:
    li a0, 17
    li a1, 4
    ecall
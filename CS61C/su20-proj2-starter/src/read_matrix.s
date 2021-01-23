.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
	addi sp,sp,-28
	sw s0,0(sp)
	sw s1,4(sp)
	sw s2,8(sp)
	sw s3,12(sp)
	sw s4,16(sp)
	sw s5,20(sp)
	sw ra,24(sp)
    
    mv s0,a0
    mv s1,a1
    mv s2,a2

    #fopen
    mv a1,s0
    li a2,0
    jal fopen
    li t0,-1
    beq a0,t0,exit_50

    #file handle
    mv s0,a0

    #load row
    mv a1,s0
    mv a2,s1
    li s3,4
    mv a3,s3
    jal fread
    bne a0,s3,exit_51

    #load col
    mv a1,s0
    mv a2,s2
    mv a3,s3
    jal fread
    bne a0,s3,exit_51

    #malloc 
    lw t0,0(s1)
    lw t1,0(s2)
    mul t2,t0,t1
    mul s4,t2,s3 #memory size
    mv a0,s4
    jal malloc
    mv s5,a0 #memory point

    #malloc read
    mv a1,s0
    mv a2,s5
    mv a3,s4
    jal fread
    bne a0,s4,exit_51

    #close file
    mv a1,s0
    jal fclose
    bne a0,x0,exit_52

    # Epilogue
    mv a0,s5
    lw s0,0(sp)
    lw s1,4(sp)
    lw s2,8(sp)
    lw s3,12(sp)
    lw s4,16(sp)
    lw s5,20(sp)
    lw ra,24(sp)
    addi sp,sp,28
    ret

exit_50:
    li a1, 50
    j exit2

exit_51:
    li a1, 51
    j exit2

exit_52:
    li a1, 52
    j exit2
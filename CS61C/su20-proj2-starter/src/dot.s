.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:

    # Prologue
    li t0,1
    blt a2, t0, exit_5
    blt a3, t0, exit_6
    blt a4, t0, exit_6

    addi sp, sp, -4
    sw ra, 0(sp)

    li t0,0
    addi s0,x0,0

loop_start:
    bge t0,a2,loop_end
    mul t1,t0,a3
    mul t2,t0,a4
    add t1,t1,a0
    add t2,t2,a1
    lw t1,0(t1)
    lw t2,0(t2)
    mul t3,t1,t2
    add s0,s0,t3
    addi t0,t0,1
    j loop_start

loop_end:
    # Epilogue
    mv a0,s0
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

exit_5:
    addi a0, x0, 17
    addi a1, x0, 5
    ecall

exit_6:
    addi a0, x0, 17
    addi a1, x0, 6
    ecall



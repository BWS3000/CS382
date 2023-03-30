  .text
  .equ ELEM, 10 // number of elements
  .global _start
_start:
  .global sum3_func
sum3_func:
  ldr x0, =stack	// load the stack pointer
  mov sp, x0
  sub sp, sp, #16
  str x30, [sp]
  mov x2, #ELEM 	// number of elements
  ldr x1, =vec 	// address of the first element
  bl fsum	      // call the recursive function
  ldr x8, =out 	// address of the result
  str x0, [x8] 	// save the result
sum3_end:
  ldr x30, [sp]
  add sp, sp, #16
  br x30	// return to caller

  // returns the sum of a vector of numbers
// X1: address of the first element
// X2: number of elements
  .func fsum
fsum:
  stp x1, x2, [sp, #-16]! // save x1 and x2 on the stack
  stp x3, x30, [sp, #-16]!// save x3 and x30 (lr) on the stack
  cmp x2, #1 	// check if there is a single element
  bhi fsum_split // no! starts the recursion
  ldr x0, [x1] 	// yes! the sum is just the element
  b fsum_end 	// terminate the function
fsum_split: 	// split the vector in 2
  mov x3, x2, lsr #1 // number of elements in the second half
  sub x2, x2, x3 // number of elements in the first half
  bl fsum 	// sum of the first half
  add x1, x1, x2, lsl #3 // address of the second half
  mov x2, x3 	// num of elements in the second half
  mov x3, x0 	// move the sum of the first half in x3
  bl fsum 	// sum of the second half
  add x0, x0, x3 // sum of the two halves
fsum_end:
  ldp x3, x30, [sp], #16// reload the registers x3 and x30 (lr)
  ldp x1, x2, [sp], #16 // reload the registers x1 and x2
  br x30	// jump to caller
  .endfunc




  .data
vec:
  .quad 1,2,3,4,5,6,7,8,9,10 // element
  .bss
  .align 8
out:
  .space 8// space for the result
  .align 16
  .space 4096 // space for the stack
stack:
  .space 16 // stack base address
  .end
  
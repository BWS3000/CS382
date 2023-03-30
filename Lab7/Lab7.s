//Brian Sampson
//Lab7 10/27/2022
//I pledge my honor that I have abided by the Stevens Honor System. 

.text
.global _start

_start:
adr x9, length //address the length
ldr x1, =arr //x1 address of array
ldr x9, [x9, #0] //x2 length of array

bl findMax
// base case register print
mov x1, x0
adr x0, printFunc
bl printf

mov x0,#0
mov w8,#93
svc #0

.func findMax
findMax:
sub sp, sp, #32
str x9, [sp, #8]
str x30, [sp, #16]
// check if n=1, if so return the first element
cmp x9, #1 //Is x5 == 1?
bhi recurse //No start recursion
ldr x0, [x1, #0]  //Yes, get value of element and return
b skip
recurse:
sub x9, x9, #1 //Reduce index by 1
ldr x3, [x1, x9, lsl #3] //get the last element x3 of index x5
str x3, [sp] //store the current element in stack
bl findMax
// compare x3 to some register (use the same one for n=1).
ldr x3, [sp, #0] 
subs x29, x3, x0
blt skip
add x0, x3, #0
skip:
//restore the stack
ldr x3, [sp]
ldr x9, [sp, #8]
ldr x30, [sp, #16]
add sp, sp, #32
br x30
.endfunc

  .data
  arr: .dword -2, -5, 1, 8, 5, 6, -1 // elements in array
  length: .quad 7
  printFunc: .asciz "Max = %d\n"

  .end

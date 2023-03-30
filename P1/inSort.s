.text
.global _start
.extern printf

_start:
ldr x9, =arr //base of the array

adr x10, length
ldr x10, [x10, #0] //get copy of the length

bl inSort

mov x11, #0

printLoop:
subs x28, x11, x10 //check if iterator is >= length to exit
bge Exit

lsl x12, x11, #3 //i * 8
ldr x13, [x9, x12] //x22 = array[i]

add x11, x11, #1

mov x1, x13
adr x0, printFunc

sub sp, sp, #32
str x9, [sp, #0]
str x10, [sp, #8]
str x11, [sp, #16]
bl printf
ldr x9, [sp, #0]
ldr x10, [sp, #8]
ldr x11, [sp, #16]
add sp, sp, #32
b printLoop

Exit:
mov x0,#0
mov w8,#93
svc #0


.func inSort
inSort:
mov x12, #1 //i = 1

startLoop1:
subs x28, x12, x10 //making sure i < length (n)
bge exitLoop1 //else exit the first
lsl x13, x12, #3 //get the offset i * 8

ldr x14, [x9, x13] //get arr[i] (key)
sub x15, x12, #1 // j = i - 1 : j value

// Inner loop start
startLoop2:
//Check j >= 0
subs x28, x15, #0
blt exitLoop2
//Check arr[j] > key
lsl x13, x15, #3 //get j * 8
ldr x16, [x9, x13] //get arr[j]
subs x28, x16, x14
ble exitLoop2

//arr[j + 1] = arr[j]
add x13, x13, #8
str x16, [x9, x13]

//j = j - 1
sub x15, x15, #1
b startLoop2
// Inner loop end
exitLoop2:

add x17, x15, #1
lsl x17, x17, #3

str x14, [x9, x17] //arr[j + 1] = key

add x12, x12, #1 //i++

b startLoop1
exitLoop1:

br x30

.endfunc
 
.data
    arr: .dword 10, -6, 4, 2, 8, 8, 0, -1, 7, -7
    length: .quad 10
    printFunc: .asciz "%d\n"
    
.end

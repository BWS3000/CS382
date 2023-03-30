//Brian Sampson

.text
.global _start
.extern printf
.extern scanf

_start:
//Get the input
ldr x0, =fmtIn
ldr x1, =num
bl scanf

ldr x9, =arr //x9 is the base of the array

adr x10, length
ldr x10, [x10, #0] //x10 is the length of the array

adr x11, num
ldr x11, [x11, #0] //load num into x11, which is the input

bl BinSearch

lsl x12, x18, #3
ldr x12, [x9, x12] //get arr[mid]

subs x28, x12, x11 //check if arr[mid] is actually equal to the input
beq printFound

//Not found
mov x1, x18
adr x0, notFound
bl printf

b endProg
printFound:

//If it is found print found string
mov x1, x18
adr x0, found
bl printf

endProg:

mov x0,#0
mov w8,#93
svc #0

.func BinSearch
BinSearch:

mov x12, #0 //initial low
mov x13, x10 
sub x13, x13, #1 //subtract 1 from length to get initial high

Loop:
add x18, x13, x12 //  x18 to get (low + high)
lsr x18, x18, #1 // (low + high) / 2 in x14 (mid)

subs x14, x13, x12 //checking if high - low > 1
ble Exit //If high - low <= 1, then exit


lsl x15, x18, #3 // mid * 8
ldr x16, [x9, x15] //get arr[mid]

sub x17, x11, x16
cbz x17, Exit //if x == arr[mid] then return mid (x is input)

//check if x > arr[mid]
subs x27, x11, x16
ble ExitCond1

//If condition is true, low = mid + 1
add x12, x18, #1

//Jump over else statement to avoid overlapping
b jumpOverCond2

//If condition is false, exit first condition
ExitCond1:

//Else, high = mid - 1
sub x13, x18, #1

jumpOverCond2:
b Loop

Exit:
br x30

.endfunc

.data
arr: .dword 0,2,5,7,10, 100, 105, 1000, 1009
length: .dword 9
notFound: .string "The input has not been found in the array.\n"
found: .string "The input has been found in the array. Index = %d\n"
fmtIn: .string "%d"
num: .dword 0



.end

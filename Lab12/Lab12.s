//Brian Sampson
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start
_start:

mov x19, #0
mov x22, #0 //Holds the index multiplyer
mov x23, #0 //Holds the sum digit
mov x24, #10 //Holds 10 CONST
mov x25, #48 //Holds an offset of 48
ADR x21, currentSpace
Loop:
MOV x0, #0
MOV x1, x21
MOV x2, 1
MOV x8, 63
SVC 0

LDUR x9, [x21, #0] //x10 should hold the last input

ADD x21, x21, x19

CMP x9, #10 //Comparing input to 10 to check for new line
beq Exit

MUL x22, x22, x24
sub x22, x22, x25
add x22, x22, x9

ADD x19, x19, #1 //Offset +1
b Loop
Exit:

MUL x22, x22, x22 //x^2


MOV x23, x22
MOV x21, #0
getLength:

CMP x23, #0
ble endProg1
SDIV x23, x23, x24
ADD x21, x21, #1
b getLength
endProg1:

//x21 has length
MOV x9, x21
MOV x20, #1
SUB x9, x9, #1
//Places 10^(length) in x20
getPow:
CMP x9, #0
ble endProg2
MUL x20, x24, x20
SUB x9, x9, #1
b getPow
endProg2:


//x22 is num
//store current digit in x9
//x20 has 10^i
//x21 has the index
MOV x18, #1 //Modular divisor
writeLoop:
CMP x21, #1
blt endProg3

SDIV x9, x22, x20 // num // 10^i = digit

SDIV x20, x20, x24 //divide 10^i by 10

modLoop:
CMP x9, x24
blt modExit
SUB x9, x9, x24
b modLoop
modExit:

ADR x10, currentSpace
ADD x9, x9, #48 //Add 48 for ascii
STUR x9, [x10, #0]

MOV x0, #1
ADR x1, currentSpace
MOV x2, #1
MOV x8, #64
SVC 0
SUB x21, x21, #1

b writeLoop
endProg3:

ADR x10, currentSpace
MOV x9, #10 //use system call to make a new line (ASCII 10)
STUR x9, [x10, #0]

MOV x0, #1
ADR x1, currentSpace
MOV x2, #1
MOV x8, #64
SVC 0

MOV X0, 0
MOV X8, 93
SVC 0

.bss
currentSpace : .space 64

.end

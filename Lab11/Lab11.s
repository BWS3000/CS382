.text
.global _start
_start:

mov x19, #0
mov x22, #1 //Holds the index multiplyer
mov x23, #0 //Holds the sum digit
mov x24, #10 //Holds 10 CONST
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

MUL x7, x9, x22
ADD x23, x23, x7
MUL x22, x22, x24

ADD x19, x19, #1 //Offset +1
b Loop
Exit:

MOV x1, x22
adr x0, finalOutput
bl printf



MOV X0, 0
MOV X8, 93
SVC 0

.data
finalOutput : .asciz "%d\n"

.bss
currentSpace : .space 64

.end

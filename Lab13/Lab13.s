//Brian Sampson
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start
_start:

LDR x1, =x
//LDUR D1, [X0]  //Array of X values

LDR x2, =y
//LDUR D2, [X0]  //Array of Y values

//D7 holds the current min index (i)
//D8 holds the current max index (i)
//D9 holds the current min index (j)
//D10 holds the current max index (j)
//D11 holds i
//D12 holds j

MOV x7, #9999
MOV x8, #0
MOV x9, #9999
MOV x10, #0

ADR x0, zeroConst
LDUR x11, [x0] //holds i

ADR x0, zeroConst
LDUR x12, [x0] //holds j

//Length in D13

ADR x0, N
LDUR x13, [x0] //D13 is the length (N)

//D14 holds the maxDifference
//D15 holds the minDifference
ADR x0, maxVal
LDUR D14, [x0]

ADR x0, minVal
LDUR D15, [x0]

outterLoop:
//Check that i < length
CMP x11, x13
bge ExitOutterLoop

innerLoop:
//Check that j < length
CMP x12, x13
bge ExitInnerLoop

//Check that i != j
CMP x11, x12
beq skipOverlap
//Now good to do comparisons

//Store i * 8 in D17
//Store j * 8 in D18
//8 in D16 for multiplier and offset

MOV x19, #8

MUL x17, x11, x19
MUL x18, x12, x19

//Setup function call
//D3 = x1
//D4 = y1
//D5 = x2
//D6 = y2

LDR D3, [x1, x17] //x1
LDR D4, [x2, x17] //y1
LDR D5, [x1, x18] //x2
LDR D6, [x2, x18] //y2

BL relativeDistance

FCMP D0, D14 //if relativeDistance > maxDistance, do
ble skipCondOne

//Change maxIndexI
MOV x8, x11
//Change maxIndexJ
MOV x10, x12
//Change maxDistance
FMOV D14, D0
skipCondOne: 

//if relativeDistance < minDistance
FCMP D0, D15
bge skipCondTwo

//Change minIndexI
MOV x7, x11
//Change minIndexJ
MOV x9, x12
//Change minDistance
FMOV D15, D0
skipCondTwo:


skipOverlap:

ADD x12, x12, #1 //j++
b innerLoop
ExitInnerLoop:

MOV x12, #0
//Remember to set j back to 0
ADD x11, x11, #1 //i++
b outterLoop
ExitOutterLoop:


//fmov D0, D15
mov x1, x7
mov x2, x9
mov x3,x8
mov x4, x10
adr x0, printy
bl printf

mov x0,#0
mov w8,#93
svc #0

//Takes in registers D3, D4, D5, D6
//D3 = x1
//D4 = y1
//D5 = x2
//D6 = y2
//Result in D0
.func relativeDistance
relativeDistance:
FSUB D5, D5, D3 //x2 - x1
FSUB D6, D6, D4 //y2 - y1
FMUL D5, D5, D5 //(x2 - x1)^2
FMUL D6, D6, D6 //(y2 - y1)^2

FADD D0, D6, D5 //(x2 - x1)^2 + (y2 - y1)^2
br x30
.endfunc
	.data
printy : .asciz "Shortest distance combination (i, j): (%d,%d). Longest distance combination (i, j):  (%d,%d).\n"
minVal : .double 999
maxVal : .double 0

zeroConst : .quad 0

N:
	.dword 8
x:
	.double 0.0, 0.4140, 1.4949, 5.0014, 6.5163, 3.9303, 8.4813, 2.6505
y: 	
	.double 0.0, 3.9862, 6.1488, 1.047, 4.6102, 1.4057, 5.0371, 4.1196
.end

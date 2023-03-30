.text
.global _start
_start:

ADR x0, x
LDUR D6, [x0] //D6 = x value

LDR x0, =terms
LDR x1, [x0]
SCVTF D7, x1 //D7 = terms

ADR x0, oneConst
LDUR D1, [x0] //Sum
LDUR D2, [x0] //Index
LDUR D3, [x0] //factorialSum
FMOV D4, D6 //a = x
LDUR D5, [x0] //Stays as 1 forever oneConst = 1

bl approx

FMOV D0, D1
adr x0, finalOutput
bl printf

mov x0,#0
mov w8,#93
svc #0

.func approx
approx:
FCMP D2, D7 //While index < terms
bge Exit
FMUL D10, D2, D3 //(index * factorialSum)
FDIV D10, D5, D10 // 1 / (index * factorialSum)
FMUL D10, D10, D6 // (1 / (index * factorialSum)) * x
FADD D1, D1, D10 // Sum += D10
FMUL D3, D3, D2 //factSum = factSum * index

FADD D2, D2, D5 //Index++

FMUL D6, D6, D4 //x = a * x

b approx
Exit:

br x30
.endfunc

.data
//Input values
//Takes values greater than 0.
x : .double 2
terms : .quad 20

//Not part of the input
oneConst : .double 1.0 //1 used for factorialSum, Index, and sum
finalOutput : .asciz "The approximation is %f\n"

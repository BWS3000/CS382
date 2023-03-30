//Brian Sampson
//I pledge my honor that I have abided by the Stevens Honor System.
//Get the integral of the given equation using the midpoint rectangle method

.text
.global _start
_start:

ADR X0, a
LDUR D11, [X0] //D11 Lower bound

ADR X0, b
LDUR D12, [X0] //D12 upper bound

ADR X0, n
LDUR D13, [X0] // D13 amount of rectangles

//Get D14 (space between rectangles)
fsub D14, D12, D11
fdiv D14, D14, D13

ADR X0, zero
LDUR D15, [X0]
LDUR D19, [x0] //Sum value

ADR X0, half
LDUR D16, [X0] //CONST 0.5
loop:
//put i in D15 (current index)
fcmp D15, D13  //Check if i >= n, exit if so
bge Exit

//D17 is currentXVal
fadd D17, D15, D16 //i + 0.5
fmul D17, D17, D14 
fadd D17, D17, D11 //(i + 0.5) * RectangleSize + lowerbound = currentXVal

fmov D9, D17 //Get ready to call doPoly(CurrentXVal)

bl doPoly

fmul D18, D14, D10 // rectangleSize * doPoly(currentXVal) = D18
//D19 is the current sum
fadd D19, D19, D18 //sum += currentXVal * doPoly(CurrentXVal)

//Add 1 to index
fadd D15, D15, D16 //i += .5
fadd D15, D15, D16 // i += .5

b loop
Exit:

fmov D0, D11
adr x0, lowerBoundStr
bl printf

fmov D0, D12
adr x0, upperBoundStr
bl printf

fmov D0, D13
adr x0, amtRectStr
bl printf

fmov D0, D19
adr x0, finalOutput
bl printf

mov x0,#0
mov w8,#93
svc #0

//Input (x val) stored in D9
//Output stored in D10
.func doPoly
doPoly:

ADR X0, zero
LDUR D4, [X0] //D4 is sum

ADR X0, coOne
LDUR D6, [X0]
fmul D5, D9, D9
fmul D5, D5, D5
fmul D5, D5, D6 
fadd D4, D4, D5 //8.32x^4

ADR X0, coTwo
LDUR D6, [X0]

fmul D5, D9, D9
fmul D5, D5, D6
fsub D4, D4, D5 //-6.53x^2

ADR X0, coThree
LDUR D6, [X0]

fmul D5, D9, D6
fadd D4, D4, D5 //9.34x

ADR X0, coFour
LDUR D6, [X0]

fadd D4, D4, D6 //12.32

fmov D10, D4

br x30
.endfunc

.data
finalOutput : .asciz "Result = %f\n"
lowerBoundStr : .asciz "LowerBound = %f\n"
upperBoundStr : .asciz "UpperBound = %f\n"
amtRectStr : .asciz "AmountOfRectangles = %f\n"

//Inputs here
a : .double -1
b : .double 1
n : .double 5

//Coeff.
coOne : .double 8.32
coTwo : .double 6.53
coThree : .double 9.34
coFour : .double 12.32
zero : .double 0.0
half : .double 0.5

.end

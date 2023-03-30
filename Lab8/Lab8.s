.text
.global _start

_start:

adr x9, P //Base of given point
ldur x10, [x9, #0] //x1 value for given point
ldur x11, [x9, #8] //y1 value for given point

adr x12, C //Base of center of circle
ldur x13, [x12, #0] //x2 value for center of circle
ldur x14, [x12, #8] //y2 value for center of circle

adr x15, P3 //get the radius of the circle
ldur x15, [x15, #0] //x15 is the radius of the circle

//get x1 - x2
sub x16, x10, x13 //puts x1 - x2 into x16
mul x16, x16, x16 //does (x1 - x2)^2

//get y1 - y2
sub x17, x11, x14 //puts y1 - y2 into x17
mul x17, x17, x17 //does (y1 - y2)^2

add x17, x17, x16 //adds (x1 - x2)^2 + (y1 - y2)^2 and puts it into x17

//get the value of d^2
mul x15, x15, x15

//Check if x17 < x15
subs x18, x17, x15
ble goToYes

//set x18 to No
adr x18, no
b Exit


goToYes: 
adr x18, yes

//x18 holds our final result

Exit:
mov x0,#0
mov w8,#93
svc #0

.data
P: .quad 0, 0
C: .quad 1, 2
P3: .quad 2
yes: .string "P is inside the circle."
no: .string "P is outside the circle."

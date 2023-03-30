.text
.global _start
_start:
mov x9, 0 //Sum
mov x10, 1 //Counter
LOOP: subs XZR, x10, 10
b.gt EXIT
add x9, x9, x10
add x10, x10, 1
b LOOP

EXIT:
adr x0, printFunc
mov x1, x9
bl printf
mov x0,#0
mov w8,#93
svc #0

.data
    printFunc: .asciz "Sum = %d\n"
.end

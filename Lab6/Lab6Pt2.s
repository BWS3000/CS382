.text
.global _start
.extern printf
_start:
adr x9, a
adr x10, b
ldur x9, [x9, #0]
ldur x10, [x10, #0]

add x11, x9, x10
sub x11, x11, 4
cbnz x11, JUMP
mov x12, 13
b EXIT

JUMP:
mov x12, -12


EXIT:

adr x0, printFunc
mov x1, x12
bl printf

mov x0,#0
mov w8,#93
svc #0

.data
    a: .quad 2
    b: .quad 2
    printFunc: .asciz "f = %d\n"

.end

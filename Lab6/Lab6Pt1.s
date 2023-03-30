.text
.global _start
.extern printf

_start:
    adr x10, i
    ldur x10,[x10,#0]
    adr x14, g
    ldur x14, [x14, #0]
    sub x11, x10, #4
    cbnz x11, ELSE
    add x15, x14, #12
    b EXIT
ELSE:
    sub x15, x14, #24
    b EXIT

EXIT:
    adr x0, printFunc
    mov x1, x15
    bl printf

    mov x0,#0
    mov w8,#93
    svc #0

.data
    g: .quad 24
    i: .quad 4
    printFunc: .asciz "f = %d\n"
.end

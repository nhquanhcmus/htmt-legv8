.extern printf
.extern scanf

.section .data
    tb1: .asciz "Nhap n: "
    fmt: .asciz "%d"
    tb2: .asciz "%d la so chinh phuong\n"
    tb3: .asciz "%d khong la so chinh phuong\n"

.section .bss
    n: .space 8
.section .text

.global main
main:
    adrp x0, tb1
    add x0, x0,:lo12:tb1
    bl printf

    adrp x0, fmt
    add x0, x0,:lo12:fmt
    adrp x1, n 
    add x1, x1,:lo12:n
    bl scanf

    adrp x0, n 
    add x0, x0,:lo12:n 
    ldur x0, [x0]

    bl _checkCP

    adrp x20, n 
    add x20, x20,:lo12:n 
    ldur x20, [x20]

    cmp x0, #1
    B.EQ isCP

notCP:
    adrp x0, tb3 
    add x0, x0,:lo12:tb3
    mov x1, x20
    bl printf
    B exit

isCP:
    adrp x0, tb2 
    add x0, x0,:lo12:tb2
    mov x1, x20
    bl printf
    
exit:
    movz x0, #0
    movz x8, #93
    svc #0

.global _checkCP
_checkCP:
    sub sp, sp, #8
    str x30, [sp]
    sub sp, sp, #8
    str x19, [sp]
    sub sp, sp, #8
    str x20, [sp]
    sub sp, sp, #8
    str x21, [sp]

    mov x19, #1

loop:
    mul x21, x19, x19 
    cmp x21, x0 
    B.EQ retCP
    add x19, x19, #1
    cmp x19, x0
    B.LE loop

retnotCP:
    movz x0, #0 //true
    ldr x21,[sp]
	add sp,sp,#8
    ldr x20,[sp]
	add sp,sp,#8
    ldr x19,[sp]
	add sp,sp,#8
    ldr x30,[sp]
	add sp,sp,#8
    ret
retCP:
    movz x0, #1 //true
    ldr x21,[sp]
	add sp,sp,#8
    ldr x20,[sp]
	add sp,sp,#8
    ldr x19,[sp]
	add sp,sp,#8
    ldr x30,[sp]
	add sp,sp,#8
    ret

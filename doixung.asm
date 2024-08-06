.extern printf
.extern scanf

.section .data
    tb1: .asciz "Nhap n: "
    fmt: .asciz "%d"
    tb2: .asciz "%d la so doi xung\n" 
    tb3: .asciz "%d khong la so doi xung\n"

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
    bl _checkDX

    adrp x20, n 
    add x20, x20,:lo12:n 
    ldur x20, [x20]

    cmp x0, #1
    B.EQ isDX

notDX:
    adrp x0, tb3 
    add x0, x0,:lo12:tb3
    mov x1, x20
    bl printf
    B exit

isDX:
    adrp x0, tb2 
    add x0, x0,:lo12:tb2
    mov x1, x20
    bl printf

exit:
    movz x0, #0
    movz x8, #93
    svc #0

.global _checkDX
_checkDX:
    sub sp, sp, #8
    str x30, [sp]
    sub sp, sp, #8
    str x19, [sp]
    sub sp, sp, #8
    str x20, [sp]
    sub sp, sp, #8
    str x21, [sp]
    sub sp, sp, #8
    str x22, [sp]
    sub sp, sp, #8
    str x23, [sp]

    movz x19, #0 
    mov x23, x0 //tmp = n
    movz x24, #10 //x24 = 10

loop:
    cmp x0, #0
    B.eq done 
    mul x19, x19, x24
    udiv x20, x0, x24
    mul x21, x20, x24
    sub x22, x0, x21 //x22 = n mod 10
    add x19, x19, x22 
    mov x0, x20 
    B loop  

done:
    cmp x23, x19 
    B.NE false
true:
    movz x0, #1
    B return
false:
    movz x0, #0
    B return
return:
    ldr x23,[sp]
	add sp,sp,#8
    ldr x22,[sp]
	add sp,sp,#8
    ldr x21,[sp]
	add sp,sp,#8
    ldr x20,[sp]
	add sp,sp,#8
    ldr x19,[sp]
	add sp,sp,#8
    ldr x30,[sp]
	add sp,sp,#8
    ret


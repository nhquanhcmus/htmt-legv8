.extern printf
.extern scanf

.section .data
    tb1: .asciz "Nhap n: "
    fmt: .asciz "%d"
    tb2: .asciz "%d la so hoan thien\n"
    tb3: .asciz "%d khong la so hoan thien\n"

.section .bss
    n: .space 8
    sum: .space 8

.section .text

.global main
main:
    adrp x0, tb1
    add x0,x0,:lo12:tb1
    bl printf

    adrp x0,fmt
    add x0,x0,:lo12:fmt
    adrp x1, n
    add x1, x1,:lo12:n 
    bl scanf 

    adrp x0, n 
    add x0, x0,:lo12:n
    ldur x0, [x0]

    bl _checkHoanThien

    adrp x20, n
    add x20, x20,:lo12:n
    ldur x20, [x20]

check:
    cmp x0, x20
    B.EQ isPerfect
    B notPerfect 
    
isPerfect:
    adrp x0, tb2 
    add x0, x0,:lo12:tb2
    mov x1, x20
    bl printf 
    B exit

notPerfect:
    adrp x0, tb3 
    add x0, x0,:lo12:tb3
    mov x1, x20
    bl printf 
    B exit

exit:
    movz x0, #0
    movz x8, #93
    svc #0

.global _checkHoanThien
_checkHoanThien:
    //backup
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
    movz x21, #1

loop:
    cmp x21, x0
    B.GE done
    udiv x22, x0, x21
    mul x23, x22, x21 
    cmp x23, x0 
    B.NE skipAdd
    add x19, x19, x21
skipAdd:
    add x21, x21, #1
    B loop

done:
    mov x0, x19

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

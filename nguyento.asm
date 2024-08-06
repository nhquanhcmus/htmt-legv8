.extern printf

.section .data
    tb1: .asciz "Nhap n: "
    fmt1: .asciz "%d"
    tb2: .asciz "%d khong la so nguyen to\n"
    tb3: .asciz "%d la so nguyen to\n"

.section .bss
    n: .space 8

.section .text
.global main
main:
    adrp x0,tb1
    add x0,x0,:lo12:tb1
    bl printf

    adrp x0,fmt1
    add x0,x0,:lo12:fmt1
    adrp x1,n 
    add x1,x1,:lo12:n
    bl scanf

    adrp x1, n
    add x1, x1,:lo12:n
    ldur x1, [x1]

    bl _checkPrime

    cmp x0, #0
    B.EQ notPrime

isPrime:
    adrp x0,tb3
    add x0, x0,:lo12:tb3
    adrp x1, n
    add x1, x1,:lo12:n
    ldur x1, [x1]
    bl printf
    B exit

notPrime:
    adrp x0,tb2
    add x0, x0,:lo12:tb2
    adrp x1, n
    add x1, x1,:lo12:n
    ldur x1, [x1]
    bl printf


exit:
    movz x0,#0
    movz x8,#93
    svc #0

.global _checkPrime
_checkPrime:
    sub sp,sp,#8
	str x30,[sp]
	sub sp,sp,#8
	str x19,[sp]
	sub sp,sp,#8
	str x20,[sp]
    sub sp,sp,#8
	str x21,[sp]
    sub sp,sp,#8
	str x22,[sp]

    cmp x1, #2 //x1 is n
    B.LT retFalse
    
    movz x19, #2
    mov x20, x1

loop:
    cmp x19, x20
    B.eq retTrue
    udiv x21, x20, x19 
    mul x22, x21, x19
    cmp x22, x20
    B.eq retFalse

    add x19, x19, #1
    B loop

retTrue:
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
    movz x0, #1 //true
    ret

retFalse:
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
    movz x0, #0 //false
    ret

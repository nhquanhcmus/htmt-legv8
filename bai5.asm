.extern printf
.extern scanf

.section .data
    tb1: .asciz "Nhap n: "
    tb2: .asciz "Nhap a[%d]: "
    fmt1: .asciz "%d"
    fmt2: .asciz "%d \n"
    fmt3: .asciz "Mang vua nhap la: \n"
    tb3: .asciz "Cac so nguyen to trong mang la:\n"
    tb4: .asciz "So lon nhat trong mang la: %d\n"
    tb5: .asciz "Trung binh mang la: %d/%d\n"

.section .bss
    n: .space 8
    arr: .space 80

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

    //====NHAP MANG====//
    adrp x0,n
	add x0,x0,:lo12:n
    ldur x0, [x0]
    adrp x1,arr
	add x1,x1,:lo12:arr
    bl _nhap
    //====NHAP MANG====//


    //====XUAT MANG====//
    adrp x0,n
	add x0,x0,:lo12:n
    ldur x0, [x0]
    adrp x1,arr
	add x1,x1,:lo12:arr
    bl _xuat
    //====XUAT MANG====//

    //====XUAT MANG NGUYEN TO====//
    adrp x0,n
	add x0,x0,:lo12:n
    ldur x0, [x0]
    adrp x1,arr
	add x1,x1,:lo12:arr
    bl _xuatPrime
    //====XUAT MANG NGUYEN TO====//

    //====TIM GIA TRI LON NHAT====//
    adrp x0,n
	add x0,x0,:lo12:n
    ldur x0, [x0]
    adrp x1,arr
	add x1,x1,:lo12:arr
    bl _findMax

    mov x19, x0 
    adrp x0, tb4
    add x0, x0,:lo12:tb4
    mov x1, x19 
    bl printf 
    //====TIM GIA TRI LON NHAT====//
    

    //====TIM TRUNG BINH CONG MANG====//
    adrp x0,n
	add x0,x0,:lo12:n
    ldur x0, [x0]
    adrp x1,arr
	add x1,x1,:lo12:arr
    bl _findTBC

    mov x19, x0 
    adrp x0, tb5
    add x0, x0,:lo12:tb5
    mov x1, x19 
    adrp x2, n 
    add x2, x2,:lo12:n
    ldur x2, [x2]
    bl printf 
    //====TIM TRUNG BINH CONG MANG====//

exit:
	movz x0,#0
	movz x8,#93
	svc #0

.global _nhap
_nhap:
    sub sp, sp, #8
    str x30, [sp]
    sub sp, sp, #8
    str x19, [sp]
    sub sp, sp, #8
    str x20, [sp]
    sub sp, sp, #8
    str x21, [sp]

    mov x19, x0 //x19 = n 
    mov x20, x1  //x20 = arr
    movz x21, #0 //i = 0

_nhap.loop:
    adrp x0, tb2 
    add x0, x0,:lo12:tb2 
    mov x1, x21 
    bl printf

    adrp x0, fmt1
    add x0, x0,:lo12:fmt1
    mov x1, x20 
    bl scanf 
    
    add x20, x20, #8
    add x21, x21, #1 
    cmp x21, x19
    B.LT _nhap.loop

    ldr x21,[sp]
	add sp,sp,#8
    ldr x20,[sp]
	add sp,sp,#8
    ldr x19,[sp]
	add sp,sp,#8
    ldr x30,[sp]
	add sp,sp,#8
    ret

.global _xuat
_xuat:
    sub sp, sp, #8
    str x30, [sp]
    sub sp, sp, #8
    str x19, [sp]
    sub sp, sp, #8
    str x20, [sp]
    sub sp, sp, #8
    str x21, [sp]

    mov x19, x0 //x19 = n 
    mov x20, x1  //x20 = arr
    movz x21, #0 //i = 0

    adrp x0, fmt3 
    add x0, x0,:lo12:fmt3 
    bl printf

_xuat.loop:
    adrp x0, fmt2
    add x0, x0,:lo12:fmt2
    ldur x1, [x20]
    //movz x1, #2
    bl printf

    add x20, x20, #8
    add x21, x21, #1 
    cmp x21, x19
    B.LT _xuat.loop

    ldr x21,[sp]
	add sp,sp,#8
    ldr x20,[sp]
	add sp,sp,#8
    ldr x19,[sp]
	add sp,sp,#8
    ldr x30,[sp]
	add sp,sp,#8
    ret


.global _xuatPrime
_xuatPrime:
    sub sp, sp, #8
    str x30, [sp]
    sub sp, sp, #8
    str x19, [sp]
    sub sp, sp, #8
    str x20, [sp]
    sub sp, sp, #8
    str x21, [sp]

    mov x19, x0 //x19 = n 
    mov x20, x1  //x20 = arr
    movz x21, #0 //i = 0

    adrp x0, tb3
    add x0, x0,:lo12:tb3
    bl printf

_xuatPrime.loop:
    ldur x1, [x20]
    bl _checkPrime 
    cmp x0, #0
    B.EQ _xuatPrime.noPrint

    adrp x0, fmt2
    add x0, x0,:lo12:fmt2
    ldur x1, [x20]
    bl printf

_xuatPrime.noPrint:
    add x20, x20, #8
    add x21, x21, #1 
    cmp x21, x19
    B.LT _xuatPrime.loop

    ldr x21,[sp]
	add sp,sp,#8
    ldr x20,[sp]
	add sp,sp,#8
    ldr x19,[sp]
	add sp,sp,#8
    ldr x30,[sp]
	add sp,sp,#8
    ret

.global _findMax
_findMax:
    sub sp, sp, #8
    str x30, [sp]
    sub sp, sp, #8
    str x19, [sp]
    sub sp, sp, #8
    str x20, [sp]
    sub sp, sp, #8
    str x21, [sp]

    mov x19, x0 //x19 = n 
    mov x20, x1  //x20 = arr
    movz x21, #0 //i = 0
    ldur x22, [x20] //mx = first element

_findMax.loop:
    ldur x1, [x20]
    cmp x1, x22 
    B.LT _findMax.skip
    mov x22, x1

_findMax.skip:
    add x20, x20, #8
    add x21, x21, #1 
    cmp x21, x19
    B.LT _findMax.loop

    ldr x21,[sp]
	add sp,sp,#8
    ldr x20,[sp]
	add sp,sp,#8
    ldr x19,[sp]
	add sp,sp,#8
    ldr x30,[sp]
	add sp,sp,#8
    mov x0, x22
    ret

.global _findTBC
_findTBC:
    sub sp, sp, #8
    str x30, [sp]
    sub sp, sp, #8
    str x19, [sp]
    sub sp, sp, #8
    str x20, [sp]
    sub sp, sp, #8
    str x21, [sp]

    mov x19, x0 //x19 = n 
    mov x20, x1  //x20 = arr
    movz x21, #0 //i = 0
    movz x22, #0

_findTBC.loop:
    ldur x1, [x20]
    add x22, x22, x1

    add x20, x20, #8
    add x21, x21, #1 
    cmp x21, x19
    B.LT _findTBC.loop

    ldr x21,[sp]
	add sp,sp,#8
    ldr x20,[sp]
	add sp,sp,#8
    ldr x19,[sp]
	add sp,sp,#8
    ldr x30,[sp]
	add sp,sp,#8
    mov x0, x22
    ret

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
    B.LT _checkPrime.retFalse
    
    movz x19, #2
    mov x20, x1

_checkPrime.loop:
    cmp x19, x20
    B.eq _checkPrime.retTrue
    udiv x21, x20, x19 
    mul x22, x21, x19
    cmp x22, x20
    B.eq _checkPrime.retFalse

    add x19, x19, #1
    B _checkPrime.loop

_checkPrime.retTrue:
    movz x0, #1 //true
    B _checkPrime.return

_checkPrime.retFalse:
    movz x0, #0 //false
    B _checkPrime.return
	
_checkPrime.return:
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

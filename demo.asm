//Nhap xuat mang 1 chieu cac so nguyen
.extern print
.extern scanf

.section .data
	tb1: .asciz "Nhap n: "
	tb2: .asciz "a[%d]: "
	tb3: .asciz "Mang vua nhap la: \n"
	fmt1: .asciz "%d"
	fmt2: .asciz "%d\n"

.section .bss
	n: .space 8
	arr: .space 80

.section .text
.global main
main:
	//xuat tb1
	adrp x0,tb1
	add x0,x0,:lo12:tb1
	bl printf

	//Nhap n
	adrp x0,fmt1
	add x0,x0,:lo12:fmt1
	
	adrp x1,n
	add x1,x1,:lo12:n
	bl scanf
	
	//load dia chi mang arr vao x19
	adrp x19,arr
	add x19,x19,:lo12:arr
	
	//Load gia tri n vao x20
	adrp x20,n
	add x20,x20,:lo12:n
	ldur x20,[x20]

	//khoi tao i = 0
	movz x21,#0

Loop_Nhap:
	//xuat tb2
	adrp x0,tb2
	add x0,x0,:lo12:tb2

	mov x1,x21 // x1 = i
	bl printf

	//Nhap a[i]
	adrp x0,fmt1
	add x0,x0,:lo12:fmt1
	
	mov x1,x19
	bl scanf

	//Tang dia chi mang
	add x19,x19,#8
	//Tang i
	add x21,x21,#1

	//Neu i < n thi Lap
	cmp x21,x20
	B.LT Loop_Nhap

	//xuat tb2
	adrp x0,tb3
	add x0,x0,:lo12:tb3
	bl printf
	
	//load dia chi mang arr vao x19
	adrp x19,arr
	add x19,x19,:lo12:arr
	
	//khoi tao i = 0
	movz x21,#0
Loop_Xuat:
	//xuat a[i]
	adrp x0,fmt2
	add x0,x0,:lo12:fmt2
	ldur x1,[x19] // x1 = a[i]
	bl printf

	//Tang dia chi mang
	add x19,x19,#8 
	//Tang i
	add x21,x21,#1 
	//Neu i < n thi Lap
	cmp x21,x20
	B.LT Loop_Xuat
	
	
	#exit
	movz x0,#0
	movz x8,#93
	svc #0
    
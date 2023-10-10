        .arch armv7-a
        .arm
	.section .text
	.global main
	.type main, %function
main:	
	push {fp, lr} @将fp和lr压入堆栈，函数调用的标准前导代码
	sub sp, sp, #4 @在栈中开辟一块大小为4的内存地址，为整数变量分配4字节的空间
	ldr r0, =_cin    
	mov r1, sp @将sp的值传r1寄存器，r1指向之前分配的空间
	bl scanf
	ldr r6, [sp, #0] @取出sp指针指向的地址中的内容,此时r6=num
	add sp, sp, #4 @恢复栈顶，释放为整数变量分配的内存空间

	
	mov r7, #0 @r7寄存器存储a的值为0
	mov r8, #1 @b = 1
	mov r9, #1 @i = 1
	ldr r0, =_bridge       @输出一个1
	mov r1, r9 @将1赋给r1
	bl printf 
Loop:
	
	cmp r6, r9
	ble RETURN @比较r9和r6，即i和n的大小进行跳转
	mov r5, r8 @存储b的值 
	add r8, r8, r7 @b = a + b
	ldr r0, =_bridge
	mov r1, r8 @将b的值传给r1用于输出
	bl printf  @输出b的值
	mov r7, r5 @将b操作前的值赋给a
	add r9, r9, #1 @i++
	b Loop
RETURN:
	pop {fp, lr} @恢复寄存器
	bx lr @return 0
.data @数据段
_cin:
	.asciz "%d"
_bridge:
        .asciz "%d\n"

.section .note.GNU-stack,"",%progbits @ do you know what's the use of this :-)




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

	mov r7, #2 @i=2
	mov r8, #1 @f=1

	
Loop:
	
	cmp r6, r7
	blt RETURN @比较r7和r6，当r6小于r7时，即i>n时进行跳转
	mul r8,r8,r7    @f=f*i
	add r7,r7,#1    @i++
	b Loop
RETURN:
        ldr r0, =_bridge      
	mov r1, r8 @输出最终阶乘的值
	bl printf 
	pop {fp, lr} @恢复寄存器
	bx lr @return 0
.data @数据段
_cin:
	.asciz "%d"
_bridge:
        .asciz "%d\n"

.section .note.GNU-stack,"",%progbits @ do you know what's the use of this :-)




[org 0x7c00]

PIC_M_CMD equ 0x20
PIC_M_DATA equ 0x21

mov ax, 3
int 0x10 ;将显示模式设置成文本模式（清频）

mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00; 初始化堆栈

xchg bx, bx

;注册
mov word [8 * 4], clock
mov word [8 * 4 + 2], 0

;写入屏蔽字
mov al, 0b1111_1110
out PIC_M_DATA, al

;状态字 IF = 1
sti

loopa:
	mov bx, 3
	mov al, 'A'
	call blink
	jmp loopa
	
clock:
	xchg bx, bx
	iret

blink:
		push es
		push dx
		
		mov dx, 0xb800
		mov es, dx

		shl bx, 1
		mov dl, [es: bx]
		
		cmp dl, ' '
		jnz .set_space

	.set_char:
		mov [es: bx], al
		jmp .done
		
	.set_space:
		mov byte [es: bx], ' '
		
	.done:
		shr bx, 1
		
		pop dx
		pop es
		ret
	
times 510 - ($ - $$) db 0
db 0x55, 0xaa


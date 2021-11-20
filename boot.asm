[org 0x7c00]

mov ax, 3
int 0x10 ;将显示模式设置成文本模式（清频）

xchg bx, bx

mov ax, 5
mov bx, 6
mov bx, ax

mov ax, 0xefff
mov bx, 3
mul bx

halt:
	jmp halt
	
times 510 - ($ - $$) db 0
db 0x55, 0xaa


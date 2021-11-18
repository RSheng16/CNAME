
mov ax, 3
int 0x10 ;将显示模式设置成文本模式（清频）

mov ax, 0xb800
mov ds, ax

mov byte [0], 'h'
mov byte [2], 'e'

halt:
	jmp halt
	
times 510 - ($ - $$) db 0
db 0x55, 0xaa


;Read Character and display ascii value in decimal

.model small
.data

msg_1 db 10,13,'Enter Character: $'


.code
mov ax,@data
mov ds,ax

lea dx,msg_1	;display msg
mov ah,09h
int 21h


mov ah,01h 	;enter character
int 21h		;stores in al the ascci value
mov ah,00h

mov bx,010d
mov cx,0000h

lable1:	mov dx,0000h
	div bx
	push dx
	inc cx
	cmp ax,0000h
	jne lable1

loop1:	pop dx
	add dx,0048d	;or add 48d as 49 asccii is 1
	mov ah,02h	;Display character
	int 21h
	loop loop1

mov ah,4ch
int 21h
end



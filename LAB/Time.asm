;display TIME

.model small
.data

hour db ?
min db ?
sec db ?
msec db ?

.code
mov ax,@data
mov ds,ax

mov ah,2ch	;instruction to fetch time form machine
int 21h		;bios interupt

mov hour,ch	;instruction stores values as follows
mov min,cl
mov sec,dh
mov msec,dl

l1:	mov ax,0000h
	mov al,sec
	mov cx,0000h
	mov bl,010d
	div bl
	inc cx
	push dx
	cmp ax,0000h
	jne l1
l2:	pop dx
	add dx,30h
	mov ah,02h
	int 21h
	loop l2


mov ah,4ch
int 21h
end

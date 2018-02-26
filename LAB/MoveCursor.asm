;program to move cursor to specific postion

.model small
.code
mov ax,@data
mov ds,ax

mov ah, 02h	;02h is move instruction
mov bh, 00h	;page 0
mov dh, 12d	;row
mov dl, 39d	;column
int 10h		;bios interupt

mov ah,01h	;intrupt to read
int 21h

mov ah,4ch
int 21h
end
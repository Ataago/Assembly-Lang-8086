;program to clear screen

.model small
.code
mov ax,@data
mov ds,ax

mov ah,06h	;clear screen instruction
mov al,00h	;number of lines to scroll
mov bh,0CEh	;display attribute - colors
mov ch,01d	;start row
mov cl,05d	;start col
mov dh,24d	;end of row
mov dl,79d	;end of col
int 10h		;BIOS interrupt

;move cursor to middle

mov ah,02h	;move cursor Instruction
mov bh,00h	;Page 0
mov dh,12d	;row
mov dl,39d	;column
int 10h		;BIOS interrupt

mov ah,01h
int 21h

mov ah,4ch
int 21h
end
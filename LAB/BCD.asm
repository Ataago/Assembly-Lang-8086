;read a pair of input co-ordinates in BCD and move 
;the cursor to specific location on the screen

.model small
.data
msg_1 db 10,13,'Enter Row Number in Decimal: $'
msg_2 db 10,13,'Enter Col Number in Decimal: $'
row db ?
col db ?

.code
mov ax,@data
mov ds,ax

lea dx,msg_1
mov ah,09h
int 21h

call read_2Nib
mov row,al

lea dx,msg_2
mov ah,09h
int 21h

call read_2Nib
mov col,al

mov ah,02h
mov bh,00h
mov dh,row
mov dl,col
int 10h

mov ah,01h
int 21h

read_2Nib proc near
	mov ah,01h	;read character
	int 21h
	sub al,30h
	mov bl,al
	mov ah,01h
	int 21h
	sub al,30h
	mov ah,bl
	AAD
	ret
read_2Nib endp

mov row,al
mov ah,4ch
int 21h
end
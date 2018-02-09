;adding digits of number
.model small

.data
n1 db 34d
n2 db 10d
s db ?

.code
mov ax,@data
mov ds,ax

mov ax,0000h
mov al,n1
div n2
mov r,ah
add al,ah
mov s,al

mov ah,4ch
int 21h
end
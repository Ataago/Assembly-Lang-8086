;check even or odd

.model small

.data
n1 db 0bh
n2 db 02d
msge db 10,13,'Even$'
msgo db 10,13,'Odd$'

.code
mov ax,@data
mov ds,ax

mov ax,0000h
mov al,n1
div n2
cmp ah,00d
jnz odd

lea dx,msge
jmp exit

odd:    lea dx,msgo
        jmp exit
        
exit:   mov ah,09h
        int 21h
        mov ah,4ch
        int 21h
        end

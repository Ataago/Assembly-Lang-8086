;check (+)ve or (-)ve

.model small

.data
n1 dw 0b223h
msg_P db 10,13,'Positive$'
msg_N db 10,13,'Negative$'

.code
mov ax,@data
mov ds,ax

mov ax,n1
cmp ax,0000h
jge positive       ;jge is for sighned and jb is for unsighend

lea dx,msg_N
jmp exit

positive:       lea dx,msg_P

exit:   mov ah,09h
        int 21h
        mov ah,4ch
        int 21h
        end

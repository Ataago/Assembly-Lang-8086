;linear search
.model small

.data
array db 1,2,3,4,5
len db $-array
key db -2
msg_f db 10,13,'found$'
msg_nf db 10,13,'not found$'

.code
mov ax,@data
mov ds,ax

mov cx,0000h
mov cl,len
lea si,array
mov al,key

loop1:  cmp al,[si]
        je found

        inc si
        loop loop1

        lea dx,msg_nf
        jmp exit

        found:  lea dx,msg_f  

exit:   mov ah,09h
        int 21h
        mov ah,4ch
        int 21h
        end

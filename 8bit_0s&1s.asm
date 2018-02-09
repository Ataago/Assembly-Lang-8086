;No. of 1's and 0's in 8 bit no.

.model small

.data
n1 db 4h
no_1 db 00h
no_0 db 00h

.code
mov ax,@data
mov ds,ax

mov cx,0008h
mov al,n1

loop1:  rcr n1,01h
        jc No1		;jump on carry if yes

        inc no_0
        jmp skip

        No1:    inc no_1

        skip:   loop loop1



        mov ah,4ch
        int 21h
        end

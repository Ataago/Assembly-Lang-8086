;even and odds in an array
.model small

.data
a db 1,2,3,4,5
len db $-a
n1 db 02d
even_c db 00h
odd_c db 00h

.code
mov ax,@data
mov ds,ax

mov cx,0000h
mov cl,len
lea si,a

loop1:  mov ax,0000h
        mov al,[si]
        div n1
        cmp ah,00h
        je even_No

        inc odd_c
        jmp skip        

        even_No:   inc even_c

        skip:   inc si
                loop loop1

mov ah,4ch
int 21h
end
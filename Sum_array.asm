;add array elements
.model small

.data
array db 1,2,3,4,5
len db $-array
sum db ?

.code
mov ax,@data
mov ds,ax

mov cx,0000h
mov cl,len
mov ax,0000h
lea si,array

loop1:  add al,[si]
        inc si
        loop loop1

mov ah,4ch
int 21h
end

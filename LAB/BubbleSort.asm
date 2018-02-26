;bubble sort

.model small

.data
array db 7, 3, 2, 1, 4
len db $-array


.code
mov ax,@data
mov ds,ax

mov cx,0000h
mov cl,len
dec cx

outer:	mov di,cx					;for(i=0;i<n-1;i++) 
	lea si,array

Inner:	mov al,[si]
	cmp al,[si+1]
	jl continue
	xchg al,[si+1]
	mov [si],al

continue:	inc si
		loop Inner

	mov cx,di
	loop Outer

mov ah,4ch
int 21h
end
	
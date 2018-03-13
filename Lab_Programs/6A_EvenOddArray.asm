;6a.	Write an ALP to separate even and odd numbers from N array elements. 

;@author Mohammed Ataaur Rahaman

.model small
.data

array db 1,2,3,4,5,7,8,9
len dw $-array
.code
mov ax,@data
mov ds,ax

lea SI,array

mov BX,02d
loop1:
	mov al,[SI]
	div BX
	cmp DX,00h
	JNE odd
	mov 

;Binary Search

.model small
.data

array db 1,2,3,4,5
len dw $-array
key db 7
msg_f db 10,13,'Found$'
msg_nf db 10,13,'not found$'


.code
mov ax,@data
mov ds,ax

mov al,key		;storing key
lea si,array		;low
mov di,si		;high
add di,len
dec di

lable1:	cmp si,di		;while(low<high)
	jg NotFound
	
	mov bx,si		;mid as dx
	add bx,di
	SHR bx,01h		;(l+h)/2
	cmp al,[bx]		;if(key==a[mid])
	je Found	
	jg rightarray
	
	mov di,bx
	dec di
	jmp lable1
	
rightarray:	mov si,bx
		inc si
		jmp lable1
	
Found:	lea dx,msg_f
	jmp exit	
NotFound:	lea dx,msg_nf

exit:	mov ah,09h
	int 21h
	mov ah,4ch
	int 21
	end



;1a.	Write an ALP to conduct binary search for unsorted array of N numbers.

;@author Mohammed Ataaur Rahaman

.model small
.data
array db 7,3,2,4,1			;initializing an array
len dw $-array				;length of array i.e. n = 5
key db 3					;Search Element
msg_f db 10,13,'Found$'
msg_nf db 10,13,'Not found$'

.code
mov AX,@data
mov DS,AX


;Bubble sort 
mov Cx,len					;counter till n-1 = 4 
dec CX

outer:	
		mov DI,CX						;for(i=0;i<n-1;i++) 4 iterations 
		lea SI,array				
		
		Inner:	
			mov AL,[SI]					;for(j=0; j<n-1-i; j++)
			cmp AL,[SI+1]
			JL continue					;Jump if AL less than [SI + 1]
			xchg AL,[SI+1]				;swap
			mov [SI],AL
			continue:	inc SI
		loop Inner
		
		mov CX,DI			;reassigning counter for outer loop
loop Outer



;binary search
mov AL,key		;AL = key
lea SI,array	;low as SI
mov DI,SI		;high as DI
add DI,len
dec DI			

Lable1:	
	cmp SI,DI		;while(low<high)
	JG NotFound		;jump if SI greater than DI

	mov BX,SI		;mid as BX
	add BX,DI
	SHR BX,01h		;(l+h)/2 shift right
	cmp AL,[BX]		;if(key==a[mid])
	JE Found	
	JG rightarray
	
	mov DI,BX		;left array
	dec DI
JMP lable1

rightarray:
	mov SI,BX
	inc SI
jmp lable1
	
Found:	
	lea dx,msg_f
	jmp exit
	
NotFound:
	lea dx,msg_nf

exit:
	mov ah,09h
	int 21h

mov AH,4Ch
int 21h
end	
;6A ALP to separate even and odd numbers from an array elements

;@Author Mohammed Ataaur Rahaman

.model small
.data
array db 1,2,3,4,5,7,8,9,10,11,12,13,14,15,17,18    ;given array
len dw $-array
even_array db 10 dup(?)       ;array to store even numbers
odd_array db 10 dup(?)        ;array to store odd numbers

.code
mov AX,@data
mov DS,AX

lea BX,array  		  ;base pointer for given array
lea SI,even_array     ;base pointer for even array
lea DI,odd_array      ;base pointer for odd array

mov cx,len

loop1: 					;for i = n to 1
		mov AX,0000h	
        mov AL,[BX]		;store ith element in al
        mov dl,02h	
        div DL			;divide ith element by 2
        mov AL,[BX]		;restore ith in al to print, while preserving the remainder
        cmp AH,00h		;if remainder equals 0 mov al to even array
        JE push_even	

        mov [DI],AL		;push to odd array
        INC DI		
        JMP skip	

        push_even:		;push to even array
		mov [SI],AL
		INC SI

        skip:
        INC BX			;pointing to i+1 element
loop loop1

mov Ah,4ch
int 21h
end


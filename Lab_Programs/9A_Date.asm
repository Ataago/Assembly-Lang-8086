;9a.	Develop an assembly level program to display the system date at the centre of the screen. 

;@author Mohammed Ataaur Rahaman

.model small
.data

date db ?
month db ?
year dw ?	;16bits
msg_1 db 'dd/mm/yyyy: $'

.code
mov AX,@data
mov DS,AX

mov AH,2Ah		;instruction to read system date from pc
int 21h

mov year,CX
mov month,DH
mov date,DL

;clearing screen

mov ah,06h		;instruction to clear window
mov al,00h		;page scroll
mov bh,07h		;display attributes
mov cx,00h		;row:col start
mov dh,25d
mov dl,79d		;row:col end 
int 10h

;setting cursor to middle of the screen

mov ah,02h		;instruction to move cursor
mov bh,00h		;page
mov dh,12d		;row
mov dl,30d		;col
int 10h

;printing the date

lea DX,msg_1
call print_msg

mov AX,00h
mov AL,date
call print_16bit

mov DL,'/'
call print_char

mov AX,00h
mov AL,month
call print_16bit

mov dl,'/'
call print_char

mov AX,year
call print_16bit


mov AH,4Ch
int 21h

print_msg proc near
	;store the message address to be printed in DX
	mov AH,09h
	int 21h
	ret
print_msg endp

print_char proc near
	;store character to be printed(ASCII) in DL
	mov AH,02h
	int 21h
	ret
print_char endp

print_16bit proc near
	;Store 8bit decimal number in AX to be printed 
	mov BX,010d
	mov CX,00h
	
	loop_PUSH:
		mov DX,00h
		div BX
		push DX
		inc CX
		cmp AX,00h
	JNE loop_PUSH
	
	loop_POP:
		pop DX
		add DX,030h
		mov AH,02h
		int 21h
	loop loop_POP
	
	ret
print_16bit endp

end
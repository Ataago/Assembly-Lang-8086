;10a.	Read a pair of input co-ordinates in BCD and move the cursor to the specified location on the screen. 

;@author Mohammed Ataaur Rahaman

.model small
.data

row db ?
col db ?

msg_1 db 10,13,'Enter Row: $'
msg_2 db 10,13,'Enter Col: $'

.code
mov ax,@data
mov ds,ax

lea DX,msg_1		;accepting row value
call print_msg
call read_8bit
mov row,AL

lea DX,msg_2		;accepting col value
call print_msg
call read_8bit
mov col,AL

mov ah,02h			;instruction to move cursor
mov bh,0h
mov dh,row
mov dl,col
int 10h

mov ah,4ch
int 21h

read_8bit proc near
	;entered bcd will be stored in AL
	mov AH,01h		;read 1st char
	int 21h
	sub AL,30h
	mov BL,AL
	
	mov AH,01h		;read 2nd char
	int 21h
	sub AL,30h
	
	mov AH,BL
	AAD				;ASCCI adjust before division
	ret
read_8bit endp

print_msg proc near
	;store the address of message in DX
	mov ah,09h
	int 21h
	ret
print_msg endp

end
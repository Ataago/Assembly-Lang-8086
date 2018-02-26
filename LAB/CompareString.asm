; read 2 strings and compare if they are same

.model small
.data

msg_1 db 10,13,"Enter String 1: $"	;Entering the first string
buff1 db 100
len1 db ?
str1 db 100 dup(?)

msg_2 db 10,13,'Enter String 2: $'	;Entering the second string
buff2 db 100
len2 db ?
str2 db 100 dup(?)

msg_len1 db 10,13,'Length of string 1 is : $'
msg_len2 db 10,13,'Length of string 2 is : $'

msg_s db 10,13,'Strings are same!$'
msg_ns db 10,13,'Strings are not same.$'


.code
mov ax,@data
mov ds,ax
mov es,ax	;cmps works only in extra segment for some reason


lea dx,msg_1	;Enter string message
call display_m
lea dx,buff1	;Enter string 1
call input_s

lea dx,msg_2
call display_m
lea dx,buff2	;enter string 2
call input_s

mov al,len1
cmp al,len2
jne LenNotEqual		;lengths are not equal

lea SI,str1
lea DI,str2
;CLD
mov cx,0000h
mov cl,len1
rep cmpsb
je Str_Equal	;strings are same


LenNotEqual:	lea dx,msg_ns
		call display_m
		jmp exit

Str_Equal:	lea dx,msg_s
		call display_m

exit:	lea dx,msg_len1		;printing length of string 1
	call display_m
	mov dx,0000h
	mov dl,len1
	call display_c

	lea dx,msg_len2		;printing length of string 2
	call display_m
	mov dl,len2
	call display_c

	mov ah,4ch
	int 21h



display_m proc near	;Procedure for Displaying Mesagge
	mov ah,09h
	int 21h
	ret
	display_m endp

input_s proc near	;procedure to enter a string
	mov ah,0Ah
	int 21h
	ret
	input_s endp

display_c proc near	;procedure to display character in decimal
	add dl,30h	;converting the number to ascci value
	mov ah,02h	;character display
	int 21h	
	ret	
	display_c endp


	end
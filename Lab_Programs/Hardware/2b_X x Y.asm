;2b.	Read the status of two 8-bit inputs (X & Y) from the 
;	Logic Controller Interface and display X*Y.


;@author Mohammed Ataaur Rahaman

.MODEL SMALL
PRINTF MACRO MSG
	LEA DX,MSG
	MOV AH,09H
	INT 21H
ENDM

.DATA
PA EQU 0D800H
PB EQU 0D801H
PC EQU 0D802H
CW EQU 0D803H

M1 DB 10,13,'Enter 1st 8 bit Number: $'
M2 DB 10,13,'Enter 2nd 8 bit Number: $'

.CODE
MOV AX,@DATA
MOV DS,AX

MOV AL,82H	;port B as input
MOV DX,CW
OUT DX,AL

PRINTF M1	;reading first 8 bit
MOV AH,08H	;character no echo
INT 21H
MOV DX,PB
IN AL,DX
MOV BL,AL

PRINTF M2	;reading second 8 bit
MOV AH,08H	;character no echo
INT 21H
MOV DX,PB
IN AL,DX

MUL BL		;X*Y.. multiplying

MOV DX,PA	;displaying LSB on LCI 
OUT DX,AL

CALL DELAY

MOV AL,AH	;displaying MSB on LCI
MOV DX,PA	
OUT DX,AL

MOV AH,4CH
INT 21H

DELAY PROC NEAR
	MOV SI,0FFFFH
	Outer: 
		MOV DI,0FFFFH
		Inner:
			DEC DI
		JNZ Inner
		DEC SI
	JNZ Outer
	RET
DELAY ENDP

END	
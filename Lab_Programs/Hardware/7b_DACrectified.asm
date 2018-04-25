;7b.	ALP to generate half wave and full wave rectified output using DAC interface

;@author Mohammed Ataaur Rahaman

.MODEL SMALL
.DATA
;((2.25/2) + sin(Theta))*100
;where v ref is 2.25
TABLE DB 127,144,161,177,191,204,214,225,227,225,221,214,204,191,177,161,144,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d,127d
;half wave
PA EQU 0D800H
PB EQU 0D801H
PC EQU 0D802H
CW EQU 0D803H

.CODE
MOV AX,@DATA
MOV DS,AX

MOV DX,CW
MOV AL,80H		;all are output ports
OUT DX,AL

L2:	
	MOV CX,37D		;loop for 27 times i.e one full wave 
	MOV DX,PA
	LEA SI,TABLE	;out the table values through port A
	
	L1:
		MOV AL,[SI]
		OUT DX,AL
		INC SI
	LOOP L1

JMP L2

MOV AH, 4CH
INT 21H

END
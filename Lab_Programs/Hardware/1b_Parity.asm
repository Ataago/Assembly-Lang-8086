;1b.	Read the status of eight input bits from the Logic Controller Interface 
;	and display ‘FF’ if it is the parity of the input read is even, otherwise display 00.


;@author Mohammed Ataaur Rahaman

.MODELSMALL
.DATA

PA EQU 0D800H
PB EQU 0D801H
PC EQU 0D802H
CW EQU 0D803H

.CODE
MOV AX,@DATA
MOV DS,AX

MOV AL,82H	;port B as input, rest(Port A) are outputs
MOV DX,CW
OUT DX,AL

MOV DX,PB	;reading input form LCI
IN AL,DX
ADD AL,00H
JPE evenP 	;jump parity equal

MOV AL,00H	;display '00' as odd parity on PA
MOV DX,PA
OUT DX,AL
JMP EXIT

evenP:
	MOV AL,0FFH		;display 'ff' as even parity PA
	MOV DX,PA
	OUT DX,AL

EXIT:
	MOV AH,4CH
	INT 21H
END
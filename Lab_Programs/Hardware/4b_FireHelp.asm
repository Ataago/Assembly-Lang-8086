;4b.	Display messages �FIRE� and �HELP� alternately with flickering effects on a 7-segment display interface for a suitable period of time. 
;		Ensure a flashing rate that makes it easy to read both the messages 
;		(Examiner does not specify these delay values nor is it necessary for the student to compute these values).    

;@author Mohammed Ataaur Rahaman

.MODEL SMALL
.DATA

M1 DB 86H, 0AFH, 0CFH, 8EH		; E r I F 
M2 DB 8CH, 0C7H, 86H, 89H		; P L E H 

PA EQU 0D800H
PB EQU 0D801H
PC EQU 0D802H
CW EQU 0D803H

.CODE
MOV AX,@DATA
MOV DS, AX

MOV DX,CW
MOV AL,80H		;all ports are output
OUT DX,AL

L3: 
	LEA SI, M1		;display FIRE
	CALL DISPLAY
	CALL DELAY

	LEA SI, M2
	CALL DISPLAY	;display HELP 
	CALL DELAY
	CALL STOP
JMP L3

EXIT:
   MOV AH,4CH
   INT 21H

DISPLAY PROC NEAR		;display using port B for LED
   MOV CX,04H
   letter: 
		MOV BL,08H
		MOV AL,[SI]
		segments: 
			ROL AL,01H
			MOV DX,PB	;7 segment display with port B  
			OUT DX,AL
		
			PUSH AX
			MOV AL,00H	;clock trigger 
			MOV DX,PC
			OUT DX,AL
			MOV AL,01H
			OUT DX,AL
			POP AX
		
			DEC BL
		JNZ segments
		
		INC SI
	LOOP letter
RET
DISPLAY ENDP

STOP PROC NEAR
	MOV AH,01H
	INT 16H		;if nothing in keyboard buffer
	JNZ EXIT
	RET
STOP ENDP

DELAY PROC NEAR
	PUSH SI
	
	MOV SI,0FFFFH
	Outer: 
		MOV DI,0FFFFH
		Inner:
			DEC DI
		JNZ Inner
		DEC SI
	JNZ Outer
	
	POP SI
	RET
DELAY ENDP

END
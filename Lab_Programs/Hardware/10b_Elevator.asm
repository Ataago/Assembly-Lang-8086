;10b. 	Drive an elevator interface in the following way:        
;			i.	Initially the elevator should be in the ground floor, with all requests in OFF state.           
;			ii.	When a request is made from a floor, the elevator should move to that floor,
;				wait there for a couple of seconds (approximately), and then come down to ground floor and stop.
;				If some requests occur during going up or coming down they should be ignored.

;@author Mohammed Ataaur Rahaman

.MODEL SMALL
.DATA

PA EQU 0D800H
PB EQU 0D801H
PC EQU 0D802H
CW EQU 0D803H

CLEAR DB 0E0H,0D0H,0B0H,70H 
;Ports PA7-PA4 
;GF 	1110
;FF 	1101
;SF 	1011
;TF 	0111

.CODE
MOV AX,@DATA
MOV DS,AX

MOV DX,CW
MOV AL,82H		;port B is Input
OUT DX,AL

LEA SI,CLEAR
MOV AL,0F0H		;clear SR flip flop PA4-PA7
MOV DX,PA
OUT DX,AL

NOREQ:
	CALL REQUEST	;read input from Elevator Key
JZ NOREQ

SHR AL,01H		;1110 ground
JNC GF
SHR AL,01H		;1101 first
JNC FF
SHR AL,01H		;1011 second
JNC SF
JMP TF			;0111 third

GF:
	CALL DELAY
	CALL RESET		;stays at Ground floor
	JMP EXIT

FF:
	MOV CX,03H		;initialize counter to 3  
	CALL MOVEUP
	
	PUSH AX			;store ax = 1111 0011, al = 3
	CALL DELAY		
	INC SI			;si points to FF = 1101
	CALL RESET		;stay at that floor
	MOV CX,03H		;initialize counter to 3 again to move down
	POP AX
	
	CALL MOVEDOWN
	JMP EXIT

SF:
	MOV CX,06H
	CALL MOVEUP
	PUSH AX
	CALL DELAY
	ADD SI,02
	CALL RESET
	MOV CX,06H
	POP AX
	CALL MOVEDOWN
	JMP EXIT

TF:
	MOV CX,09H
	CALL MOVEUP
	PUSH AX
	CALL DELAY
	ADD SI,03H
	CALL RESET
	MOV CX,09H
	CALL MOVEDOWN
	POP AX
	JMP EXIT

EXIT:
	MOV AH,4CH
	INT 21H

	
REQUEST PROC NEAR
	MOV DX,PB		;read from Port B
	IN AL,DX
	AND AL,0FH
	CMP AL,0FH
	RET
REQUEST ENDP

RESET PROC NEAR		;out SI to port A
	MOV DX,PA
	MOV AL,[SI]
	OUT DX,AL
	RET
RESET ENDP

MOVEUP PROC NEAR	;out AL to port A
	MOV DX,PA
	MOV AL,0F0H
	L1:
		OUT DX,AL
		CALL DELAY
		INC AL
	LOOP L1
	OUT DX,AL
	RET
MOVEUP ENDP

MOVEDOWN PROC NEAR	;out AL to port A
	MOV	DX,PA
	L2:
		OUT DX,AL
		CALL DELAY
		DEC AL
	LOOP L2
	OUT DX,AL
	RET
MOVEDOWN ENDP

DELAY PROC NEAR
	PUSH SI
	PUSH DI

	MOV SI,0FFFFH
	Outer: 
		MOV DI,0FFFFH
		Inner:
			DEC DI
		JNZ Inner
		DEC SI
	JNZ Outer
	
	POP DI
	POP SI
	RET
DELAY ENDP

END
;

StkSeg SEGMENT PARA STACK 'STACK'
 DB 100h DUP(?)
StkSeg ENDS

;
;
;
DataSeg SEGMENT WORD 'DATA'
	Message DB 'Hello World', 10, 13,'$'
DataSeg ENDS
;
;
CodeSeg SEGMENT WORD 'CODE'
	ASSUME CS:CodeSeg, DS:DataSeg
Begin:
	MOV AX, DataSeg
	MOV DS, AX
	MOV DX, offset Message
	MOV AH, 9
	INT 21h
	MOV AH, 4Ch
	INT 21h
CodeSeg ENDS
;
END Begin
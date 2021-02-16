;
;
StkSeg SEGMENT PARA STACK 'STACK'
	DB 200h DUP (?)
StkSeg ENDS
;
;
DataS SEGMENT WORD 'DATA'
HelloMessage DB 13 ; chuyen ve dau dong
	DB 10 ; xuong dong
	DB 'Hello, world !' 
	DB '$'
DataS ENDS
;
;
CodeS SEGMENT WORD 'CODE'
	ASSUME CS:CodeS, DS:DataS; chuyen CS= CodeS, DS = DataS 
DispMsg:
	mov AX,DataS 
	mov DS,AX 
	mov CX, 3 ; Lenh lap
	
	;mov AH,9  ; Lenh In xau
	mov DX,OFFSET HelloMessage 
PRINT_LOOP:
	;mov DX,OFFSET HelloMessage 
	mov AH,9  ; Lenh In xau
	int 21h 
	;mov AH,7 ; Lenh nhap vao ky tu luw vao 
	;INT 21h 
	LOOP PRINT_LOOP
;END_PRINT_LOOP:
	mov AH,4Ch 
	int 21h
CodeS ENDS
;
END DispMsg
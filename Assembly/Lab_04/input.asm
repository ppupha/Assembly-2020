
PUBLIC INPUT_MATRIX

EXTRN MAT: BYTE
EXTRN ROW_NUM: BYTE
EXTRN COL_NUM: BYTE
EXTRN OUTPUT_SYM: NEAR
EXTRN ENTERR: NEAR


DATAS SEGMENT WORD PUBLIC 'DATA'
	MSG1 db 'Input row$'
	MSG2 db 'Input col$'
	MSG3 db 'Input Matrix','$'
DATAS ENDS

CODES SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CODES, DS:DATAS

INPUT_SYM:
	;MOV AX, SEG MAT
	;MOV DS, AX
	mov ah, 2
	mov dl, '?'
	int 21h
	
	mov ah, 1
	int 21h
	

	ret
	
INPUT_MATRIX:
	;COMMENT *
	; nhap so hang	
	call ENTERR
	mov dx, offset MSG1
	mov ah, 09h
	int 21h
	
	call INPUT_SYM
	mov ROW_NUM, al
	sub ROW_NUM, '0' ;'4' ->4
	
	;nhap so cot
	call ENTERR
	mov dx, offset MSG2
	mov ah, 09h
	int 21h
	
	call INPUT_SYM
	mov COL_NUM, al
	sub COL_NUM, '0'
	
	
	mov AL, ROW_NUM
	mul COL_NUM
	
	mov cx, ax
	CMP cX, 0
	JE END_INPUT_LOOP
	
	mov dx, offset MSG3
	mov ah, 09h
	int 21h
	mov SI, OFFSET MAT
	
	;COMMENT *	
	INPUT_LOOP:
		call ENTERR
		call INPUT_SYM
		mov [SI], al
		add SI, 1
		LOOP INPUT_LOOP
	END_INPUT_LOOP:
	;*	
	ret
CODES ENDS

END
	
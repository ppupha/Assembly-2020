PUBLIC M
PUBLIC inp
;EXTRN END_JMP: far

DATAS SEGMENT WORD PUBLIC 'DATA'
	M db 1
	MSG db 'Input N: $'
DATAS ENDS

CODES1 SEGMENT WORD 'CODE'
	ASSUME CS:CODES1, DS:DATAS

inp LABEL FAR
	mov dx, offset MSG
	mov ah, 9
	int 21h
	
	mov ah, 1
	int 21h
	
	mov M, al
	sub M, '0'
	RETF
	;JMP END_JMP
;inp ENDP

	
CODES1 ENDS

END

COMMENT *
;IF al >= 1 al =< '9'
	cmp al, '0'
	JNGE ELSE_
	cmp al, '9'
	JNLE ELSE_
	;then
	mov M, al
	sub M, '0'
	JMP END_IF
ELSE_:
	mov ah, 09h
	mov DX, OFFSET ERR_MSG
	int 21h
	mov M, 0
END_IF:

*
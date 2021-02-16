;Lab 03
EXTRN M: byte
EXTRN inp: far
;PUBLIC END_JMP

SSTK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
SSTK ENDS

DATAS SEGMENT PARA PUBLIC 'DATA'
	Z db 'Z'
DATAS ENDS

CODES SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CODES, DS:DATAS
main:
	mov ax, DATAS
	mov ds, ax
	
	;JMP inp
	CALL inp
	
;END_JMP LABEL FAR
	mov ah, 2
	mov dl, 0Dh
	int 21h
	
	mov dl, 0Ah
	int 21h
	
	XOR CX, CX
	mov cl, M
	cmp cx, 0
	
	je END_PRINT_LOOP
	
	PRINT_LOOP:
		mov dl, Z
		int 21h
		Loop print_loop
	END_PRINT_LOOP:
	
	mov ax, 4c00h
	int 21h

CODES ENDS

END main
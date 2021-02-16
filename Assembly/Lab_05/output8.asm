PUBLIC out_num8

EXTRN num16: word
EXTRN OUTPUT_SYM: near
EXTRN enterr: near
EXTRN out_str: near

DATAS SEGMENT WORD PUBLIC 'DATA'
	msg8 db 'Signed Num in 8: $'
	num8 db 7 DUP('0'), '$', '$'
DATAS ENDS

CODES SEGMENT WORD PUBLIC 'CODE'
	ASSUME CS:CODES, DS:DATAS
	
from16to8:
	mov AX, num16
	mov SI, 6
	xor DX, DX
	mov BX, 8
	
	CMP AX, 0
	JGE LOOP1 
	NEG AX
	
	LOOP1:
		DIV BX
		MOV num8[SI], DL
		add num8[SI], '0'
		mov DL, 0
		DEC SI
		JNS LOOP1
	END_LOOP_1:
		
	ret
	
out_num8:
	call enterr
	LEA dx, msg8
	call out_str

	call from16to8
	
	mov ax, num16
	cmp ax, 0
	JGE IS_POS
		mov dl, '-'
		call OUTPUT_SYM
	
	IS_POS:
	
	mov SI, 0
	LOOP_:
		cmp num8[SI], '0'
		JNE END_LOOP_
		add SI, 1
		JMP LOOP_
	END_LOOP_:
	
	cmp num8[SI], '$'
	JNE END_out_num8
		SUB SI, 1
	
	END_out_num8:
	
	LEA dx, num8[SI]
	call out_str
	
	ret
CODES ENDS
END
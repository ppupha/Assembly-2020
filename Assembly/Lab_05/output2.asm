; output

PUBLIC out_num2

EXTRN OUTPUT_SYM: near
EXTRN enterr: near
EXTRN out_str: near
EXTRN num16: word

DATAS SEGMENT WORD PUBLIC 'DATA'
	msg2 db 'Unsigned Num in 2: $'
	num2 db 16 DUP('0'), '$', '$'
DATAS ENDS

CODES SEGMENT WORD PUBLIC 'CODE'
	ASSUME CS:CODES, DS:DATAS
	
from16to2:
	mov ax, num16
	mov SI, 15
	
	LOOP1:
		mov num2[SI], '0'
		TEST ax, 1 ; kiem tra tinh chan le
		JZ IS_EVEN 
		; neu la so le(ZF = 0)
		add num2[SI], 1
		IS_EVEN: ; neu la so chan
		SHR AX, 1 ; ax = ax / 2
		DEC SI
		JNS LOOP1
	END_LOOP:
	ret
	
out_num2:
	call from16to2
	
	call enterr
	
	mov SI, 0
	;
	LOOP_:
		cmp num2[SI], '0'
		JNE END_LOOP_
		add SI, 1
		JMP LOOP_
	END_LOOP_:
	
	cmp num2[SI], '$'
	JNE END_out_num2
	SUB SI, 1
	
	END_out_num2:
	
	LEA dx, msg2
	call out_str
	
	LEA dx, num2[si]
	call out_str
	
	ret
CODES ENDS
END

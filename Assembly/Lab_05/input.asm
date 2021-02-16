; Input String

PUBLIC inpnum16

EXTRN num16: word
EXTRN enterr: near

DATAS SEGMENT WORD PUBLIC 'DATA'
	msginput db 'Input  Signed Num in 16: $'
	str16 db 8 DUP('$')
	
DATAS ENDS

CODES SEGMENT WORD PUBLIC 'CODE'
	ASSUME CS: CODES, DS:DATAS
inpnum16:
	; In xau ra man hinh
	
	call enterr
	mov ah, 09
	mov dx, offset msginput
	int 21h

	; nhap vao mot xau so hex
	; input string
	mov ah, 0Ah
	LEA dx, str16
	int 21h
	
	;chuyen xau thanh so
	xor bx, bx
	xor SI, SI
	mov DI, 2
	xor ax, ax
	; from string to num
	LOOP_TRAN:
		CMP str16[DI], 0Dh
		JE END_LOOP_TRAN
		CMP str16[DI], '-'
		JE IS_NEG
		mov bl, 16
		mul bx
		mov bl, str16[DI]
		add ax, bx
		cmp bl, '9'
		JG IS_SYM
			sub ax, '0'
			JMP NEXT_LOOP
		
		IS_SYM:
			sub ax, 'A'
			add ax, 10
			JMP NEXT_LOOP
		;add ax, bx
		IS_NEG:
			mov SI, 1
			JMP NEXT_LOOP
		NEXT_LOOP:
			ADD DI, 1
			JMP LOOP_TRAN
	END_LOOP_TRAN:
	
	CMP SI, 1
	JNE END_inpnum16
		NEG ax ; ax < 0 ax = -ax
	END_inpnum16:
		mov num16, ax
	ret
CODES ENDS
END
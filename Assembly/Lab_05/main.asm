;Lab 05

EXTRN inpnum16: near
EXTRN out_num2: near
EXTRN out_num8: near
EXTRN out_menu: near

EXTRN out_str:near
EXTRN enterr:near

PUBLIC num16

;stack segment
STKS SEGMENT PARA STACK 'STACK'
	db 200h DUP(?)
STKS ENDS

;data segment
DATAS SEGMENT PARA PUBLIC 'DATA'
	funs dw inpnum16, out_num2, out_num8
	msg db 'Input Your choise: $'
	num16 dw 0
	err db 'Error!!!$'
	;num8 db 6 DUP('8'), '$'
	
DATAS ENDS

; code segment

CODES SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS: CODES, DS: DATAS

main:
	mov ax, DATAS
	mov ds, ax
	
	MAIN_LOOP:
		call out_menu
		mov ah, 01h
		int 21h
		sub al, '0'
		
		cmp al, 0 ; ==0: exit
		je END_MAIN
		jl out_err ; <0: error
		cmp al, 3
		jg out_err ; >3: error
		sub al, 1
		mov ah, 2
		mul ah; al*ah = ax
		
		mov bx, ax
		call funs[bx]
		JMP MAIN_LOOP
		out_err:
			call enterr
			lea dx, err
			call out_str
			JMP MAIN_LOOP
	
	
	END_MAIN:
		mov ax, 4C00h
		int 21h
CODES ENDS

END main



PUBLIC OUTPUT_SYM
PUBLIC enterr
PUBLIC out_str
PUBLIC out_menu

DATAS SEGMENT WORD PUBLIC 'DATA'
	choise0 db '0.Exit$'
	choise1 db '1.Input unsigned num 16$'
	choise2 db '2.Output unsigned num in 2$'
	choise3 db '3.Output signed num in 8$'
	choises dw choise0, choise1, choise2, choise3
DATAS ENDS

CODES SEGMENT WORD PUBLIC 'CODE'
	ASSUME CS:CODES, DS: DATAS

OUTPUT_SYM:
	mov ah, 2
	int 21h
	ret
	
enterr:
	mov dl, 0Ah
	call OUTPUT_SYM
	mov dl, 0Dh
	call OUTPUT_SYM
	ret

out_str:
	mov ah, 09h
	int 21h
	ret
	
out_menu:
	call enterr
	xor SI, SI
	
	mov cx, 4
	LOOP_MENU:
		call enterr
		mov `, choises[SI]
		call out_str
		ADD SI, 2
		LOOP LOOP_MENU
		
	call enterr
	
	ret
	
CODES ENDS
END
PUBLIC output_X
EXTRN X: byte

DS2 SEGMENT AT 0b800h ;0B8000h is the address of VGA card for text mode

	CA LABEL byte
	; size 25 * 80
	;1 cell = 2 byte
	;1 row = 80 cel = 80 * 2 byte
	;80 * 2 * 2 = 2 rows
	;2 * 2 = 2 cells
	ORG 80 * 2 * 2 + 2 * 2
	SYMB LABEL word
DS2 ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, ES:DS2
output_X proc near
	mov ax, DS2
	mov es, ax
	mov ah, 12; red 1 100 = 12 0100 = 4
	mov al, X
	mov symb, ax
	ret
output_X endp
CSEG ENDS
END
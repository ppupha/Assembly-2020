PUBLIC output
EXTRN number: byte
EXTRN string: byte
EXTRN simvol: byte



CSEG SEGMENT PARA public 'CODE'
	assume  CS:CSEG
	
	
output proc near
	
	xor bx, bx
	
	mov bl, number
	
	mov al, string[bx+2]
	mov simvol, al

	;add simvol, '0' ;  
	
	mov dl, simvol
	mov ah, 02
	int 21h

		
	ret				;vozvrasheniye iz procedury
	
output endp
CSEG ENDS

END		
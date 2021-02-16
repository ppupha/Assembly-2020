PUBLIC number
PUBLIC string
PUBLIC simvol

EXTRN output: near


SSEG SEGMENT PARA STACK 'STACK'
	DB 200h DUP(?)
SSEG ENDS


DSEG SEGMENT word  PUBLIC 'DATA'
	string db 100h DUP ('$')
	org 100h
	
	number db 0
	simvol db '0'	
	
	message1 db "vvedite stroku: $"
	message2 db "vvedite chislo: $"
	crlf     db 0Dh, 0Ah, '$'    		;perevod stroki 
	lenstring db 0
	
	
DSEG ENDS
	
	
CSEG SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG, DS:DSEG
	
start:
	mov ax, DSEG
	mov ds, ax
	
	mov dx, offset  message1    ; priglasheniye na vvod stroki
	mov ah, 9                   ; vyvod na ekran
	int 21h                     ;preryvaniye dos
	
	
	mov dx, offset string       ;bufer v registr so smesheniyem
	mov ah, 0Ah                 ;schitat stroku v string
	int 21h                     ; preryvaniye dos
	
	mov dx, offset crlf
	mov ah, 9
	int 21h                     ;perevod stroki
	

	
	mov dx, offset message2     ;priglasheniye na vvod chisla
	mov ah, 9
	int 21h
	
	
	mov ah, 01h 				;schityvayem kod simvola
	int 21h
	mov number, al
	
		
	mov dx, offset crlf
	mov ah, 9
	int 21h 

	
	
	

	sub number, '0'      		;poluchayem chislo

		
	call output
	
	
	mov ah, 4Ch
	int 21h
	
	
	

CSEG ENDS


	END start

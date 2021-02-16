.MODEL TINY

.DATA
	isInst dw 1234h
    OLD9 dd ?
	MSG1 db 'Press "9" to show time', 0Ah, 0Dh, '$'
    MSG2 db 'Uninstalled!', 0Ah, 0Dh, '$'
.CODE
.STARTUP

START:
    JMP INIT
	

;  outnum in al
OUT_NUM PROC

	PUSH BX
	
	MOV AH, 0; AX = 00AL
	MOV BL, 10
	DIV BL; AX / BL
	
	MOV BX, AX; save ax in bx

    ; 12 = 1010 = RED
	MOV AH, 12
	MOV AL, BL
	ADD AL, '0'
	STOSW; output es:di <- ax; di = di + 2

	MOV AL, BH
	ADD AL, '0'
	STOSW
	
	POP BX
	RET
	
OUT_NUM ENDP



OUT_SYM PROC

	PUSH AX
	
	MOV AH, 12
	MOV AL, ":"
	STOSW
	
	POP AX
	
	RET
	
OUT_SYM ENDP

OUT_STR PROC

	MOV AH, 09H
	INT 21H
	RET
	
OUT_STR ENDP

NEW9 PROC
	; save registers
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX

	PUSH ES
	PUSH DS
	
	PUSHF; save flags
	
	; keyboard interrupt 
    CALL CS:OLD9
	
	; get keyboard status
	; AL = ascii character
    MOV AH, 1
    INT 16H

	; key 't' pressed
    cmp AL, '9'
    jne OVER
	; text mode
    mov ax, 0B800h
    mov es, ax
    mov DI, 140; 

	; get system time
	;CH = hour 
	;CL = minute 
	;DH = second 
	;DL = 1/100 seconds
    mov ah, 2CH
    int 21h

	; output hour
	MOV AL, CH
	CALL OUT_NUM
	; output symbol ':'
	CALL OUT_SYM

    ; output minute
	MOV AL, CL
	CALL OUT_NUM
	CALL OUT_SYM

	; output second
	MOV AL, DH
	CALL OUT_NUM
	
	
    
    OVER: 
		;POPF
        POP DS
        POP ES

        POP DX
        POP CX
        POP BX
        POP AX

        IRET
		;JMP CS:OLD9
NEW9 ENDP

INIT:
	; get interrupt vector, address: ES:BX
    ; function 35h int21h, INT09h - interrupt
	MOV AL, 09h
	MOV AH, 35h
	INT 21H
	
	CMP ES:isInst, 1234h
    JE MY_UNINSTALL ; ES = SEG NEWINT9

	; Save interrupt vector int 09h
    MOV WORD PTR OLD9, BX
    MOV WORD PTR OLD9 + 2, ES

	; set interrupt vector: input: DS:DX = new address
	MOV AL, 09H
	MOV DX, OFFSET NEW9
	MOV AH, 25H
	INT 21H
	
	; show notif
	MOV DX, OFFSET MSG1
    CALL OUT_STR
	
	;Terminate and Stay Resident
	MOV DX, OFFSET INIT
	INT 27H

MY_UNINSTALL:
	PUSH ES
    PUSH DS
	
	; return address int 09h to interrupt table 
	MOV DX, WORD PTR OLD9
	MOV DS, WORD PTR OLD9 + 2
	MOV AL, 09H
	MOV AH, 25H
	INT 21H
	
	POP DS
    POP ES

	; free memory
	;MOV AH, 49H
	;INT 21H
	MOV isInst, 1001H
	; show notif
	MOV DX, OFFSET MSG2
    CALL OUT_STR
	
	; return to DOS
	MOV AX, 4C00h
	INT 21H

;CODE ends
end
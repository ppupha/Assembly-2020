.MODEL TINY

.DATA
	OLD dd ?
	MSG1 db 'Press "9" to show time  $'
.CODE
.STARTUP

START:
    jmp INIT

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

NEW PROC
	; save registers
	;PUSHF
; CALL
; IP CS in stack
;SP - 2
;CS <- 
;SP -2
; IP <-

	PUSHF
	;	call INT 1C 
    CALL CS:OLD
	;->IRET
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH ES
	PUSH DS
	
	
	
	; get keyboard status
	; AL = ascii character
    ;MOV AH, 1
    ;INT 16H

	; key 't' pressed
    ;cmp AL, '9'
    ;jne OVER
	
	
	; text mode
    mov ax, 0B800h
    mov es, ax
    mov DI, 69 * 2; 

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
	
	CALL OUT_SYM
	MOV AL, DL
	CALL OUT_NUM
	
	STD
	
	
	OVER: 
        POP DS
        POP ES
        POP DX
        POP CX
        POP BX
        POP AX
        IRET
		;POP IP
		;POP CS
		;POPF
NEW ENDP

INIT:
	; get interrupt vector, address: ES:BX
    ; function 35h int21h, INT1Ch - interrupt
	MOV AL, 1Ch
	MOV AH, 35h
	INT 21H

	; Save adddress interrupt vector int 1Ch
    MOV WORD PTR OLD, BX
    MOV WORD PTR OLD + 2, ES

	; set interrupt vector: input: DS:DX = new address
	MOV AL, 1CH
	MOV DX, OFFSET NEW
	MOV AH, 25H
	INT 21H
	
	; show notif
	;MOV DX, OFFSET MSG1
    ;CALL OUT_STR
	
	;Terminate and Stay Resident
	;DX = offset of last byte in program to remain resident plus 1 (freed)
	MOV DX, OFFSET INIT
	INT 27H
	
end
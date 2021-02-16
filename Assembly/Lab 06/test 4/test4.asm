sseg segment word stack "STACK"
	db 100 dup(0)
sseg ends

cseg segment word public "CODE"
	assume cs:cseg
	
start:
	; Keyboard Interrupt
    int 9h
	; get keyboard status
	; AL = ascii character
    mov ah, 1
    int 16h

	; last key = enter
    cmp al, 0Dh
    jne quit
    
	; text mode , ES = 0B800h, ES:DI
    mov ax, 0B800h
    mov es, ax
    mov DI, 80 * 2 * 24 + 60 * 2

	; read real time clocktime
    ;CH         Hours (BCD)
    ;CL         Minutes (BCD)
    ;DH         Seconds (BCD)
    ;DL         1 if daylight saving time option; else 0
    ;mov ah, 02
    ;int 1AH

	; get system time
	;CH = hour 
	;CL = minute 
	;DH = second 
	;DL = 1/100 seconds
    xor cx, cx
    mov ah, 2CH
    int 21h

    xor ax, ax
	; hour
    mov al, ch
    mov bl, 10
    div bl

    mov bx, ax

    mov ah, 12; white = 1 111 = 15
    mov al, bl
    add al, '0'
    stosw

    mov al, bh
    add al, '0'
    stosw

    mov al, ":"
    stosw

    xor ax, ax ; минуты

    mov al, cl
    mov bl, 10
    div bl

    mov bx, ax

    mov ah, 12
    mov al, bl
    add al, '0'
    stosw

    mov al, bh
    add al, '0'
    stosw

    mov al, ":"
    stosw

    xor ax, ax; секунды

    mov al, dh
    mov bl, 10
    div bl

    mov bx, ax

    mov ah, 12
    mov al, bl
    add al, '0'
    stosw

    mov al, bh
    add al, '0'
    stosw
quit:
	mov ah, 4Ch
	int 21h
cseg ends
end start

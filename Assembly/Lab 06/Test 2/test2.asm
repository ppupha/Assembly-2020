.model tiny

CODE SEGMENT
    assume cs:code, ds:code
    org 100h

main:
    jmp init
    OLD9 dd ?
    is_installed dw 1337

NEW9 proc
    push ax
    push bx
    push cx
    push dx

    push es
    push ds
    pushf

	; output string func 09 int 21h
    call cs:OLD9

	; get keyboard status
	; AL = ascii character
    mov ah, 1
    int 16h

    cmp al, 'a'
    jne quit
    
	; text mode
    mov ax, 0B800h
    mov es, ax
    mov DI, 300; ????????????????????????

	; read real time clocktime
    ;CH         Hours (BCD)
    ;CL         Minutes (BCD)
    ;DH         Seconds (BCD)
    ;DL         1 if daylight saving time option; else 0
    mov ah, 02
    int 1AH

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

    mov ah, 15
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

    mov ah, 15
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

    mov ah, 15
    mov al, bl
    add al, '0'
    stosw

    mov al, bh
    add al, '0'
    stosw

    quit:
        pop ds
        pop es

        pop dx
        pop cx
        pop bx
        pop ax

        iret

NEW9 endp

init:
	; get interrupt vector, address: ES:BX
    mov ax, 3509h; function 35h int21h, 09 - interrupt
    int 21h

    cmp es:is_installed, 1337
    je uninstall

	; Save adddress interrupt vector function 09h int21h
    mov word ptr OLD9, bx
    mov word ptr OLD9 + 2, es

	; set interrupt vector: input: DS:DX = new address
    mov ax, 2509h
    mov dx, offset NEW9
    int 21h
	
	; show notif
    mov dx, offset inst_msg
    mov ah, 9
    int 21h

    mov dx, offset init
    int 27h

uninstall:
    push es
    push ds

	; return address func 09 int21h to interrupt table 
    mov dx, word ptr es:OLD9
    mov ds, word ptr es:OLD9 + 2
    mov ax, 2509h
    int 21h

    pop ds
    pop es
	
	; free memory
    mov ah, 49h
    int 21h
	
	; show notif
    mov dx, offset uninst_msg
    mov ah, 9h
    int 21h
	
	; return to DOS
    mov ax, 4C00h
    int 21h

    inst_msg   db 'Timer installed!$'
    uninst_msg db 'Time uninstalled!$'

CODE ends
end main
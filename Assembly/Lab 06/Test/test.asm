.286
.model tiny
.code
org 100h
start:  mov ax,3; стираю с экрана
    int 10h
    mov ah,9; вывожу предупреждение
    mov dx,offset string1
    int 21h
a0: mov ah,1;жду нажатия на любую клавишу
    int 16h
    jnz exit
    mov ah,0;организация 5 секундой задержки 
    int 1Ah
    mov bx,dx
    add bx,91 ; в одной секунде 18,2 тика 5сек*18,2=91
a1: int 1Ah
    cmp bx,dx
    jne a1
    mov ah,2;получаю текущее время
    int 1Ah
    mov ah,0
    mov al,ch;час в формате BCD
    ror ax,4
    shr ah,4
    or ax,'00'
    mov word ptr string,ax
    mov ah,0
    mov al,cl;минуты в формате BCD
    ror ax,4
    shr ah,4
    or ax,'00'
    mov word ptr string+3,ax
    mov ah,0
    mov al,dh;секунды в формате BCD
    ror ax,4
    shr ah,4
    or ax,'00'
    mov word ptr string+6,ax
    mov ah,9;вывожу значение системного таймера на экран
    mov dx,offset string
    int 21h
    jmp a0
exit:   retn; выхожу из программы
string db ?,?,':',?,?,':',?,?,0Dh,'$'
string1 db 'Для выхода из программы нажмите Esc',0Dh,0Ah,'$'
end start
.MODEL TINY
.DOSSEG
.DATA
    MSG DB "Hello, World!",  0DH, "12345", '$'
.CODE
.STARTUP
    MOV BX, 1
    MOV AH, 09h
    MOV DX, OFFSET MSG
    ADD BX, 10
    INT 21h
    MOV AH, 4Ch
    INT 21h
END



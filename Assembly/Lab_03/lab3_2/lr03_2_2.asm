SD1 SEGMENT para common 'DATA'
	C1 LABEL byte ; label dat ten cho o nho(ko cap phat)
	;W dw 3444h ; 44='D', 34='4'
	ORG 1h ; chi dan nhung data sau se bat dau owr address
 	C2 LABEL byte
	
SD1 ENDS ; ket thuc seg

CSEG SEGMENT para 'CODE'
	ASSUME CS:CSEG, DS:SD1
main:
	mov ax, SD1
	mov ds, ax
	mov ah, 2 ; int 21h lenh out char
	mov dl, C1
	int 21h
	mov dl, C2
	int 21h
	mov ax, 4c00h ; lenh thoat
	int 21h
CSEG ENDS
END main
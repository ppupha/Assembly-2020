
public stringlen
.686
.MODEL FLAT, C
.STACK
.CODE
	stringlen proc
		push	edi
		push	ebp
		mov		ebp, esp
		add		ebp, 12
		mov		edi, [ebp]
		xor		ecx, ecx
		not		ecx
		xor		al, al
		cld
		repne	scasb
		not		ecx
		lea		eax, [ecx-1]

		over:
			pop		ebp
			pop		edi
			ret

	stringlen endp
END

.686
.MODEL FLAT, C
.STACK
.CODE

	len proc
		push	edi
		push	ecx
		xor		ecx, ecx
		not		ecx
		xor		al, al
		cld
		repne	scasb
		not		ecx
		lea		eax, [ecx-1]

		len_over:
			pop		ecx
			pop		edi

			ret
	len endp

	strcopy proc

		pushf
		push	edi
		push	ebp
		push	esi

		mov		ebp, esp
		add		ebp, 18

		mov		edi, [ebp]
		mov		ecx, [ebp + 4]
		mov		esi, [ebp + 8]
		
		;xac dinh do dai thuc
		mov		edi, [ebp + 8]
		call	len
		mov		ecx, [ebp + 4]
		cmp		eax, ecx;
		jnl		is_enough
		mov		ecx, eax
		is_enough:

		mov esi, [ebp + 8]
		mov edi, [ebp]
		add		eax, esi

		; xem chieu copy
		if1_label:
			cmp		edi, esi
			jl		endif_label	;  if edi < esi		
		if2_label:
			cmp		edi, eax
			jng		reverse_copy ; if ( esi < edi < esi + len)
		endif_label:

		; copy theo chieu tang
		cld		; xoa co nho df = 0
		REP		MOVSB

		mov		al, 0
		STOSB ; = 0
		jmp over

		; copy theo  chieu giam
		reverse_copy:
			std		; dat co nho  ; df = 1
			add		edi, ecx
			mov		al, 0
			STOSB
			add		esi, ecx 
			dec		esi
			REP		MOVSB	
		over:
			pop		esi
			pop		ebp
			pop		edi
			popf
			ret

	strcopy endp
END
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode: DWORD

.data
password BYTE 'Henry9200'
clear BYTE 0

.code
main PROC
	movzx eax, clear
	movzx edx, clear
	mov eax, OFFSET password
	mov ecx, LENGTHOF password
	call cipher
	call decipher
	invoke ExitProcess, dl  
main ENDP

;----------------------------------------
cipher PROC uses ECX EDX ESI
;
; Simple procedure, that ciphers value by
; rotating and xoring bits. 
; It's obviously a symmetric ciphering.
;
; Receive: EAX - value to cipher
; Operates on:	[EAX] - modify dereferenced values (ones that reside at given by EAX memory address)
;				ECX - length of ciphered value, 
;				EDX - store character byte, 
;				ESI - copy value var address
; Returns: EAX - ciphered value
;----------------------------------------
	
	movzx edx, clear
	movzx esi, clear
	mov esi, eax
	shr ecx, 1
	
	ciphering:
		mov dl, [esi]
		ror dl, 1
		xor dl, 11111111b
		mov [esi], dl
		mov dl, 0
		inc esi
	LOOP ciphering

	ret
cipher ENDP

;----------------------------------------
decipher PROC uses ECX EDX ESI
;
; Simple procedure, that deciphers value by
; xoring and rotating bits. 
;
; Receive: EAX - value to decipher
; Operates on:	[EAX] - modify dereferenced values (ones that reside at given by EAX memory address)
;				ECX - length of deciphered value, 
;				EDX - store character byte, 
;				ESI - copy value var address
; Returns: EAX - deciphered value
;----------------------------------------
	
	movzx edx, clear
	movzx esi, clear
	mov esi, eax
	shr ecx, 1
	
	deciphering:
		mov dl, [esi]
		xor dl, 11111111b
		rol dl, 1
		mov [esi], dl
		mov dl, 0
		inc esi
	LOOP deciphering

	ret
decipher ENDP

END

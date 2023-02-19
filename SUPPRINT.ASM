.model tiny
.code 
org 100h

START_INPUT_PARAM 	 equ 0081h
VIDEO_MEMORRY_ADDRES equ 0B800h
MIDDLE_SCREEN	     equ 2000d

Main:
		
	mov SI, START_INPUT_PARAM 

	cmp byte ptr [SI], 0Dh			;no string
	je goToEnd

	push START_INPUT_PARAM + 1

	call PrintToMemory
		
	goToEnd:
		mov AX, 4c00h
		int 21h	


	;The function outputs a string at the specified address.
	;Overwritten registers BP, ES, SI, DX. 
	;No return value
	PrintToMemory PROC	

		push BP				;save BP val
		mov  BP, SP			

		mov SI, [BP+4]

		mov BX, VIDEO_MEMORRY_ADDRES		;video memory address
		mov ES, BX

		mov BX, MIDDLE_SCREEN		;video memory pointer

		xor DX, DX
		next:	
			add DH, [SI]		;definу color symbol
			or  DH, 00001000b	;make bright color
			mov DL, [SI] 		;cur symbol Message  

			mov word ptr ES:[BX], dx 	;set message symbol to video memory
			add BX, 2h
				
		inc SI	 
		cmp byte ptr [SI], 0Dh			;exit condition
		jne next

		pop BP

		ret 2

	PrintToMemory ENDP

end Main


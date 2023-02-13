.model tiny
.code 
org 100h

Main:
		
	mov SI, 0081h 

	cmp byte ptr [SI], 0Dh			;no string
	je goToEnd

	push 0082h

	call PrintToMemory
		
	goToEnd:
		mov AX, 4c00h
		int 21h	


	PrintToMemory PROC

		push BP
		mov  BP, SP

		mov SI, [BP+4]

		mov BX, 0B800h			;video memory adress
		mov ES, BX

		mov BX, 2000d			;video memory pointer

		xor DX, DX
		next:	
			add DH, [SI]		;color symbol
			or  DH, 08h	
			mov DL, [SI] 		;cur symbol Message  

			mov word ptr ES:[BX], dx 	;set message symbol to video memory
			add BX, 2h
				
		inc SI	 
		cmp byte ptr [SI], 0Dh
		jne next

		pop BP

		ret 2

	PrintToMemory ENDP

end Main


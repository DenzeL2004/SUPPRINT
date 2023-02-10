.model tiny
.code 
org 100h

Start:	
		mov BX, 0B800h			;video memory adress
		mov ES, BX

		mov BX, 1980d			;video memory pointer
	
	mov SI, 0081h 

	cmp byte ptr [SI], 0Dh			;no string
	je goToEnd

	mov SI, 0082h

	xor DX, DX
	next:	
		add DH, [SI]		;color symbol
		or  DH, 08h	
		mov DL, [SI] 		;cur symbol Message  

		mov word ptr ES:[BX], dx 	;set message symbol to video memory
		add BX, 2h
			
	add SI, 1h	 
	cmp byte ptr [SI], 0Dh
	jne next
		
	goToEnd:
		mov AX, 4c00h
		int 21h	

end Start


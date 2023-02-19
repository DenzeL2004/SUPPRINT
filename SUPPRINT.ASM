.model tiny
.code 
locals @@

org 100h


START_INPUT_PARAM   equ 0081h
VIDMEM_ADR 			equ 0B800h
MIDDLE_SCREEN	    equ 80d * 2d * 12d + 40d * 2d

NOPE equ nop

;---------------------------------------------------------------------------------------------------
;Exit
;---------------------------------------------------------------------------------------------------
;Entrt: nope
;Exit: N/A
;Destroy: N/A
;---------------------------------------------------------------------------------------------------

Exit	macro code
		NOPE

		mov AX, 4c00h or code
		int 21h		

		NOPE
		endm

;---------------------------------------------------------------------------------------------------
;Set Memory Address
;---------------------------------------------------------------------------------------------------
;Entrt: nope
;Exit: ES
;Destroy: BX
;---------------------------------------------------------------------------------------------------

SET_MEMADRESS	macro
				NOPE

				mov BX, VIDMEM_ADR		;video memory address
				mov ES, BX

				NOPE
				endm
					
Start:
		
	mov SI, START_INPUT_PARAM 

	cmp byte ptr [SI], 0Dh			;no string
	je goToEnd


	SET_MEMADRESS					;specify a memory segment

	
	mov SI, START_INPUT_PARAM + 1h		;address input string
	
	mov BX, MIDDLE_SCREEN 
	sub BL, byte ptr [SI-2]			;video memory pointer

	and BX, 0FFF0h				;address starts with an even bit

	call PrintToMemory
		
	goToEnd:
		Exit 0

	;-------------------------------------------------------------
	;The function outputs a string at the specified address.
	;-------------------------------------------------------------
	;Assumes: ES = VIDMEM_ADR
	;Entry: BX (video memeory pointer), SI (addres input string)
	;Destroy: BX, SI, DX
	;Exit: none
	;-------------------------------------------------------------
	PrintToMemory PROC

		xor DX, DX
		@@next:	
			add DH, [SI]		;definу color symbol
			or  DH, 00001000b	;make bright color
			mov DL, [SI] 		;cur symbol Message  

			mov word ptr ES:[BX], DX 	;set message symbol to video memory
			add BX, 2h
				
		inc SI	 
		cmp byte ptr [SI], 0Dh			;exit condition
		jne @@next

		ret

	PrintToMemory ENDP

end Start


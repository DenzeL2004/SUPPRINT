.model tiny
.code 
org 100h

Start:	
		mov bx, 0B800h			;video memory adress
		mov es, bx
		xor bx, bx
		
	mov cx, 80d * 25d			
	next:	mov word ptr es:[bx], 8421h	;set symbol '!' to vide memory
			add bx, 2h
	loop next
		
		mov ax, 4c00h
		int 21h	

end Start

; Second stage of the boot loader

BITS 16

ORG 9000h
	jmp 	Second_Stage

%include "functions_16.asm"
%include "a20.asm"

;	Start of the second stage of the boot loader
	
Second_Stage:
    mov 	si, second_stage_msg	; Output our greeting message
    call 	Console_WriteLine_16

	call	Enable_A20
	
	push 	dx						; Save the number containing the mechanism used to enable A20
	mov		si, dx					; Display the appropriate message that indicates how the A20 line was enabled
	add		si, dx
	mov		si, [si + a20_message_list]
	call	Console_WriteLine_16
	pop		dx						; Retrieve the number
		
	hlt
	
%include "messages.asm"

	times 3584-($-$$) db 0	
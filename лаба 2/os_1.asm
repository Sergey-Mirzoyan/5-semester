.386P

; Описание структуры дескрипторов сегментов
desct struc		
	limit	dw 0	; Border (0..15 bit)
	base_l	dw 0 	; Base (0..15 bit)
	base_m	db 0 	; Base (1..23 bit)
	attr_1	db 0 	; Attribute byte 1
	attr_2	db 0 	; Boreder (16..19 bit) and attribute 2
	base_h	db 0 	; Base (24..31 bit)
desct ends ;

			
data segment
								; GDT
	gdt_null	desct <0,0,0,0,0,0>			; Selector 0, Zero desc
	gdt_data	desct <data_size-1,0,0,92h>		; Selector 8, Data segment
	gdt_code	desct <code_size-1,,,98h>		; Selector 16, Code segment
	gdt_stack	desct <255,0,0,92h>			; Selector 24, Stack segment
	gdt_screen	desct <4095,8000h,0Bh,92h>		; Selector 32, Video memory
	gdt_size = $-gdt_null					; GDT SIZE
	
	pdescr	df 0						; Commands Pseudo descryptor 
	sym		db 1					; Output symbol
	attr 	db 1Eh						; Symbol's attribute
	mes		db 27,'[31;42m Process working in real mode! ',27,'[0m$'
	data_size=$-gdt_null					; Data segment size
data ends

; Code segment
text segment 'code' use16					; 16-bit segment
	assume CS:text,DS:data
main proc
	xor		EAX, EAX				; Cleaning EAX		
	mov		AX, data				; Input in DS
	mov		DS, AX					; Data segemnt's address				

; Calculate the 32-bit linear address of the data segment 
; and load its data segment descriptor in the GDT global descriptor table	
	shl	EAX, 4						; EAX = linear address base address
	mov 	EBP, EAX					; Save the address
	mov 	BX, offset gdt_data				; BX = descryptor offset
	mov 	[BX].base_l, AX					; Download low part of base
	rol		EAX, 16					; High half in EAX
	mov 	[BX].base_m, AL					; Download middle part of base
	
; Calculate and load into GDT the line address of the code segment
	xor	EAX, EAX					; Clean EAX		
	mov 	AX, CS						; Segment address of code segment
	shl 	EAX, 4						
	mov 	BX, offset gdt_code
	mov 	[BX].base_l, AX
	rol 	EAX, 16
	mov 	[BX].base_m, AL

; Calculate and load into GDT the line address of the stack segment
	xor 	EAX, EAX					; Clean EAX
	mov 	AX, SS						; Segment address of stack segment
	shl 	EAX, 4						
	mov 	BX, offset gdt_stack
	mov 	[BX].base_l, AX
	rol 	EAX, 16
	mov 	[BX].base_m, AL

; Prepare the pdescr pseudo descriptor and load the GDTR register
	mov 	dword ptr pdescr+2, EBP				; GDT base
	mov 	word ptr pdescr, gdt_size-1			; GDT border
	lgdt 	pdescr						; Download GTR

; Prepare to switch to protected mode
	cli							; disable hardware interrupts
	mov 	AL, 80h						; 
	out 	70h, AL						;
	mov 	EAX, CR0					;
	or 	EAX, 1						;
	mov 	CR0, EAX					;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;		   	Protected Mode				;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

	db 	0EAh						; Far jmp code
	dw	offset continue					; Offset
	dw 	16						; Code segment selector
continue:
	mov	AX, 8						; Data segment selector
	mov 	DS, AX						;
	mov	AX, 24						; Stack segment selector
	mov	SS, AX						

	mov	AX, 32						; Video memory segment selector
	mov 	ES, AX						; Es init
	mov 	BX, 800						; First position on screen
	mov 	CX, 640						; Count of output symbols
	mov 	AX, word ptr sym				; Symbol + attribute
	mov	AH,71h						; 

screen: mov ES:[BX], AX						; AX on screen
	add 	BX, 2						;
	inc 	AX						; inc symbol's code
	loop	screen						; Output cycle

	mov 	gdt_data.limit, 0FFFFh				;
	mov 	gdt_code.limit, 0FFFFh				;
	mov 	gdt_stack.limit, 0FFFFh				;
	mov	gdt_screen.limit, 0FFFFh			;
	mov	AX, 8						
	mov 	DS, AX
	mov 	AX, 24
	mov 	SS, AX
	mov 	AX, 32
	mov 	ES, AX
	db	0EAh
	dw	offset go
	dw 	16
go: mov		EAX, CR0
	and		EAX, 0FFFFFFFEh
	mov 	CR0, EAX
	db 		0EAh
	dw 		offset return
	dw 		text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;		   	Real Mode				;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
return: 
	mov 	AX, data
	mov	DS, AX
	mov 	AX, stk
	mov 	SS, AX
	sti							; Allow hardware interrupts

; Working in DOS
	mov	AL, 0
	out 	70h, AL
	mov 	AH, 09h
	mov 	DX, offset mes
	int 	21h
	mov 	AX, 4C00h
	int 	21h
main endp
code_size=$-main
text ends

; Stack segment
stk 	segment stack 'stack'
	db 	256 dup ('^')
stk 	ends
	end main

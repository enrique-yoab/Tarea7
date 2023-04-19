section .data
 msg db 'Ingrese una frase corta: ',0		;primera cadena
 len1 equ $-len1 				;tamaño de la primera cadena
 resultado db 'La cadena invertida es: ',0	;segunda cadena
 len2 equ $-len2 				;tamaño de la segunda cadena

section .bss
 buffer resb 30     ;espacio reservado  donde se guardara la frase
 len resd 1         ;espacio reservado para guardar el tamaño de la frase ingresada

section  .txt
 global _start
_start:
 ;se imprime el mensaje en la terminal para ingresar la frase
 mov eax, 4
 mov ebx, 0
 mov ecx, msg
 mov edx, len1
 int 0x80

 ;se lee el mensaje o el texto ingresado por el usuario
 mov eax, 3
 mov ebx, 0
 mov ecx, buffer
 mov edx, 30
 int 0x80

 call strlen
strlen:
 imp [edi],0
 jz function
 inc eax
 inc edi
 jmp strlen
 
 

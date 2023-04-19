section .data
 msg db 'Ingrese una frase corta: ', 0		;primera cadena
 len1 equ $-msg 				;tamaño de la primera cadena
 resultado db 'La cadena invertida es: ', 0	;segunda cadena
 len2 equ $-resultado 				;tamaño de la segunda cadena

section .bss
 buffer resb 30
 aux resb 30

section .txt
 global _start
_start:
 ;se imprime el mensaje en la terminal para ingresar la frase
 mov eax, 4
 mov ebx, 1
 mov ecx, msg
 mov edx, len1
 int 0x80

 ;se lee el mensaje o el texto ingresado por el usuario
 mov eax, 3
 mov ebx, 0
 mov ecx, buffer
 mov edx, 30
 int 0x80

 mov edi, ecx
 mov esi, aux
 mov ecx, 0
 mov eax, 0
 call strlen
 call invertir
 ;antes de salir se imprime la cadena invertida
 mov eax, 4
 mov ebx, 0
 mov ecx, aux
 mov edx, 30
 int 0x80
 jmp fin

strlen:
 cmp byte [edi + eax],0 ;se compara con un cero ya que al terminar la cadena habra un 0
 jz salida   ;cuando salte aqui es que ya leyo todo la cadena y para luego invertirla
 inc eax     ;incrementa eax ya que contara cuantos caracteres tiene
 jmp strlen  ;se salta a strlen para que se haga un bucle

invertir:
 cmp eax, 0
 jz salida
 mov ecx, [edi + eax]
 dec eax
 mov [esi], ecx
 inc esi
 shr ecx, 1
 jmp invertir

salida:
 ret

fin:
 mov eax, 1
 mov ebx, 0
 int 0x80

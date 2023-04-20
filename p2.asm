section .data
 msg db 'Ingrese una frase en minusculas: ', 0		;primera cadena
 len1 equ $-msg 				;tamaño de la primera cadena
 resultado db 'La cadena en mayusculas es:  '	;segunda cadena
 len2 equ $-resultado 				;tamaño de la segunda cadena
 salto db 0xA                                   ;salto de linea

section .bss
 buffer resb 30

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

 mov esi, ecx
 mov ecx, 0
 mov eax, 0
 call strlen
 dec ebx
 call conversion
 mov edi, ebx

 ;se imprime el mensaje en la terminal para ingresar la frase
 mov eax, 4
 mov ebx, 1
 mov ecx, resultado
 mov edx, len2
 int 0x80

 ;se imprime el mensaje en mayusculas de la frase ingresada por el usuario
 mov eax, 4
 mov ebx, 1
 mov ecx, buffer
 mov edx, edi
 int 0x80

 ;y imprime un salto de linea para que quede alineado
 mov eax, 4
 mov ebx, 1
 mov ecx, salto
 mov edx, 1
 int 0x80
 mov edi, 0

 jmp fin

strlen:
 cmp byte [esi + ebx],0 ;se compara con un cero ya que al terminar la cadena habra un 0
 jz salida   ;cuando salte aqui es que ya leyo todo la cadena y para luego invertirla
 inc ebx     ;incrementa eax ya que contara cuantos caracteres tiene
 jmp strlen  ;se salta a strlen para que se haga un bucle

conversion:
 mov al, byte [esi]
 sub al, 32
 mov byte[esi], al
 inc esi
 inc ecx
 cmp ecx, ebx
 je salida
 jmp conversion

salida:
 ret

fin:
 mov eax, 1
 mov ebx, 0
 int 0x80

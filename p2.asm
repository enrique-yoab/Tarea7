section .data
  msg1 db 'Escribe una frase corta en minusculas: ',0
  len1 equ $-len1
  msg2 db 'La frase en mayusculas es: ',0
  len2 equ $-len2
  
section .bss
  buffer resb 30
  
section .txt
  global _start
  
_start:
  ;se imprime el mensaje en la terminal para que ingrese la frase
  mov eax, 4
  mov ebx, 0
  mov ecx, msg1
  mov edx, len1
  int 0x80
  
  ;se lee el mensaje ingresado por el usuario
  mov eax, 3
  mov ebx, 0
  mov ecx, buffer
  mov edx, 30
  int 0x80
  
  ;convertir a mayusculas 
  mov esi, buffer                 ;esi apunta a inicio del buffer
  mov ecx, 0                      ;ecx encontrará la longitud de la frase
  
loop:
  mov al, byte [esi]
  cmp al, 0                      ; Pasa si ya llegó al fin de la frase
  je done
  cmp al, 'a'                    ; Revisa si son minusculas
  jb not_lowcase
  cmp al, 'z'
  ja not_lowcase
  sub al, 32                      ;las convierte en mayúscula
  mov byte [esi], al
  
not_lowcase:
  inc esi
  inc ecx
  lmp loop
  
done:
  ;se imprime el mensaje 2 en la terminalp
  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, len2
  int 0x80

  ;mostrar la frase convertida en la terminal
  mov eax, 4
  mov ebx, 1
  mov ecx, buffer
  mov edx, ecx                ;igualamos la longitud de la cadena a la dirección de inicio del buffer
  int 0x80
  
  ;finalizar el programa
  mov eax, 1
  xor ebx, ebx
  int 0x80

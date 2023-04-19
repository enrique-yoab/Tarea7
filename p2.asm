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
  mov ecx, msg
  mov edx, len1
  int 0x80
  
  ;se lee el mensaje ingresado por el usuario
  mov eax, 3
  mov ebx, 0
  mov ecx, buffer
  mov edx, 30
  int 0x80
  
  

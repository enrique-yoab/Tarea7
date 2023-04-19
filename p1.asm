section .data
 msg db 'Ingrese una frase corta: ', 0		;primera cadena
 len1 equ $-msg 				;tamaño de la primera cadena
 resultado db 'La cadena invertida es: '	;segunda cadena
 len2 equ $-resultado 				;tamaño de la segunda cadena
 salto db 0xA
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

 mov edi, ecx   ;movemos al registro edi la variable donde se guardo la cadena que ingreso el usuario
 mov esi, aux   ;movemos al registro esi la variable reserbada aux
 mov ecx, 0     ;movemos el valor de 0 al registro ecx
 mov eax, 0     ;movemos el valor de 0 al registro eax (contador para la cadena)
 call strlen    ;se llama la funcion que nos contara la cadena
 dec eax        ;se decrementa una unidad ya que al contar la cadena, tambien cuenta el ENTER ingresado por lo que no se toma como un caracter dado por el usuario
 call invertir  ;se llama la funcion que nos invertira la cadena del usuario

 mov edi, ebx   ;en el registro edi se mantuvo almacenado el tamaño del usuario
 ;se imprime el mensaje 2 para identificar la cadena invertida
 mov eax, 4
 mov ebx, 1
 mov ecx, resultado
 mov edx, len2
 int 0x80

 ;antes de salir se imprime la cadena invertida del usuario y fue guardada en aux
 mov eax, 4
 mov ebx, 1
 mov ecx, aux
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
 cmp byte [edi + eax],0 ;se compara con un cero ya que al terminar la cadena habra un 0
 jz salida   ;cuando salte aqui es que ya leyo todo la cadena y para luego invertirla
 inc eax     ;incrementa eax ya que contara cuantos caracteres tiene
 mov ebx, eax ;movemos el tamano del arreglo al registro ebx y eax
 jmp strlen  ;se salta a strlen para que se haga un bucle

invertir:
 mov ecx, [edi + eax] ;movemos al registro ecx, la ultima letra de la cadena
 mov [esi], ecx       ;movemos a la variable aux, el valor de ecx
 shr ecx, 1          ;dezplazamos un byte a la derecha en el registro ecx
 cmp eax, 0          ;comparamos eax con 0 ya que es el tamaño de la cadena
 jz salida           ;si es igual a 0 es que ya recorrio toda la cadena y imprime la cadena inverida
 inc esi             ;incrementamos esi para movernos al otro lado del caracter
 dec eax             ;decrementamos una unidad eax
 jmp invertir        ;salta a la etiqueta invertir para continuar con el sig caracter

salida:
 ret

fin:
 mov eax, 1
 mov ebx, 0
 int 0x80

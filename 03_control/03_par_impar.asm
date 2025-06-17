.386
.model flat, stdcall
option casemap:none

; Inclusión de la biblioteca estándar de C (msvcrt)
include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  num dd 7                ; Definimos una variable entera llamada "num" con el valor 7
  par db "Es par", 0Ah, 0 ; Cadena de texto para número par (con salto de línea)
  impar db "Es impar", 0Ah, 0 ; Cadena de texto para número impar

.code
start:
  mov eax, num            ; Cargamos el valor de "num" en el registro EAX
  test eax, 1             ; Verificamos si el bit menos significativo está activo (número impar)
                          ; test eax, 1 equivale a: (eax & 1)
  jz es_par               ; Si el resultado fue cero (es par), saltamos a la etiqueta "es_par"

  ; Si llegamos aquí, el número es impar
  push offset impar       ; Preparamos el argumento para printf: dirección del string "Es impar"
  call crt_printf         ; Llamamos a printf para imprimir el mensaje
  jmp fin                 ; Saltamos al final del programa (evitamos imprimir "Es par")

es_par:
  ; Si llegamos aquí, el número es par
  push offset par         ; Preparamos el argumento para printf: dirección del string "Es par"
  call crt_printf         ; Llamamos a printf para imprimir el mensaje

fin:
  call crt_getchar        ; Esperamos que el usuario presione una tecla antes de salir
  ret                     ; Terminamos el programa

end start                 ; Marca el punto de entrada del programa

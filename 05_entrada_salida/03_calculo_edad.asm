.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  nombre db 32 dup(0)
  anioNacimiento dd ?
  anioActual dd 2025
  edad dd ?
  mensajeNombre db "Ingresa tu nombre: ", 0
  mensajeAnio db "Ingresa tu anio de nacimiento: ", 0
  formatoCadena db "%s", 0
  formatoNumero db "%d", 0
  mensajeFinal db "Hola %s, tienes %d anios.", 0Ah, 0

.code
start:
  ; Mostrar mensaje y leer nombre
  push offset mensajeNombre
  call crt_printf
  push offset nombre
  push offset formatoCadena
  call crt_scanf

  ; Mostrar mensaje y leer año
  push offset mensajeAnio
  call crt_printf
  push offset anioNacimiento
  push offset formatoNumero
  call crt_scanf

  ; Calcular edad
  mov eax, anioActual
  sub eax, anioNacimiento
  mov edad, eax

  ; Mostrar resultado
  push edad
  push offset nombre
  push offset mensajeFinal
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit
end start
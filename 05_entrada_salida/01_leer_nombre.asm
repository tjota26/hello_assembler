.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  nombre db 30 dup(0)
  mensaje db "Escriba su nombre:", 0Ah, 0
  formatoLectura db "%s", 0
  saludo db "Hola, %s!", 0Ah, 0

.code
start:

  push offset mensaje
  call crt_printf
  add esp, 8

  push offset nombre
  push offset formatoLectura
  call crt_scanf

  push offset nombre
  push offset saludo
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit
end start
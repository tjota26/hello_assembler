.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  mensaje db "Hola mundo desde consola con MASM32", 0Ah, 0

.code
start:
  push offset mensaje
  call crt_printf
  call crt_getchar
  push 0
  call crt_exit
end start





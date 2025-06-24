.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  resultado db "Resultado: %d", 0Ah, 0

.code
start:
  ; Método 1: usando loop
  xor eax, eax        ; limpiar acumulador
  mov ecx, 100

sum_loop:
  add eax, 5
  loop sum_loop

  ; Mostrar resultado
  push eax
  push offset resultado
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit
end start
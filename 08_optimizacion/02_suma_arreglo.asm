.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  numeros db 5, 10, 15, 20, 25
  total db 0
  mensaje db "Suma total: %d", 0Ah, 0

.code
start:
  xor eax, eax         ; acumulador en cero
  mov ecx, LENGTHOF numeros
  lea esi, numeros

suma_loop:
  add al, [esi]
  inc esi
  loop suma_loop

  mov total, al
  movzx eax, total
  push eax
  push offset mensaje
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit
end start
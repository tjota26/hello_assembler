.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  fmt db "%d", 0
  outfmt db "Resultado: %d", 0Ah, 0
  mensaje1 db "Escriba primer numero:", 0Ah, 0
  mensaje2 db "Escriba segundo numero:", 0Ah, 0
  mensaje3 db "Escriba tercer numero:", 0Ah, 0
  a dd ?
  b dd ?
  tercero dd ?
  resultado dd ?

.code
start:
  push offset mensaje1
  call crt_printf
  add esp, 8

  push offset a
  push offset fmt
  call crt_scanf

  push offset mensaje2
  call crt_printf
  add esp, 8

  push offset b
  push offset fmt
  call crt_scanf

  push offset mensaje3
  call crt_printf
  add esp, 8

  push offset tercero
  push offset fmt
  call crt_scanf

  mov eax, a
  add eax, b
  add eax, tercero
  mov resultado, eax

  push resultado
  push offset outfmt
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit
end start
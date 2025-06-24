.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  valor1 db 11010101b
  valor2 db 00111000b
  mensaje db "Resultado: %02Xh", 0Ah, 0

.code
start:
  mov al, valor1
  and al, valor2     ; operación AND
  ; otras pruebas: or al, valor2 / xor al, valor2 / not al

  movzx eax, al
  push eax
  push offset mensaje
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit
end start
.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  a DWORD 10
  b DWORD 5
  res1 DWORD ?
  res2 DWORD ?
  fmt1 db "Suma: %d", 0Ah, 0
  fmt2 db "Resta: %d", 0Ah, 0
  fmt3 db "Nuestra: %d", 0Ah, 0

.code
start:
  mov eax, a
  add eax, b
  add eax, t
  mov res1, eax

  mov eax, a
  sub eax, b
  mov res2, eax

  push res1
  push offset fmt1
  call crt_printf
  add esp, 8

  push res2
  push offset fmt2
  call crt_printf
  add esp, 8

  call crt_getchar
  push 0
  call crt_exit
end start


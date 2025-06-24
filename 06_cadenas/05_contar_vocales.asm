.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
  buffer db 256 dup(0)
  mensaje db "Introduce una cadena: ", 0
  resultado db "Número de vocales: ", 0
  strNum db 16 dup(0)
  vocales db "aeiouAEIOU", 0

.code
start:
  invoke StdOut, addr mensaje
  invoke StdIn, addr buffer, 256

  xor ecx, ecx        ; contador de vocales
  mov esi, offset buffer

contar:
  mov al, [esi]
  cmp al, 0
  je fin
  push esi
  mov edi, offset vocales
  mov bl, al

buscar:
  mov al, [edi]
  cmp al, 0
  je no_vocal
  cmp al, bl
  je sumar
  inc edi
  jmp buscar

sumar:
  inc ecx

no_vocal:
  pop esi
  inc esi
  jmp contar

fin:
  invoke dwtoa, ecx, addr strNum
  invoke StdOut, addr resultado
  invoke StdOut, addr strNum
  invoke ExitProcess, 0

end start
.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
  buffer db 256 dup(0)
  mensaje db "Escribe una cadena: ", 0
  result db 256 dup(0)

.code
start:
  invoke StdOut, addr mensaje
  invoke StdIn, addr buffer, 256
  invoke lstrlen, addr buffer
  mov ecx, eax
  mov esi, offset buffer
  add esi, ecx
  dec esi
  mov edi, offset result

reversa:
  mov al, [esi]
  mov [edi], al
  dec esi
  inc edi
  loop reversa

  mov byte ptr [edi], 0
  invoke StdOut, addr result
  invoke ExitProcess, 0
end start
.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
  buffer db 256 dup(0)
  mensaje db "Ingresa un texto: ", 0
  largoTexto db "Longitud: ", 0
  strLong db 16 dup(0)

.code
start:
  invoke StdOut, addr mensaje
  invoke StdIn, addr buffer, 256
  invoke lstrlen, addr buffer
  mov ecx, eax
  invoke dwtoa, ecx, addr strLong
  invoke StdOut, addr largoTexto
  invoke StdOut, addr strLong
  invoke ExitProcess, 0
end start
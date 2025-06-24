.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
  buffer db 256 dup(0)
  mensaje db "Introduce una cadena: ", 0

.code
start:
  invoke StdOut, addr mensaje
  invoke StdIn, addr buffer, 256
  invoke StdOut, addr buffer
  invoke ExitProcess, 0
end start
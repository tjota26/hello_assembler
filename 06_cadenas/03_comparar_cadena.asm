.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
  input1 db 256 dup(0)
  input2 db 256 dup(0)
  msg1 db "Cadena 1: ", 0
  msg2 db "Cadena 2: ", 0
  iguales db "Las cadenas son iguales", 0
  distintas db "Las cadenas son distintas", 0

.code
start:
  invoke StdOut, addr msg1
  invoke StdIn, addr input1, 256
  invoke StdOut, addr msg2
  invoke StdIn, addr input2, 256
  invoke lstrcmp, addr input1, addr input2
  .if eax == 0
    invoke StdOut, addr iguales
  .else
    invoke StdOut, addr distintas
  .endif
  invoke ExitProcess, 0
end start
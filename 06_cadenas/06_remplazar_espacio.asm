.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
  buffer db 256 dup(0)
  mensaje db "Ingresa una frase: ", 0
  guion db '-', 0

.code
start:
  invoke StdOut, addr mensaje
  invoke StdIn, addr buffer, 256

  mov esi, offset buffer

reemplazar:

  mov al, [esi]
  cmp al, 0
  je fin
  cmp al, ' '
  jne continuar
  mov byte ptr [esi], '-'

continuar:
  inc esi
  jmp reemplazar

reemplazar_a:

  mov al, [esi]
  cmp al, 0
  je fin
  cmp al, 'a'
  jne continuar
  mov byte ptr [esi], '*'

continuar:
  inc esi
  jmp reemplazar_a

fin:
  invoke StdOut, addr buffer
  invoke ExitProcess, 0

end start
.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  fmtInt     db "%d", 0
  fmtChar    db " %c", 0             ; Espacio evita que quede el \n en el buffer
  fmtOut     db "Resultado: %d", 0Ah, 0
  msg1       db "Ingresa el primer número: ", 0
  msg2       db "Ingresa el segundo número: ", 0
  msg3       db "Operación (+, -, *, /): ", 0

  num1       dd ?
  num2       dd ?
  resultado  dd ?
  operador   db ?

.code
start:
  ; Primer número
  push offset msg1
  call crt_printf
  push offset num1
  push offset fmtInt
  call crt_scanf

  ; Segundo número
  push offset msg2
  call crt_printf
  push offset num2
  push offset fmtInt
  call crt_scanf

  ; Operador
  push offset msg3
  call crt_printf
  push offset operador
  push offset fmtChar
  call crt_scanf

  ; Comparar operador
  movzx eax, operador
  cmp eax, '+'
  je hacer_suma
  cmp eax, '-'
  je hacer_resta
  cmp eax, '*'
  je hacer_mult
  cmp eax, '/'
  je hacer_div

  ; Operador no válido
  jmp fin

hacer_suma:
  mov eax, num1
  add eax, num2
  mov resultado, eax
  jmp mostrar

hacer_resta:
  mov eax, num1
  sub eax, num2
  mov resultado, eax
  jmp mostrar

hacer_mult:
  mov eax, num1
  imul eax, num2
  mov resultado, eax
  jmp mostrar

hacer_div:
  mov eax, num1
  cdq                 ; signo extendido
  idiv num2
  mov resultado, eax
  jmp mostrar

mostrar:
  push resultado
  push offset fmtOut
  call crt_printf

fin:
  call crt_getchar
  push 0
  call crt_exit
end start
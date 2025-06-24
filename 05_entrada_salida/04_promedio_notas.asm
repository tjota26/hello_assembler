.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  nota1 dd ?
  nota2 dd ?
  nota3 dd ?
  nota4 dd ?
  promedio dd ?
  msg1 db "Ingrese la primera nota: ", 0
  msg2 db "Ingrese la segunda nota: ", 0
  msg3 db "Ingrese la tercera nota: ", 0
  msg4 db "Ingrese la cuarta nota: ", 0
  formatoNumero db "%d", 0
  formatoSalida db "El promedio es: %d", 0Ah, 0

.code
start:
  ; Leer nota 1
  push offset msg1
  call crt_printf
  push offset nota1
  push offset formatoNumero
  call crt_scanf

  ; Leer nota 2
  push offset msg2
  call crt_printf
  push offset nota2
  push offset formatoNumero
  call crt_scanf

  ; Leer nota 3
  push offset msg3
  call crt_printf
  push offset nota3
  push offset formatoNumero
  call crt_scanf

  ; Leer nota 4
  push offset msg4
  call crt_printf
  push offset nota4
  push offset formatoNumero
  call crt_scanf

  ; Calcular promedio
  mov eax, nota1
  add eax, nota2
  add eax, nota3
  add eax, nota4
  mov edx, 0
  mov ecx, 3
  div ecx
  mov promedio, eax

  ; Mostrar resultado
  push promedio
  push offset formatoSalida
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit
end start
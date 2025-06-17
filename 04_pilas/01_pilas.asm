.386
.model flat, stdcall
option casemap:none

; Se incluye la biblioteca estándar de C para usar printf y getchar
include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

; Se incluye ExitProcess desde kernel32 para salir del programa
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

.data
  a dd 1                      ; Definimos variable 'a' con valor 1
  b dd 2                      ; Definimos variable 'b' con valor 2
  c_val dd 3                      ; Definimos variable 'c' con valor 3
  r1 dd ?                     ; Variable para guardar resultado 1 (POP)
  r2 dd ?                     ; Variable para guardar resultado 2
  r3 dd ?                     ; Variable para guardar resultado 3

  msg_push db "PUSH %d", 0Ah, 0 ; Cadena para mostrar valores al hacer PUSH
  msg_pop  db "POP -> %d", 0Ah, 0 ; Cadena para mostrar valores al hacer POP

.code
start:
  ; Empujamos los valores a la pila (el último quedará arriba)
  push a                     ; Se inserta 'a' (1)
  push b                     ; Se inserta 'b' (2)
  push c_val                    ; Se inserta 'c' (3)

  ; Imprimimos en consola los valores empujados (no afectan la pila real)
  push a
  push offset msg_push
  call crt_printf
  add esp, 8                 ; Limpiamos los parámetros de printf

  push b
  push offset msg_push
  call crt_printf
  add esp, 8

  push c_val
  push offset msg_push
  call crt_printf
  add esp, 8

  ; Ahora empezamos a retirar con POP (orden inverso)
  pop eax                    ; Retira el último valor insertado (c = 3)
  mov r3, eax                ; Lo guarda en r3
  push eax
  push offset msg_pop
  call crt_printf
  add esp, 8

  pop eax                    ; Retira siguiente valor (b = 2)
  mov r2, eax
  push eax
  push offset msg_pop
  call crt_printf
  add esp, 8

  pop eax                    ; Retira el primer valor insertado (a = 1)
  mov r1, eax
  push eax
  push offset msg_pop
  call crt_printf
  add esp, 8

  ; Esperamos una tecla antes de cerrar la consola
  call crt_getchar
  invoke ExitProcess, 0      ; Terminamos el programa
end start
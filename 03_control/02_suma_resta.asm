.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  a dd 15       ; Cambiar estos valores para probar
  b dd 16
  msgSum db "Suma: %d", 0Ah, 0
  msgRes db "Resta: %d", 0Ah, 0

.code
start:
  mov eax, a    ; Cargar 'a' en EAX
  cmp eax, b    ; Comparar 'a' y 'b'
  jg doResta    ; Si a > b, restar (a - b)
  jl doSuma     ; Si a < b, sumar (a + b)
  ; Si a es mayor b, se ejecuta doSuma (opcional: cambia a doResta si prefieres)

doSuma:
  add eax, b    ; a + b
  push eax
  push offset msgSum
  call crt_printf
  add esp, 8    ; Limpiar pila
  jmp fin

doResta:
  sub eax, b    ; a - b
  push eax
  push offset msgRes
  call crt_printf
  add esp, 8

fin:
  call crt_getchar  ; Esperar tecla
  ret
end start


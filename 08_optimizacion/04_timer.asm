.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  mensaje db "Iniciando espera...", 0Ah, 0
  fin db "Esperando finalizada.", 0Ah, 0

.code
start:
  push offset mensaje
  call crt_printf

  mov ecx, 500000000   ; Número de ciclos (ajustable según velocidad del procesador)
retardo:
  nop                  ; No Operation: instrucción vacía
  loop retardo         ; Disminuye ECX y repite mientras no sea cero

  push offset fin
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit
end start
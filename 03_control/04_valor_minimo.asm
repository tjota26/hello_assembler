.386
.model flat, stdcall
option casemap:none

; Incluye la biblioteca estandar de C para funciones como printf
include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  x dd 12                ; Primer numero (entero de 32 bits)
  y dd 8                 ; Segundo numero
  msg db "Minimo: %d", 0Ah, 0 ; Mensaje con formato para mostrar un entero (linea nueva al final)

.code
start:
  mov eax, x             ; Cargar el valor de x en el registro eax
  cmp eax, y             ; Comparar eax con y (eax - y)
  jl ya_menor            ; Si eax < y, saltar a ya_menor (x ya es menor)

  ; Si no salto, entonces y es menor que x
  mov eax, y             ; Cargar y en eax

ya_menor:
  push eax               ; Parametro: valor minimo (%d)
  push offset msg        ; Parametro: direccion del mensaje de formato
  call crt_printf        ; Llamada a printf para mostrar el resultado
  add esp, 8             ; Limpiar los dos parametros de la pila (2 * 4 bytes)

  call crt_getchar       ; Esperar que el usuario presione una tecla
  ret                    ; Finalizar el programa

end start                ; Punto de entrada del programa



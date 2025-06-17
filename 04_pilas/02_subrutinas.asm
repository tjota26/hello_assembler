.386                        ; Habilita instrucciones del 80386 (32 bits)
.model flat, stdcall        ; Modelo de memoria plana y convención stdcall
option casemap:none         ; Distingue mayúsculas/minúsculas en etiquetas

include \masm32\include\msvcrt.inc    ; Incluye definiciones de funciones de C (como printf)
includelib \masm32\lib\msvcrt.lib     ; Enlaza la biblioteca de C (msvcrt.dll)

.data
  mensaje db "Hola desde subrutina", 0Ah, 0  ; Cadena a imprimir, con salto de línea (\n) y terminador nulo (\0)

.code
start:                      ; Punto de entrada del programa
  call imprimirMensaje      ; Llama a la subrutina imprimirMensaje
  call crt_getchar          ; Espera que el usuario presione una tecla (para pausar)
  push 0                    ; Empuja 0 (código de salida) a la pila
  call crt_exit             ; Termina el programa con código 0 (éxito)

imprimirMensaje PROC        ; Inicia la definición de la subrutina
  push offset mensaje       ; Empuja la dirección de 'mensaje' a la pila (argumento para printf)
  call crt_printf           ; Llama a printf para imprimir la cadena
  ret                       ; Retorna al punto de llamada (start)
imprimirMensaje ENDP        ; Fin de la subrutina

end start                   ; Marca el fin del programa y especifica la etiqueta de inicio



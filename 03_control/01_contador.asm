.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
    mensaje db "Numero: %d", 0Ah, 0  ; (Asegurate de guardar en ANSI o cambiar "u" por "u")

.code
start:
    mov ecx, 10      ; Contador de iteraciones (10 veces)
    mov ebx, 30      ; Numero inicial (1)

loop_start:
    push ecx         ; Guardamos ECX porque printf lo modifica

    ; Llamada a printf("Numero: %d\n", ebx)
    push ebx         ; Valor a imprimir (%d)
    push offset mensaje ; Formato de cadena
    call crt_printf
    add esp, 8       ; Limpiamos la pila (2 pushes)

    pop ecx          ; Recuperamos ECX
    inc ebx          ; Incrementamos el numero (EBX)
    loop loop_start  ; ECX--, salta si ECX != 0

    ; Terminar el programa correctamente (sin esperar tecla)
    push 0           ; Código de salida (0 = éxito)
    call crt_exit    ; Llama a exit(0)
    ; ret            ; (No necesario, crt_exit ya termina el proceso)
end start



.386                        ; Instrucciones para 32 bits
.model flat, stdcall        ; Modelo de memoria plano
option casemap:none         ; Distingue mayúsculas/minúsculas

; --- Incluir librerías ---
include \masm32\include\msvcrt.inc    ; Para printf, scanf, getchar
includelib \masm32\lib\msvcrt.lib     ; Biblioteca de C

.data
    ; --- Mensajes y formatos ---
    msg_ingreso db "Ingrese un numero para calcular su factorial: ", 0  ; Mensaje para el usuario
    msg_resultado db "El factorial de %d es: %d", 0Ah, 0               ; Formato del resultado
    formato_scan db "%d", 0                                            ; Formato para scanf
    
    ; --- Variables ---
    numero dd ?        ; Almacenará el número ingresado
    resultado dd ?     ; Almacenará el resultado del factorial

.code
start:
    ; === Pedir número al usuario ===
    push offset msg_ingreso    ; Dirección del mensaje
    call crt_printf            ; Muestra "Ingrese un numero..."
    add esp, 4                 ; Limpia el parámetro de la pila
    
    ; --- Leer número con scanf ---
    push offset numero         ; Dirección de 'numero' (donde se guardará)
    push offset formato_scan   ; Formato "%d"
    call crt_scanf             ; scanf("%d", &numero)
    add esp, 8                 ; Limpia los 2 parámetros de scanf
    
    ; === Calcular factorial ===
    push [numero]              ; Pasamos el VALOR de 'numero' (no la dirección)
    call factorial             ; Llama a la función recursiva
    add esp, 4                 ; Limpia el parámetro
    mov [resultado], eax       ; Guarda el resultado
    
    ; === Mostrar resultado ===
    push [resultado]           ; Resultado del factorial
    push [numero]              ; Número original
    push offset msg_resultado  ; Formato "El factorial de %d es: %d\n"
    call crt_printf            ; printf(msg_resultado, numero, resultado)
    add esp, 12                ; Limpia 3 parámetros (4 bytes cada uno)
    
    ; === Esperar tecla y salir ===
    call crt_getchar           ; Pausa antes de cerrar
    push 0                     ; Código de salida (0 = éxito)
    call crt_exit              ; Termina el programa

; === Función factorial recursiva ===
factorial PROC
    ; --- Prólogo: guardar marco de pila ---
    push ebp                   ; Guarda el valor actual de EBP
    mov ebp, esp               ; Establece nuevo marco de pila
    
    ; --- Cargar parámetro (n) ---
    mov eax, [ebp+8]           ; Obtiene el valor de n (primer parámetro)
    
    ; --- Caso base: n <= 1 ---
    cmp eax, 1                 ; Compara n con 1
    jbe fin_factorial          ; Si n <= 1, salta al final (retorna 1)
    
    ; --- Caso recursivo: n * factorial(n-1) ---
    dec eax                    ; n-1
    push eax                   ; Pasamos n-1 como parámetro
    call factorial             ; factorial(n-1)
    ; --- Aquí EAX contiene factorial(n-1) ---
    mov ebx, [ebp+8]           ; Obtiene n original
    mul ebx                    ; EAX = EAX * EBX (factorial(n-1) * n)
    
fin_factorial:
    ; --- Epílogo: restaurar marco de pila ---
    pop ebp                    ; Restaura EBP
    ret 4                      ; Retorna y limpia 4 bytes del parámetro
factorial ENDP

end start





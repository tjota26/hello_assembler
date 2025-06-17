.386
.model flat, stdcall
option casemap:none

; --- Bibliotecas ---
include \masm32\include\msvcrt.inc    ; Para printf, scanf, getchar
includelib \masm32\lib\msvcrt.lib     ; Biblioteca estándar de C

; --- Sección de datos ---
.data
    ; Mensajes para el usuario
    msg_num1   db "Ingrese el primer numero: ", 0
    msg_num2   db "Ingrese el segundo numero: ", 0
    msg_result db "La suma es: %d", 0Ah, 0  ; %d para el número, 0Ah = \n
    
    ; Variables para números
    num1       dd ?
    num2       dd ?
    resultado  dd ?
    
    ; Formato para scanf
    formato_scan db "%d", 0           ; %d para leer enteros

; --- Sección de código ---
.code
start:
    ; --- Pedir primer número ---
    push offset msg_num1    ; Mensaje "Ingrese el primer numero: "
    call crt_printf         ; Muestra el mensaje
    add esp, 4              ; Limpia el argumento de la pila
    
    push offset num1        ; Dirección de num1 (donde se guardará el valor)
    push offset formato_scan ; Formato "%d"
    call crt_scanf          ; Llama a scanf
    add esp, 8              ; Limpia los 2 argumentos de la pila

    ; --- Pedir segundo número ---
    push offset msg_num2    ; Mensaje "Ingrese el segundo numero: "
    call crt_printf
    add esp, 4
    
    push offset num2        ; Dirección de num2
    push offset formato_scan
    call crt_scanf
    add esp, 8

    ; --- Llamar a la subrutina sumar ---
    call sumar              ; Calcula num1 + num2, guarda en 'resultado'

    ; --- Mostrar resultado ---
    push [resultado]        ; Valor a imprimir
    push offset msg_result  ; "La suma es: %d\n"
    call crt_printf
    add esp, 8

    ; --- Esperar tecla y salir ---
    call crt_getchar        ; Pausa antes de cerrar
    push 0
    call crt_exit           ; Termina el programa

; --- Subrutina que suma num1 + num2 ---
sumar PROC
    mov eax, [num1]         ; Carga num1 en EAX
    add eax, [num2]         ; Suma num2 a EAX
    mov [resultado], eax    ; Guarda el resultado
    ret                     ; Retorna al 'call sumar'
sumar ENDP

end start






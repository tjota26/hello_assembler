.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\masm32.lib

.data
    ; Mensajes para el usuario
    msg_titulo      db 'Calculadora de Area de Rectangulo', 13, 10, 0
    msg_base        db 'Ingrese la base del rectangulo: ', 0
    msg_altura      db 'Ingrese la altura del rectangulo: ', 0
    msg_resultado   db 13, 10, 'El area del rectangulo es: ', 0
    msg_continuar   db 13, 10, 13, 10, 'Presione Enter para salir...', 0
    newline        db 13, 10, 0  ; Definición de newline agregada
    
    ; Variables numéricas
    base        dd 0
    altura      dd 0
    area        dd 0
    buffer      db 16 dup(0)

.code
start:
    ; Mostrar título
    invoke StdOut, addr msg_titulo
    
    ; Solicitar base
    invoke StdOut, addr msg_base
    invoke StdIn, addr buffer, 16
    invoke atodw, addr buffer
    mov base, eax
    
    ; Solicitar altura
    invoke StdOut, addr msg_altura
    invoke StdIn, addr buffer, 16
    invoke atodw, addr buffer
    mov altura, eax
    
    ; Calcular área (base * altura)
    mov eax, base
    mul altura
    mov area, eax
    
    ; Mostrar resultado
    invoke StdOut, addr msg_resultado
    invoke dwtoa, area, addr buffer
    invoke StdOut, addr buffer
    invoke StdOut, addr newline
    
    ; Esperar entrada para salir
    invoke StdOut, addr msg_continuar
    invoke StdIn, addr buffer, 16
    
    ; Salir del programa
    invoke ExitProcess, 0

end start
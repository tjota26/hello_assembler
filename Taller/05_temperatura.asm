.386
option casemap:none

include \masm32\include\masm32rt.inc

.data
    msg_in db "Ingrese la temperatura en grados Celsius: ",0
    msg_out db "Equivalente en Fahrenheit: ",0
    input_buf db 16 dup(0)

.code
start:
    ; Mostrar mensaje para pedir temperatura
    invoke StdOut, addr msg_in

    ; Leer entrada del usuario (como cadena)
    invoke StdIn, addr input_buf, 16

    ; Convertir cadena a entero
    invoke atodw, addr input_buf
    mov esi, eax              ; Guardar Celsius en esi

    ; Calcular Fahrenheit: (C * 9 / 5) + 32
    mov eax, esi             ; eax = Celsius
    imul eax, 9              ; eax = Celsius * 9
    cdq                      ; extender eax a edx:eax para división
    mov ebx, 5
    idiv ebx                 ; eax = (C * 9) / 5, resto en edx
    add eax, 32              ; eax = resultado + 32

    ; Mostrar resultado texto
    invoke StdOut, addr msg_out

    ; Convertir resultado a cadena
    invoke dwtoa, eax, addr input_buf

    ; Mostrar resultado
    invoke StdOut, addr input_buf

    ; Salto de línea
    invoke StdOut, chr$(13,10)

    invoke ExitProcess, 0
end start

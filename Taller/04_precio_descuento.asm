.386
option casemap:none

include \masm32\include\masm32rt.inc

.data
    buffer         db 16 dup(0)
    msg_precio     db "Precio original: $", 0
    msg_descuento  db "Descuento aplicado: $", 0
    msg_final      db "Precio final: $", 0
    input_precio   db "Precio: ", 0
    input_dcto     db "Descuento (%): ", 0
    salto          db 13, 10, 0

.code

start:
    ; Leer precio
    invoke StdOut, addr input_precio
    invoke StdIn, addr buffer, sizeof buffer
    invoke atodw, addr buffer
    mov ebx, eax        ; precio original (guardado en EBX)
    mov edi, eax        ; también guardar para mostrar luego

    ; Leer descuento
    invoke StdOut, addr input_dcto
    invoke StdIn, addr buffer, sizeof buffer
    invoke atodw, addr buffer
    mov ecx, eax        ; descuento %

    ; Calcular descuento
    mov eax, ebx        ; eax = precio
    mul ecx             ; eax = precio * descuento
    xor edx, edx
    mov ecx, 100
    div ecx             ; eax = valor del descuento
    mov esi, eax        ; guardar descuento en ESI
    sub ebx, eax        ; ebx = precio final

    ; Mostrar precio original
    invoke StdOut, addr salto
    invoke StdOut, addr msg_precio
    invoke dwtoa, edi, addr buffer
    invoke StdOut, addr buffer
    invoke StdOut, addr salto

    ; Mostrar descuento aplicado
    invoke StdOut, addr msg_descuento
    invoke dwtoa, esi, addr buffer
    invoke StdOut, addr buffer
    invoke StdOut, addr salto

    ; Mostrar precio final
    invoke StdOut, addr msg_final
    invoke dwtoa, ebx, addr buffer
    invoke StdOut, addr buffer
    invoke StdOut, addr salto

    invoke ExitProcess, 0
end start




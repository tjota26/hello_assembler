.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
    msgHoras db "Ingrese el numero de horas trabajadas: ", 0
    msgPago  db "Ingrese el valor del pago por hora: ", 0
    msgTotal db 13,10,"El salario total es: ", 0

    buffer1 db 10 dup(0)
    buffer2 db 10 dup(0)

    horas    dd ?
    pagoHora dd ?
    salario  dd ?

.code
start:
    ; Solicitar horas trabajadas
    invoke StdOut, addr msgHoras
    invoke StdIn, addr buffer1, 10
    invoke atodw, addr buffer1
    mov horas, eax

    ; Solicitar pago por hora
    invoke StdOut, addr msgPago
    invoke StdIn, addr buffer2, 10
    invoke atodw, addr buffer2
    mov pagoHora, eax

    ; Calcular salario: horas * pagoHora
    mov eax, horas
    mul pagoHora
    mov salario, eax

    ; Mostrar resultado
    invoke StdOut, addr msgTotal
    invoke dwtoa, salario, addr buffer1
    invoke StdOut, addr buffer1

    invoke ExitProcess, 0
end start
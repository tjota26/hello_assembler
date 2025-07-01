.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
    msg1 db "Ingrese sueldo basico mensual: ", 0
    msg2 db "Ingrese total de primas o bonificaciones: ", 0
    msg3 db "Ingrese total de deducciones: ", 0
    res1 db 13,10,"Sueldo Basico: ", 0
    res2 db 13,10,"Primas: ", 0
    res3 db 13,10,"Deducciones: ", 0
    res4 db 13,10,"Sueldo Neto: ", 0

    buffer1 db 10 dup(0)
    buffer2 db 10 dup(0)
    buffer3 db 10 dup(0)

    sueldoBasic dd ?
    primas      dd ?
    deducciones dd ?
    sueldoNeto  dd ?

.code
start:
    ; Solicitar sueldo básico
    invoke StdOut, addr msg1
    invoke StdIn, addr buffer1, 10
    invoke atodw, addr buffer1
    mov sueldoBasic, eax

    ; Solicitar primas
    invoke StdOut, addr msg2
    invoke StdIn, addr buffer2, 10
    invoke atodw, addr buffer2
    mov primas, eax

    ; Solicitar deducciones
    invoke StdOut, addr msg3
    invoke StdIn, addr buffer3, 10
    invoke atodw, addr buffer3
    mov deducciones, eax

    ; Calcular sueldo neto: Sueldo + Primas - Deducciones
    mov eax, sueldoBasic
    add eax, primas
    sub eax, deducciones
    mov sueldoNeto, eax

    ; Mostrar resultados
    invoke StdOut, addr res1
    invoke dwtoa, sueldoBasic, addr buffer1
    invoke StdOut, addr buffer1

    invoke StdOut, addr res2
    invoke dwtoa, primas, addr buffer2
    invoke StdOut, addr buffer2

    invoke StdOut, addr res3
    invoke dwtoa, deducciones, addr buffer3
    invoke StdOut, addr buffer3

    invoke StdOut, addr res4
    invoke dwtoa, sueldoNeto, addr buffer1
    invoke StdOut, addr buffer1

    invoke ExitProcess, 0
end start
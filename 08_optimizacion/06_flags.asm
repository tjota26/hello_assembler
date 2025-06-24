.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
    valor1      db 5
    valor2      db 6
    resultado   db ?
    
    msg_op      db "Operación: %d - %d = %d", 0Ah, 0
    msg_zf      db "Resultado fue cero (ZF=1).", 0Ah, 0
    msg_nozf    db "Resultado NO fue cero (ZF=0).", 0Ah, 0
    msg_cf      db "Se generó acarreo (CF=1).", 0Ah, 0
    msg_nocf    db "No hubo acarreo (CF=0).", 0Ah, 0

.code
start:
    ; Preparar valores
    mov al, valor1
    mov bl, valor2
    sub al, bl      ; al = valor1 - valor2
    mov resultado, al

    ; Imprimir operación: valor1 - valor2 = resultado
    movzx eax, resultado
    push eax
    movzx eax, valor2
    push eax
    movzx eax, valor1
    push eax
    push offset msg_op
    call crt_printf

    ; Verificar Zero Flag
    cmp resultado, 0
    jne not_zero
    push offset msg_zf
    call crt_printf
    jmp verificar_cf

not_zero:
    push offset msg_nozf
    call crt_printf

verificar_cf:
    ; Verificar Carry Flag manualmente con SUB: CF=1 si valor1 < valor2
    mov al, valor1
    sub al, valor2
    jc hay_carry

    push offset msg_nocf
    call crt_printf
    jmp terminar

hay_carry:
    push offset msg_cf
    call crt_printf

terminar:
    call crt_getchar
    push 0
    call crt_exit
end start

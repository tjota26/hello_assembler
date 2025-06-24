.386
.model flat, stdcall
option casemap:none

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

.data
  estado db 00001010b
  formato db "Estado binario: %s", 0Ah, 0
  bufferBinario db 9 dup(0) ; 8 bits + null
  saltoLinea db 0Ah, 0

.code
start:

  ; Primera conversión
  movzx eax, estado
  lea edi, bufferBinario
  mov ecx, 8

build_bin1:
  mov ebx, eax
  shl ebx, 24
  shr ebx, 31        ; Aislamos el bit más alto
  add bl, '0'
  mov [edi], bl
  inc edi
  shl eax, 1
  loop build_bin1
  mov byte ptr [edi], 0

  push offset bufferBinario
  push offset formato
  call crt_printf

  ; Invertir estado
  not estado

  ; Segunda conversión
  movzx eax, estado
  lea edi, bufferBinario
  mov ecx, 8

build_bin2:
  mov ebx, eax
  shl ebx, 24
  shr ebx, 31
  add bl, '0'
  mov [edi], bl
  inc edi
  shl eax, 1
  loop build_bin2
  mov byte ptr [edi], 0

  push offset bufferBinario
  push offset formato
  call crt_printf

  call crt_getchar
  push 0
  call crt_exit

end start

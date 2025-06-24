include \masm32\include\masm32rt.inc

.data
  mensajeTexto db "Ingrese el texto a guardar: ", 0
  confirmacion db "Texto guardado correctamente en archivo automático.", 0Ah, 0
  errorMsg db "Error: no se pudo crear el archivo.", 0Ah, 0

  bufferTexto db 1024 dup(0)
  nombreFinal db "log_", 32 dup(0)
  extension db ".txt", 0
  timeBuffer db 32 dup(0)
  formato db "%lu", 0
  handle DWORD ?
  bytesEscritos dd ?

.code
start:
  ; Mostrar mensaje
  invoke StdOut, addr mensajeTexto
  invoke StdIn, addr bufferTexto, sizeof bufferTexto

  ; Obtener timestamp como string
  invoke GetTickCount
  push eax
  push offset formato
  push offset timeBuffer
  call wsprintf

  ; Concatenar nombreFinal = "log_" + timeBuffer + ".txt"
  invoke lstrcat, addr nombreFinal, addr timeBuffer
  invoke lstrcat, addr nombreFinal, addr extension

  ; Crear archivo
  invoke CreateFile, addr nombreFinal, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
  mov handle, eax
  cmp eax, INVALID_HANDLE_VALUE
  je error

  ; Escribir contenido
  invoke lstrlen, addr bufferTexto
  push eax
  invoke WriteFile, handle, addr bufferTexto, eax, addr bytesEscritos, NULL

  ; Cerrar archivo
  invoke CloseHandle, handle

  ; Confirmación
  invoke StdOut, addr confirmacion
  jmp salir

error:
  invoke StdOut, addr errorMsg

salir:
  invoke ExitProcess, 0
end start

include \masm32\include\masm32rt.inc

.data
  mensajeNombre db "Ingrese el nombre del archivo: ", 0
  mensajeContenido db "Ingrese el contenido del archivo: ", 0
  confirmacion db "Archivo creado exitosamente.", 0Ah, 0
  errorMsg db "Error al crear el archivo.", 0Ah, 0
  bufferNombre db 256 dup(0)
  bufferTexto  db 1024 dup(0)
  handle DWORD ?
  bytesEscritos dd ?

.code
start:
  ; Solicitar nombre del archivo
  invoke StdOut, addr mensajeNombre
  invoke StdIn, addr bufferNombre, sizeof bufferNombre
  call LimpiarSaltoNombre

  ; Solicitar contenido del archivo
  invoke StdOut, addr mensajeContenido
  invoke StdIn, addr bufferTexto, sizeof bufferTexto

  ; Crear archivo
  invoke CreateFile, addr bufferNombre, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
  mov handle, eax
  cmp eax, INVALID_HANDLE_VALUE
  je mostrarError

  ; Escribir contenido
  invoke lstrlen, addr bufferTexto
  invoke WriteFile, handle, addr bufferTexto, eax, addr bytesEscritos, NULL

  ; Cerrar archivo
  invoke CloseHandle, handle

  ; Mostrar confirmación
  invoke StdOut, addr confirmacion
  jmp salir

mostrarError:
  invoke StdOut, addr errorMsg

salir:
  invoke ExitProcess, 0

;-------------------------------------
; Subrutina: eliminar salto de línea del nombre
;-------------------------------------
LimpiarSaltoNombre:
  mov esi, offset bufferNombre
buscarSalto:
  mov al, [esi]
  cmp al, 0
  je finLimpieza
  cmp al, 13
  je limpiar
  cmp al, 10
  je limpiar
  inc esi
  jmp buscarSalto

limpiar:
  mov byte ptr [esi], 0
  ret

finLimpieza:
  ret
end start

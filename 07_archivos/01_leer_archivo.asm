include \masm32\include\masm32rt.inc

.data
  nombreArchivo db "test.txt", 0
  buffer db 2048 dup(0)
  bytesLeidos dd ?

.code
start:
  ; Abrir archivo en modo lectura
  invoke CreateFile, addr nombreArchivo, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
  mov ebx, eax
  cmp ebx, INVALID_HANDLE_VALUE
  je errorArchivo

  ; Leer contenido
  invoke ReadFile, ebx, addr buffer, 2048, addr bytesLeidos, NULL

  ; Mostrar por consola
  invoke StdOut, addr buffer

  ; Cerrar archivo
  invoke CloseHandle, ebx

  ; Salida normal
  invoke ExitProcess, 0

errorArchivo:
  invoke StdOut, chr$("No se pudo abrir el archivo.")
  invoke ExitProcess, 1
end start

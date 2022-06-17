
.ifndef datos_s
.equ datos_s, 0

.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


.data
	delay: .dword 0xffffff

//COLORES
//general:
negro: .word 0x0
//fondo:
fondoCelestePastel: .word 0xabe1e1

//globos:
globoNaranja: .word 0xf97331
globoRojo: .word 0xef3838
globoVioleta: .word 0xaa38ef
globoRosa: .word 0xef38b2
globoAzul: .word 0x3854ef
globoAmarillo: .word 0xefd938
reflejo: .word 0xe0edde

//lampara:
gris_lampara: .word 0xb8b8b8
fondoComienzo: .word 0xeeffff
restaComienzo: .word 0x020100

fondoCeleste: .word 0x8888ff
restaCeleste: .word 0x010100

fondoAzul: .word 0x4466ff
restaAzul: .word 0x010101

fondoAzulOscuro: .word 0x022255
restaAzulOscuro: .word 0x000102

fondoUltimo: .word 0x010100

.endif

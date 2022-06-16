
.ifndef datos_s
.equ datos_s, 0

.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


.data
	delay: .dword 0xffffff

//COLORES
//fondo:
fondoCelestePastel: .word 0x96ede8

//globos:
globoNaranja: .word 0xf97331
globoRojo: .word 0xef3838
globoVioleta: .word 0xaa38ef
globoRosa: .word 0xef38b2
globoAzul: .word 0x3854ef
globoAmarillo: .word 0xefd938
reflejo: .word 0xe0edde


.endif

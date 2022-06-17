
.include "dibujos.s"
.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	ldr w10, fondoCelestePastel
	bl fondo

	bl pintar_pxar
	mov x5,200
	mov x6,170
	bl pintar_i
	
	
	mov x1, 300
	mov x2, 300
	mov x3, 340
	mov x4, 350
	mov x5, 325
	mov x6, 390
	mov x7, 5
	bl pintar_lampara
InfLoop: 
	b InfLoop


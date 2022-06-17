
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
	
	
	mov x1, 190
	mov x2, 160
	mov x3, 230
	mov x4, 210
	mov x5, 215
	mov x6, 250
	mov x7, 5
	bl pintar_lampara
InfLoop: 
	b InfLoop


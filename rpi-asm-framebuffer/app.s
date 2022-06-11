
.include "dibujos.s"
.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	ldr w10, fondoCelestePastel
	bl fondo

	mov x5,90
	mov x6,170
	bl pintar_p

	mov x5,200
	mov x6,170
	bl pintar_i
	
	mov x1, 290
	mov x2, 170
	bl pintar_x

	mov x1, 400
	mov x2, 170
	bl pintar_a

	mov x5, 510
	mov x6, 170
	bl pintar_r
	
InfLoop: 
	b InfLoop


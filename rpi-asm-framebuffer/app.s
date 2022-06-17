.include "dibujos.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------	
	
	bl ultra_animation
	
InfLoop: 
	b InfLoop

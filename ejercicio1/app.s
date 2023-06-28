.include "dibujos.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------	
	
	
	ldr x10, fondoImagen
	bl fondo
	
	bl conjunto_nubes
	
	bl globos
	
	bl casa

	bl pasto

	
InfLoop: 
	b InfLoop

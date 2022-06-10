
.include "dibujos.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	//dibujo fondo---------------------------
	ldr w18, globoAmarillo
	
	//dibujar globos-----------
	mov x1, 200  //cord x1
	mov x2, 150	//cord y1
	mov x3, 300	//cord x2
	mov x4, 180	//cord y2
	bl pintar_linea
	
	
InfLoop: 
	b InfLoop


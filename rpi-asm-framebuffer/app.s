
.include "funciones.s"
.include "datos.s"


.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	//dibujo fondo---------------------------
	movz x10, 0x96, lsl 16
	movk x10, 0xdaff, lsl 00
	bl fondo
	
	//dibujar un circulo-----------
	movz x10, 0x10, lsl 16
	movk x10, 0x2323, lsl 00
	mov x16, 70
	mov x3, 70
	mov x4, 30
	mov x7, 30
	bl circulo


InfLoop: 
	b InfLoop


.include "funciones.s"
	
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.globl main


main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	
	//dibujo fondo---------------------------
	movz x10, 0x96, lsl 16
	movk x10, 0xdaff, lsl 00
	bl fondo
	
	//dibujar un rectangulo----------------------
	movz x10, 0x81, lsl 16
	movk x10, 0x3302, lsl 00
	mov x1, 0xf0	// cordenada x = 240
	mov x2, 0x64	// coordenada y = 100
	mov x3, 0x96	// largo del rectangulo L = 150
	mov x4, 0x4b	// ancho del rectangulo A = 75
	bl rectangulo





	
	
	
	
	
	
	

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop: 
	b InfLoop
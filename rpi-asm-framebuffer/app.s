
.include "dibujos.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	
	mov x16, 0
	mov x29, x16
	

dibujar:
	ldr x21, delay

	//fondo
	ldr w10, fondoCelestePastel
	bl fondo

	//nubes
	movz x10, 0xff, lsl 16
	movk x10, 0xffff, lsl 00
	mov x3, 80
	bl conjunto_nubes
	
	mov x3, 80
	sub x16, x29, 480
	bl conjunto_nubes
	
	//casa y globos
	bl globos
	bl casa

time:
	subs x21, x21, 1
        b.ne time
        
        cmp x27, 480
        b.eq continuacion
segg:   add x16, x29, 1
        add x29, x29, 1
        
        b dibujar

continuacion:
	mov x29, 0
	b segg

InfLoop: 
	b InfLoop


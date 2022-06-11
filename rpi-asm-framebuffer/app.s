
.include "dibujos.s"
.data
delay: .dword 0xffffff

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	ldr w10, fondoCelestePastel
	bl fondo
	
	mov x16, 20
	mov x24, x16
	
dibujar:
	ldr x27, delay

	ldr w10, fondoCelestePastel
	bl fondo

	//nubes
	movz x10, 0xff, lsl 16
	movk x10, 0xffff, lsl 00
	mov x3, 80
	bl conjunto_nubes
	
	bl casa

time:
	subs x27, x27, 1
        b.ne time
        
        add x16, x24, 1
        add x24, x24, 1
        
        b dibujar

InfLoop: 
	b InfLoop


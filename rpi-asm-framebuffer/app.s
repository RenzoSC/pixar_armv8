.include "rectangulo.s"

.data
	delay: .dword 0xffffff
	
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.globl main


main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	
	movz x10, 0x8B, lsl 16
	movk x10, 0xBEFF, lsl 00
	movz x9, 0x00, lsl 00
	
	mov x13, 80		// Coordenada x donde va a empezar a dibujar
	mov x14, 190		// Coordenada y donde va a empezar a dibujar
	mov x21, 70
	mov x22, 10
	
dibujar:
	ldr x15, delay		//en cada loop de dibujo carda en x15 el valor de delay

	//ACA DIBUJA EL FONDO
	
	bl fondo
	
	//UNA VEZ DIBUJADO EL FONDO DIBUJA EL RECTANGULO	

	bl rectangulo	
				//al salir del bucle crea un delay con time
time:
	subs x15, x15, 1
        b.ne time		//al ser un numero grande el q se guarda en delay
				//evita el titileo de pantalla 
				
	add x13,x13,1		//muevo el rectangulo a la der en pos x para q se mueva y se actualice
	b dibujar

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop: 
	b InfLoop

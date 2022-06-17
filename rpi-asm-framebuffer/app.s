.include "dibujos.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	
	
	//ANIMACION: valores inciales
	//coordenada ´y´ de la nube
	mov x16, 0
	mov x29, x16
	//color incial del fondo
	ldr w10, fondoComienzo
	
dibujar2: 
	mov x2, 10		//reinicio el contador y lo guardo en memoria
	mov x23, 100
	stur x2, [x23, #20]

dibujar:
	ldr x21, delay


	//cambio la direccion para dibujar todo en el buffer secundario
	bl direccion_secundaria

	//dibujar: FONDO	(guardo en memoria el ultimo color del fondo que fue usado)
	bl fondo
	mov x22, 100
	stur w10, [x22, #10]	

	//dibujar: NUBES	(2 veces para que las nubes se regeneren infinitamente)
	mov x3, 100
	bl conjunto_nubes
	mov x3, 100
	sub x16, x29, 480
	bl conjunto_nubes
	
	//dibujar: CASA y GLOBOS
	bl casa
	bl globos
	

	bl actualizar_framebuffer


time:
	subs x21, x21, 1
        b.ne time
        
        cmp x29, 480
        b.eq continuacion
segg:   add x16, x29, 5
        add x29, x29, 5
       
       mov x23, 100
       ldur x2, [x23, #20]
       sub x2, x2, 1
       stur x2, [x23, #20]
       
       mov x22, 100
       ldur x10, [x22, #10]
        
       cbnz x2, dibujar
       
        
	//FONDO
	bl actualizar_fondo
	b dibujar2

continuacion:
	mov x29, 0
	b segg



InfLoop: 
	b InfLoop


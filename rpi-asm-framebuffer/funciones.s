.ifndef funciones
.equ funciones, 0

.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

/*---------------------------------------------------------------------------------------------------
funcion: pintar un pixel
	parametros:	x10 (color para pintar)
			x6 (coordenada x)
			x2 (coordenada y)
			
	usa los registros: x26 x0
---------------------------------------------------------------------------------------------------*/
pintar:
	madd x26, x2, x5, x6 // x26 = (x6 * 640) + x1
        str w10, [x0, x26, lsl #2] // Guardo w10 en x0 + x26*2^2
        
        br lr
	
	
	
	
	


/*---------------------------------------------------------------------------------------------------
funcion: dibujar un rectangulo
	parametros:	x1 (coordenada x) x2 (coordenada y)
			x3 (largo del rectangulo) x4 (ancho del rectangulo)
			x10 (color del rectangulo)
---------------------------------------------------------------------------------------------------*/
rectangulo:

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
        stur lr, [sp]

	// X0 contiene la direccion base del framebuffer
 	mov x0, x20
	
	mov x5, SCREEN_WIDTH
	
	add x7, x1, x3	// fin del rectangulo en eje x, x7 = x + Largo
	add x8, x2, x4	// fin del rectangulo en eje y, x8 = y + Ancho
	
recorrecolumna:
	mov x6, x1	// coordenada x para moverme
	
recorrefila:

	bl pintar	//la coordenada donde estoy la pinto
	
siga:	add x6, x6, 1
	cmp x6, x7
	b.le recorrefila
	add x2, x2, 1
	cmp x2, x8
	b.le recorrecolumna

	ldur lr, [sp] // Recupero el puntero de retorno del stack
        add sp, sp, #8 
	br lr







/*------------------------------------------------------------------------------
funcion: pintar fondo
	parametros:	 x10 (color para el fondo)
	usa los registro:	x1 x2
-------------------------------------------------------------------------------*/
fondo:
	mov x0, x20
	mov x2, SCREEN_HEIGH         // Y Size	
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]	   // Set color of pixel N
	add x0,x0,4	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1, loop0
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump
	br lr


	




.endif
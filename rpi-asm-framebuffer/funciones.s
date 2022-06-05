
.ifndef funciones_s
.equ funciones_s, 0

.include "datos.s"

/*---------------------------------------------------------------------------------------------------
funcion: pintar un pixel
	parametros:	x10 (color para pintar)
			x6 (coordenada x)
			x2 (coordenada y)
			
	usa los registros: x26 x0
---------------------------------------------------------------------------------------------------*/
pintar:
	madd x26, x2, x5, x6 // x26 = (x2 * 640) + x6
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
	
siga:	
	add x6, x6, 1
	cmp x6, x7
	b.le recorrefila
	add x2, x2, 1
	cmp x2, x8
	b.le recorrecolumna

	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
	br lr


/*------------------------------------------------------------------------------
funcion: pintar ovalo/circulo
	parametros:	 x10 (color para el fondo)
	usa los registro:
		x16, x3 (COORDY_CENTRO COORDX_CENTRO)
		x4, x7 (RADX, RADY)
-------------------------------------------------------------------------------*/
circulo:
	//A LA ELIPSE LO CONTIENE UN RECTANGULO DE ALTURA RADX*2 Y ANCHO RADY*2
	//SABIENDO ESTO LA ESQUINA DERECHA ESTARA EN LA COORD: x3-x4 , x16-x5
	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
	
	mov x0, x20
	mov x5, SCREEN_WIDTH
	sub x2, x16, x7 	//coordenada y donde empiezo a evaluar
	
	add x9, x7,x7		//diam de y
	add x8,x4,x4		//diam de x
	
	mul x19,x4,x4		// radx²
	mul x7,x7,x7		// rady²
	
	mul x15,x19,x7		// x15= radx²*rady²
	
sig_lamina:	
	sub x6, x3, x4 	//coordenada x donde empiezo a evaluar
	mov x18, x8 		//diam de x
	
seguir:
	sub x17, x6, x3		// x17 = cord x - centro x
	sub x11, x2, x16		// x11 = cord y - centro y
	
	mul x17,x17,x17		// x17 = (cord x - centro x)²
	mul x11,x11,x11		// x11 = (cord y - centro y)²
	
	mul x12,x11,x19		// x12 = (x-h)²*radx²
	
	mul x13,x17,x7		// x13 = (y-k)²*rady²
	
	add x14,x13,x12		
			
	cmp x14, x15
		
	b.le pinto		// si la formula me da menor igual a rady²*radx² entonces el punto esta dentro y pinta

sigo:				// cuando pinta sigue viene aca, si no pinta tambien asi que suma y resta al contador
	add x6, x6, 1		//va al sig pix
	sub x18, x18, 1		//contador del diam x
	cbnz x18, seguir		// mientras el diametro de x no se haya acabado entonces sigue en la verificacion
	
	add x2,x2,1			//en caso de que se acabe el diam x, aumenta el y
	sub x9,x9,1		//resta 1 al cont del diam de y y vuelve a hacer la evaluacion
	cbnz x9, sig_lamina
	b fin
pinto:
	
	madd x26, x2, x5, x6 // x26 = (x2 * 640) + x6
    str w10, [x0, x26, lsl #2] // Guardo w10 en x0 + x26*2^2
	b sigo
fin:
	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
	br lr

/*------------------------------------------------------------------------------
funcion: pintar fondo
	parametros:	 x10 (color para el fondo)
	usa los registro:	x1 x2
-------------------------------------------------------------------------------*/
fondo:
	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]

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
	
	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
	br lr
//	
.endif

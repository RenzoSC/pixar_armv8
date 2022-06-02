.ifndef funciones
.equ funciones, 0

.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32




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

rectangulo:
	//UNA VEZ DIBUJADO EL FONDO DIBUJA EL RECTANGULO	

	mov x0, x20		//vuelve a la pos inicial de framebuffer
	
	mov x1, SCREEN_WIDTH	//retoma el ancho de la screen para hacer bien el calculo del madd posterior
	mov x2, x14		//COORDENADA Y DEL RECTANGULO
	mov x7, x21		//ALTO

siguiente:
	mov x3, x13		//COORDENADA X DEL RECTANGULO
	mov x6, x22		//ANCHO
lamina:	
	madd x5, x2,x1,x3	// x5 = (x2 * 640) + x3		//calculo de posicion
	str w9, [x0, x5, lsl 2]	
	add x3,x3,1		// x3 +=1	//de esta forma pasa al sig pixel
	sub x6, x6,1		// resta 1 al contador de ancho
	cbnz x6, lamina		// bucle

	add x2,x2,1		// cuando sale del bucle suma 1 a
	sub x7,x7,1		// coordenada Y y resta 1 al cont de alt
	cbnz x7, siguiente	
	
	br lr
.endif

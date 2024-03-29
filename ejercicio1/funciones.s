
.ifndef funciones_s
.equ funciones_s, 0

.include "datos.s"

/*---------------------------------------------------------------------------------------------------
funcion: pintar un pixel
	parametros:	x10 (color para pintar)
			x6 (coordenada x)
			x2 (coordenada y)
			
	todos los registros: x2 x5 x6 x26
---------------------------------------------------------------------------------------------------*/
pintar:
	madd x26, x2, x5, x6 // x26 = (x2 * 640) + x6
    str w10, [x0, x26, lsl #2] // Guardo w10 en x0 + x26*2^2
        
    br lr

/*---------------------------------------------------------------------------------------------------
funcion: dibujar un rectangulo
	parametros:	x1 (coordenada x) x2 (coordenada y)

			x3 (largo del rectangulo -> ) x4 (ancho/alto del rectangulo )
			x10 (color del rectangulo)
			
	todos los registros: x0 x1 x2 x3 x4 x5 x6 x7 x8
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
		
	todos los registros: x0 x2 x3 x5 x7 x8 x9 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 
-------------------------------------------------------------------------------*/
circulo:
	//A LA ELIPSE LO CONTIENE UN RECTANGULO DE ALTURA RADX*2 Y ANCHO RADY*2
	//SABIENDO ESTO LA ESQUINA DERECHA ESTARA EN LA COORD: x3-x4 , x16-x5
	sub sp, sp, #24 // Guardo el puntero de retorno en el stack
    str lr, [sp,#16]
	str x3,[sp,#8]  // Store Register X5 in stack
    str x16,[sp,#0]  // Store Register X7 in stack

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
	bl pintar
	b sigo
fin:
	ldr lr, [sp,#16] // Recupero el puntero de retorno del stack
	ldr x3,[sp,#8]
	ldr x16,[sp,#0]
   	add sp, sp, #24 
	br lr

/*------------------------------------------------------------------------------
funcion: pintar fondo
	parametros:	 x10 (color para el fondo)
	usa los registro:	x1 x2
-------------------------------------------------------------------------------*/
fondo:
	sub sp, sp, #24 // Guardo el puntero de retorno en el stack
    str x1, [sp, #16]
	str x2, [sp, #8]
	str lr, [sp, #0]

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
	
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	ldr lr, [sp, #0]
    add sp, sp, #24
	br lr
	
/*------------------------------------------------------------------------------
funcion: pintar trapecio
	parametros:	 x10 (color)
			 x11 coordenada x donde empieza
			 x2 coordenada y donde empieza
			 x3 largo base (numero impar)
			 x4 alto (menor o igual a ((base div 2) + 1), si es igual hacemos un triangulo)
			 x7 cantidad de filas que son iguales	
			 
	todos los registros: x2 x3 x4 x6 x11 x12 x13
-------------------------------------------------------------------------------*/
trapecio: 

	sub sp, sp, #8 			// Guardo el puntero de retorno en el stack
        stur lr, [sp]
        
subirfilanueva:
	mov x13, x7	
        
subirfila:        
        mov x6, x11			//en x6 guardo la coordenada x
        mov x12, x3			//en x12 guardo el largo a pintar por fila

seguirfila:        
        bl pintar			//pinto la coordenada donde estoy, x6,x2
        add x6, x6, 1			//voy al pixel de al lado
        sub x12, x12, 1			//resto uno pq acabo de pintar uno
        cbnz x12, seguirfila		//veo si me quedo por pintar
        
        sub x13, x13, 1			//una fila menos a pintar de la misma forma
        sub x2, x2, 1			//subimos, entonces y decrece
        cbnz x13, subirfila	
        
        				//si ya no tengo nada que pintar en esa fila y ademas se achica lo que pinto..
        sub x3, x3, 2			//resto 2, un pixel menos de cada lado
        add x11, x11, 1			//la coordenada x ahora es la original + 1
        sub x4, x4, 1			//resto 1 pq ya pinte una fila
        cbnz x4, subirfilanueva	

	ldur lr, [sp] 			// Recupero el puntero de retorno del stack
    add sp, sp, #8 
	br lr

/*------------------------------------------------------------------------------
funcion: pintar_linea

	parametros:	 x1 (punto inicial en eje x) 
			 x2(punto inicial en eje y) 
			 x3(punto final en eje x) 
			 x4(punto final en eje y)
			 x10 color
			 
	todos los registros: x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x18 x26 x28 
-------------------------------------------------------------------------------*/
pintar_linea:
	sub sp, sp, #16 // Guardo el puntero de retorno en el stack
  str lr, [sp,#8]
	str x7, [sp,#0]
	
	mov x13, SCREEN_WIDTH
	mov x28,1
	sub x5,x3,x1 //ax = x2-x1
	sub x6,x4,x2 //ay = y2-y1
//GENERAMOS LOS ABSOLUTOS DE AX Y AY Y OBTENEMOS SU SIGNO en x7 y x8 correspondidamente
	cmp x5, xzr	//PRIMER IF
	b.eq iguales1
	cmp x5, xzr
	b.lt menorestricto1
	mov x7, 1	//signo1 = 1
	b sigo1
iguales1:
	mov x7, 0
	b sigo1
menorestricto1:
	sub x5, xzr, x5	//ax = -ax
	sub x7, xzr, x28	//signo1= -1
sigo1:
	cmp x6, xzr	//SEGUNDO IF
	b.eq iguales2
	cmp x6, xzr
	b.lt menorestricto2
	mov x8, 1	//signo2= 1
	b sigo2
iguales2:
	mov x8, 0
menorestricto2:
	sub x6, xzr, x6	//ay= -ay
	sub x8, xzr, x28	//signo2= -1

//ACA TERMINAN LOS ABSOLUTOS Y EL SIGNO

sigo2:
	cmp x6, x5	//TERCER IF
	b.le menorestricto3
	mov x9, 1	//intercambio= 1
	mov x18, x6	//registro temporal para hacer una asignacion multiple, quiero hacer un swap
	mov x6, x5	//dx = dy
	mov x5, x18	//dy = dx
	b sigo3
	
menorestricto3:
	mov x9, 0
sigo3:
	lsl x14,x6,#1	//ay*2
	lsl x15,x5,#1	//ax*2
	sub x11, x14, x5 // e = 2*ay -ax
	mov x12, 1		//para el for, i=1

bucleFor:
	madd x26, x2, x13, x1 // x26 = (y * 640) + x

  str w10, [x0, x26, lsl #2] // Guardo w30 en x0 + x26*2^2

	cmp x11, xzr
	b.ge mayorigual
	b sigo4
mayorigual:
	cmp x9, 1
	b.eq equal
	add x2,x2,x8
	sub x11,x11,x15
	b sigo4
equal:
	add x1,x1,x7
	sub x11,x11,x15
sigo4:
	cmp x9, 1
	b.eq equal2
	add x1,x1,x7
	add x11,x11,x14
	b sigo5
equal2:
	add x2,x2,x8
	add x11,x11,x14
sigo5:
	add x12,x12,1
	cmp x12,x5
	b.le bucleFor
	ldr lr, [sp,#8] // Recupero el puntero de retorno del stack
  ldr x7, [sp,#0]
	add sp, sp, #16 
	br lr

pintar_i:
	/*------------------------------------------------------------------------------
funcion: pintar_linea
	parametros:	 x5 (punto inicial en eje x), x6(punto inicial en eje y) esquina sup izq de la letra i 
				x4 (altura)
				x10 (color)
-------------------------------------------------------------------------------*/
	sub sp, sp, #40 // Guardo el puntero de retorno en el stack
	str x4,[sp,#32]  // Store Register X5 in stack
	str x5,[sp,#16]  // Store Register X5 in stack
    str x6,[sp,#8]  // Store Register X6 in stack
	str lr, [sp,#0]
	mov x1, x5
	mov x2, x6
	mov x3, 10

	bl rectangulo
	ldr x5, [sp,#16] // Recupero registros del stack
	ldr x6,[sp,#8]
	ldr x4,[sp,#32]
	//temporales
	sub x7,	x5,10
	mov x8, 30 
	add x9, x6,x4 
	str x9, [sp, #24]
	str x7, [sp, #16]
	str x8, [sp, #8]
	//
	mov x1,	x7 //40
	mov x2, x6 //170
	mov x3, x8
	mov x4, 1
	bl rectangulo
	ldr x9, [sp, #24]
	ldr x7, [sp, #16]
	ldr x8, [sp, #8]
	mov x1, x7
	mov x2,x9
	mov x3,x8
	mov x4,1
	bl rectangulo
	ldur lr, [sp,#0] // Recupero el puntero de retorno del stack
    add sp, sp, #40
	br lr

pintar_x:
	/*------------------------------------------------------------------------------
funcion: pintar_linea
	parametros:	 x1 (punto inicial en eje x), x2(punto inicial en eje y) esquina sup izq de la letra x 
				x10 (color)
-------------------------------------------------------------------------------*/
	sub sp, sp, #24
	str x1, [sp, #16]
	str x2, [sp, #8]
	str lr, [sp, #0]
	
	sub x1,x1,5
	mov x3, 20
	mov x4,1
	bl rectangulo
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	
	mov x7, 10
repeat_linea:
	str x1, [sp, #16]
	str x2, [sp, #8]
	mov x3,x1
	add x3,x3,45
	mov x4,x2
	add x4,x4,70
	bl pintar_linea
	sub x7,x7,1
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	add x1,x1,1
	cbnz x7, repeat_linea

	add x1,x1,45
	
	str x1, [sp, #16]
	str x2, [sp, #8]
	sub x1,x1,13
	mov x3, 20
	mov x4,1
	bl rectangulo
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	str x1, [sp, #16]
	str x2, [sp, #8]
	sub x1,x1,57
	add x2,x2,70
	mov x3,20
	mov x4,1
	bl rectangulo
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]

	mov x7,5
repeat_linea2:
	str x1, [sp, #16]
	str x2, [sp, #8]
	mov x3,x1
	sub x3,x3,45
	mov x4,x2
	add x4,x4,70
	bl pintar_linea
	sub x7,x7,1
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	sub x1,x1,1
	cbnz x7, repeat_linea2
	ldr lr,[sp,#0]
	add sp, sp, #24
	br lr

pintar_a:
	/*------------------------------------------------------------------------------
funcion: pintar_linea
	parametros:	 x1 (punto inicial en eje x), x2(punto inicial en eje y) punta de la letra A
				x10 (color)
-------------------------------------------------------------------------------*/
	sub sp, sp, #24
	str x1, [sp, #16]
	str x2, [sp, #8]
	str lr, [sp, #0]

	sub x1,x1,11
	mov x3, 28
	mov x4,1
	bl rectangulo
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	str x1, [sp, #16]
	str x2, [sp, #8]
	sub x1,x1,34
	add x2,x2,70
	mov x3,16
	mov x4,1
	bl rectangulo
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	str x1, [sp, #16]
	str x2, [sp, #8]
	add x1,x1, 16
	add x2,x2,70
	mov x3,25
	mov x4,1
	bl rectangulo
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]

	mov x7, 10

repeat_linea_A:
	str x1, [sp, #16]
	str x2, [sp, #8]
	mov x3,x1
	add x3,x3,25
	mov x4,x2
	add x4,x4,70
	bl pintar_linea
	sub x7,x7,1
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	add x1,x1,1
	cbnz x7, repeat_linea_A
	mov x7,5
	sub x1,x1,9
repeat_linea_A2:
	str x1, [sp, #16]
	str x2, [sp, #8]
	mov x3,x1
	sub x3,x3,25
	mov x4,x2
	add x4,x4,70
	bl pintar_linea
	sub x7,x7,1
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	sub x1,x1,1
	cbnz x7, repeat_linea_A2
	mov x7,5
	sub x1,x1, 10
	add x2,x2, 30
repeat_linea_hor:
	str x1, [sp, #16]
	str x2, [sp, #8]
	mov x3,x1
	add x3,x3,35
	mov x4,x2
	bl pintar_linea
	sub x7,x7,1
	ldr x1, [sp, #16]
	ldr x2, [sp, #8]
	add x2,x2,1
	cbnz x7, repeat_linea_hor
	ldr lr,[sp,#0]
	add sp, sp, #24
	br lr

pintar_p:
	/*------------------------------------------------------------------------------
funcion: pintar_linea
	parametros:	 x5 (punto inicial en eje x), x6(punto inicial en eje y) punta izq arriba de p
				x10 (color)
-------------------------------------------------------------------------------*/
	sub sp, sp, #24
	str x5, [sp, #16]
	str x6, [sp, #8]
	str lr, [sp, #0]
	mov x3,x5
	add x3,x3,10
	mov x16,x6
	add x16,x16,19
	ldr w10, negro
	mov x4,30
	mov x7,20
	bl circulo
	ldr x5, [sp, #16]
	ldr x6, [sp, #8]
	str x5, [sp, #16]
	str x6, [sp, #8]
	ldr w10, fondoPixar
	mov x3,x5
	add x3,x3,10
	mov x16,x6
	add x16,x16,20
	mov x4,18
	mov x7,18
	bl circulo
	ldr x5, [sp, #16]
	ldr x6, [sp, #8]
	str x5, [sp, #16]
	str x6, [sp, #8]
	mov x1,x5
	sub x1,x1,20
	mov x2,x6
	mov x3, 30
	mov x4, 70
	bl rectangulo
	//ovalo de la p
	ldr x5, [sp, #16]
	ldr x6, [sp, #8]
	ldr w10, negro
	bl pintar_i

	ldr lr,[sp,#0]
	add sp, sp, #24
	br lr

pintar_r:
	/*------------------------------------------------------------------------------
funcion: pintar_linea
	parametros:	 x5 (punto inicial en eje x), x6(punto inicial en eje y) punta izq arriba de r
				x10 (color)
-------------------------------------------------------------------------------*/
	sub sp, sp, #24
	str x5, [sp, #16]
	str x6, [sp, #8]
	str lr, [sp, #0]
	bl pintar_p
	mov x7, 10
	ldr x5, [sp, #16]
	ldr x6, [sp, #8]
	add x5,x5,10
	add x6,x6,39
repeat_linea_R:
	str x5, [sp, #16]
	str x6, [sp, #8]
	mov x1,x5
	mov x2,x6
	mov x3,x1
	add x3,x3,25
	mov x4,x2
	add x4,x4,32
	bl pintar_linea
	sub x7,x7,1
	ldr x5, [sp, #16]
	ldr x6, [sp, #8]
	add x5,x5,1
	cbnz x7, repeat_linea_R
	ldr lr,[sp,#0]
	add sp, sp, #24
	br lr

circulo_lampara:
	/*------------------------------------------------------------------------------
funcion: pintar_linea
	parametros:	 x1 (punto inicial en eje x), x2(punto inicial en eje y) centro del circulo de la lamp
				 x7 (ancho amarillo)
				x10 (color)
-------------------------------------------------------------------------------*/
	sub sp, sp, #32 // Guardo el puntero de retorno en el stack
	str x7, [sp,#24]
    str lr, [sp,#16]
	str x1,[sp,#8]  // Store Register X1 in stack
    str x2,[sp,#0]  // Store Register X2 in stack
	mov x16,x2
	mov x3, x1
	mov x4,25
	mov x7, 25
	bl circulo

	ldr x1,[sp,#8]
	ldr x2,[sp,#0]
	str x1,[sp,#8] 
    str x2,[sp,#0]  
	sub x1,x1,25
	sub x2,x2,25
	mov x3,25
	mov x4,50
	ldr w10, fondoPixar
	bl rectangulo
	
	ldr x1,[sp,#8]
	ldr x2,[sp,#0]
	ldr w10, globoAmarillo
	ldr x7,[sp,#24]
	mov x16,x2
	mov x3,x1
	mov x4,x7
	mov x7,25
	bl circulo
	ldr lr, [sp,#16] // Recupero el puntero de retorno del stack
	ldr x1,[sp,#8]
	ldr x2,[sp,#0]
    add sp, sp, #32

	br lr

palitos_lampara:
/*------------------------------------------------------------------------------
funcion: pintar_linea
	parametros:	 x1 (punto inicial en eje x), x2(punto inicial en eje y) del primer palito
				x3 (punto final en eje x), x4(punto final en eje y) del primer palito
				x5(punto final en eje x), x6(punto final en eje y) del segundo palito
				x10 (color)
-------------------------------------------------------------------------------*/
	sub sp, sp, #56 // Guardo el puntero de retorno en el stack
	str x1,[sp,#48]  // Store Register X1 in stack
    str x2,[sp,#40]  // Store Register X2 in stack
	str x3,[sp,#32]  // Store Register X3 in stack
    str x4,[sp,#24]  // Store Register X4 in stack
	str x5,[sp,#16]  // Store Register X5 in stack
    str x6,[sp,#8]  // Store Register X6 in stack
	str lr, [sp,#0]
	mov x7,10
repeat_linea_lamp:
	str x1, [sp, #48]
	str x2, [sp, #40]
	str x3,[sp,#32]
	str x4,[sp,#24]
	bl pintar_linea
	sub x7,x7,1
	ldr x1, [sp, #48]
	ldr x2, [sp, #40]
	ldr x3,[sp,#32]
	ldr x4,[sp,#24]
	add x1,x1,1
	add x3,x3,1
	cbnz x7, repeat_linea_lamp
	mov x7,10
	ldr x5,[sp,#16]
	ldr x6,[sp,#8]
repeat_linea_lamp2:
	str x3,[sp,#32]
	str x4,[sp,#24]
	str x5,[sp,#16]
	str x6,[sp,#8]
	mov x1,x3
	mov x2,x4
	mov x3,x5
	mov x4,x6
	bl pintar_linea
	sub x7,x7,1
	ldr x3,[sp,#32]
	ldr x4,[sp,#24]
	ldr x5,[sp,#16]
	ldr x6,[sp,#8]
	sub x3,x3,1
	sub x5,x5,1
	cbnz x7, repeat_linea_lamp2

	
	ldr x1,[sp,#48]  // Store Register X1 in stack
    ldr x2,[sp,#40]  // Store Register X2 in stack
	ldr x3,[sp,#32]  // Store Register X3 in stack
    ldr x4,[sp,#24]  // Store Register X4 in stack
	ldr x5,[sp,#16]  // Store Register X5 in stack
    ldr x6,[sp,#8]  // Store Register X6 in stack
	ldr lr, [sp,#0]
	add sp,sp,#56
	br lr
base_lamp:
/*------------------------------------------------------------------------------
funcion: pintar_linea
	parametros:	x5(punto final en eje x), x6(punto final en eje y) del segundo palito
				x10 (color)
-------------------------------------------------------------------------------*/
	sub sp, sp, #24 // Guardo el puntero de retorno en el stack
    str lr, [sp,#16]
	str x5,[sp,#8]  // Store Register X5 in stack
    str x6,[sp,#0]  // Store Register X7 in stack
	add x3,x5,10
	sub x16,x6,5
	mov x4,30
	mov x7,5
	bl circulo
	
	ldr x5,[sp,#8] 
    ldr x6,[sp,#0]  
	mov x1,x5
	sub x1,x1,20
	mov x2,x6
	sub x2,x2,5
	mov x3,60
	mov x4,8
	bl rectangulo

	ldur lr, [sp,#16] // Recupero el puntero de retorno del stack
    add sp, sp, #24 
	br lr

pintar_lampara:
/*------------------------------------------------------------------------------
funcion: pintar_lampara
	parametros:	x1,x2
-------------------------------------------------------------------------------*/
	sub sp,sp,#64
	str lr,[sp,#56]
	str x1,[sp,#48]
	str x2,[sp,#40]
	mov x3,x1
	add x3,x3,40
	mov x4,x2
	add x4,x2,50
	mov x5,x1
	add x5,x1,25
	mov x6,x2
	add x6,x6,90
	str x3,[sp,#32]
	str x4,[sp,#24]
	str x5,[sp,#16]
	str x6,[sp,#8]
	str x7,[sp,#0]
	add x1,x1,5
	ldr w10, gris_lampara
	bl palitos_lampara
	bl base_lamp
	ldr x1,[sp,#48]
	ldr x2,[sp,#40]
	ldr x7,[sp,#0]
	ldr w10, gris_lampara
	bl circulo_lampara
	ldr lr,[sp,#56]
	ldr x1,[sp,#48]
	ldr x2,[sp,#40]

	ldr x7,[sp,#0]
	add sp, sp, #64
	br lr

/*------------------------------------------------------------------------------
funcion: actualizar framebuffer, copiar lo que hay en el framebuffer sencundario en el principal
-------------------------------------------------------------------------------*/
actualizar_framebuffer:

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    	stur lr, [sp]
    	
    	
    	
    	//paso lo que dibuje en el otro frame al original
    	//pongo en x20 la base del framebuffer original
	sub x20, x20, 1228800
	sub x20, x20, 1228800
	sub x20, x20, 1228800
	mov x4, 0
	
sig_pixel:
	cmp x4, 1228800
	b.eq final
	ldur x11, [x0]			//copia el secundario en el primario
	stur x11, [x20]
	
	add x20, x20, 4
	add x0, x0, 4
	add x4, x4, 4
	
	b sig_pixel
final:

	sub x20, x20, 1228800	//vuelvo el x20 a la base del framebuffer original
	mov x0, x20

	ldur lr, [sp] // Recupero el puntero de retorno del stack
    	add sp, sp, #8 
	br lr
	
	
/*------------------------------------------------------------------------------
funcion: actulizo el x0 y el x20 con la direccion del framebuffer secundario
-------------------------------------------------------------------------------*/	
direccion_secundaria:
	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    	stur lr, [sp]
    	
    	
	add x0, x0, 1228800		//el framebuffer secundario esta mas abajo que el orginal 
	add x0, x0, 1228800
	add x0, x0, 1228800
	add x20, xzr, x0
	
	
	ldur lr, [sp] // Recupero el puntero de retorno del stack
    	add sp, sp, #8 
	br lr
	
	
/*------------------------------------------------------------------------------
funcion: actulizo el color del fondo a uno mas oscuro
-------------------------------------------------------------------------------*/
actualizar_fondo:
	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    	stur lr, [sp]
    	
		ldr w11, fondoCeleste
        cmp x10, x11
        b.le two
        ldr w12, restaComienzo
        sub x10, x10 , x12
        b end2
     
        
        //83A1FC
two:	
	ldr w11, fondoAzul
	cmp x10, x11
	b.le three
	ldr w12, restaCeleste
        sub x10, x10 , x12
        b end2
        
three:	
	ldr w11, fondoAzulOscuro
	cmp x10, x11
	b.le end
	ldr w12, restaAzul
        sub x10, x10 , x12
        b end2
end:	
	ldr w11, fondoUltimo
	cmp x10, x11
	b.le end2
	ldr w12, restaAzulOscuro
	sub x10, x10 , x12
	b end2
end2:

    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
	br lr

.endif


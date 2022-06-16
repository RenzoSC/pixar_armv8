.ifndef dibujos_s
.equ dibujos_s, 0
.include "datos.s"
.include "funciones.s"


/*------------------------------------------------------------------------------
funcion: pintar_globo
	usa los registro:	x24 x25 y w10
    x24 ---> posicion_y del centro que tomará el globo
    x25 ---> posicion_x del centro que tomará el globo
    w10 ---> color del globo   
    
    todos los registros: x3 x4 x7 x16 x10 x24 x25
-------------------------------------------------------------------------------*/
pintar_globo:
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
    mov x16, x24
	mov x3, x25
	mov x4, 15
	mov x7, 20
	bl circulo
	ldr w10, reflejo
	sub x16, x16, 2
	sub x3, x3, 8
	mov x4, 3
	mov x7, 7
	bl circulo
    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr

/*------------------------------------------------------------------------------
funcion: conjunto_globos 
	usa los registro:	x1 x23 y 27
    x1 ---> posicion_y del centro que tomará el globo base del conjunto
    x23 ---> posicion_x del centro que tomará el globo base del conjunto
    x27 ---> cantidad de veces que se expandirá a la derecha ese conjunto   
    
    todos los registros: x1 x10 x16 x23 x24 x25 x27
-------------------------------------------------------------------------------*/
conjunto_globos:
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
repeat:    
    mov x24, x1
    mov x25, x23    
    ldr w10, globoRojo
	bl pintar_globo

    ldr w10, globoNaranja
	add x24, x24, 30
	add x25, x25, 20
    bl pintar_globo

    ldr w10, globoAzul
	sub x24, x24, 30
	add x25, x25, 20
    bl pintar_globo

    ldr w10, globoRosa
    add x24, x24, 5
	sub x25, x25, 25
    bl pintar_globo

    ldr w10, globoAmarillo
    add x24, x24, 25
	add x25, x25, 25
    bl pintar_globo

    ldr w10, globoVioleta
	sub x25, x25, 45
    mov x16, x24
    bl pintar_globo

    sub x27, x27,1
    add x23,x23, 60
    cbnz x27, repeat
    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr

globos:
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]

    mov x1, 65
    mov x23, 245
    mov x27, 1
    bl conjunto_globos
    mov x1, 65
    mov x23, 335
    mov x27, 1
    bl conjunto_globos

    mov x1, 95
    mov x23, 215
    mov x27, 3
    bl conjunto_globos
    mov x1, 95
    mov x23, 245
    mov x27, 3
    bl conjunto_globos
    

    mov x1, 235
    mov x23, 255
    mov x27, 1
    bl conjunto_globos
    mov x1, 235
    mov x23, 325
    mov x27, 1
    bl conjunto_globos

    mov x1, 205
    mov x23, 215
    mov x27, 3
    bl conjunto_globos
    mov x1, 205
    mov x23, 235
    mov x27, 3
    bl conjunto_globos

    mov x1, 150
    mov x23, 200
    mov x27, 4
    bl conjunto_globos
    
    //dibujo los hilos
    
    movz x10, 0x00, lsl 16
    movk x10, 0x0000, lsl 00
    
    mov x1, 250
    mov x2, 285
    mov x3, 305
    mov x4, 324
    bl pintar_linea
    
    mov x1, 275
    mov x2, 285
    mov x3, 305
    mov x4, 324
    bl pintar_linea
    
    mov x1, 295
    mov x2, 285
    mov x3, 305
    mov x4, 324
    bl pintar_linea
    
    mov x1, 320
    mov x2, 285
    mov x3, 305
    mov x4, 324
    bl pintar_linea
    
    mov x1, 345
    mov x2, 285
    mov x3, 305
    mov x4, 324
    bl pintar_linea
    
    mov x1, 365
    mov x2, 285
    mov x3, 305
    mov x4, 324
    bl pintar_linea
    
    
    
    
    
    
    
    
    

    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr
    
/*------------------------------------------------------------------------------
funcion: dibuja una casa 
 todos los registros: x1 x2 x3 x4 x10 x7 x11
-------------------------------------------------------------------------------*/

casa:

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
        stur lr, [sp]

	
	//base rosa
	movz x10, 0xf2, lsl 16
	movk x10, 0x8cbf, lsl 00
	mov x1, 250
	mov x2, 451
	mov x3, 70
	mov x4, 9
	bl rectangulo
	
	//rectangulo marron dentro de la base rosa
	movz x10, 0xcd, lsl 16
	movk x10, 0x961f, lsl 00
	mov x1, 253
	mov x2, 454
	mov x3, 67
	mov x4, 3
	bl rectangulo
	
	//base detras amarillita (la que sobresale)
	movz x10, 0xfe, lsl 16
	movk x10, 0xe98a, lsl 00
	mov x1, 247
	mov x2, 385
	mov x3, 73
	mov x4, 66
	bl rectangulo
	
	//rectangulo naranja 
	movz x10, 0xf1, lsl 16
	movk x10, 0x9031, lsl 00
	mov x1, 250
	mov x2, 411
	mov x3, 70
	mov x4, 37
	bl rectangulo
	
	//rectangulo celeste 
	movz x10, 0xaf, lsl 16
	movk x10, 0xceed, lsl 00
	mov x1, 250
	mov x2, 385
	mov x3, 132
	mov x4, 26
	bl rectangulo
	
	//puerta base
	movz x10, 0xfe, lsl 16
	movk x10, 0xe98a, lsl 00
	mov x1, 282
	mov x2, 415
	mov x3, 24
	mov x4, 33
	bl rectangulo
	
	//puerta puerta
	movz x10, 0x92, lsl 16
	movk x10, 0x352d, lsl 00
	mov x1, 286
	mov x2, 419
	mov x3, 16
	mov x4, 29
	bl rectangulo
	
	//ventana base de la entrada
	movz x10, 0xdc, lsl 16
	movk x10, 0xc87a, lsl 00
	mov x1, 257
	mov x2, 415
	mov x3, 13
	mov x4, 22
	bl rectangulo
	
	//ventana vidrio de la entrada
	movz x10, 0x3e, lsl 16
	movk x10, 0x4055, lsl 00
	mov x1, 259
	mov x2, 417
	mov x3, 9
	mov x4, 18
	bl rectangulo
	
	//ventana palito de la entrada
	movz x10, 0xdc, lsl 16
	movk x10, 0xc87a, lsl 00
	mov x1, 259
	mov x2, 425
	mov x3, 9
	mov x4, 2
	bl rectangulo
	
	//pilar amarillito
	movz x10, 0xfe, lsl 16
	movk x10, 0xe98a, lsl 00
	mov x1, 275
	mov x2, 385
	mov x3, 3
	mov x4, 63
	bl rectangulo
	
	//barandilla arriba 1
	movz x10, 0xfe, lsl 16
	movk x10, 0xe98a, lsl 00
	mov x1, 250
	mov x2, 409
	mov x3, 70
	mov x4, 2
	bl rectangulo
	
	//barandilla arriba 2
	movz x10, 0xfe, lsl 16
	movk x10, 0xe98a, lsl 00
	mov x1, 250
	mov x2, 402
	mov x3, 70
	mov x4, 2
	bl rectangulo
	
	//barandilla abajo
	movz x10, 0xfe, lsl 16
	movk x10, 0xe98a, lsl 00
	mov x1, 250
	mov x2, 439
	mov x3, 25
	mov x4, 2
	bl rectangulo
	
	//marron base derecha
	movz x10, 0xcd, lsl 16
	movk x10, 0x9420, lsl 00
	mov x1, 320
	mov x2, 448
	mov x3, 62
	mov x4, 12
	bl rectangulo
	
	//verde pared derecha
	movz x10, 0xc7, lsl 16
	movk x10, 0xe14d, lsl 00
	mov x1, 320
	mov x2, 394
	mov x3, 62
	mov x4, 54
	bl rectangulo
	
	//ventana base rosa
	movz x10, 0xed, lsl 16
	movk x10, 0x93c7, lsl 00
	mov x1, 326
	mov x2, 404
	mov x3, 50
	mov x4, 35
	bl rectangulo
	
	//ventana vidrio
	mov x11, 3	//para iterar
	
	movz x10, 0x3e, lsl 16
	movk x10, 0x4055, lsl 00
	mov x1, 331
	mov x3, 10
	mov x4, 25
	ventanaVidrioRosa:
	mov x2, 409
	bl rectangulo
	
	sub x11, x11, 1
	add x1, x1, 15
	cbnz x11, ventanaVidrioRosa
	
	//boorde rosa
	movz x10, 0xed, lsl 16
	movk x10, 0x93c7, lsl 00
	mov x1, 382
	mov x2, 385
	mov x3, 7
	mov x4, 75
	bl rectangulo

	//techo violeta
	movz x10, 0x92, lsl 16
	movk x10, 0x5e7e, lsl 00
	mov x11, 233
	mov x2, 384
	mov x3, 170
	mov x4, 10
	mov x7, 4
	bl trapecio
	
	mov x11, 258	//punta violeta izquierda
	mov x2, 350
	mov x3, 33
	mov x4, 16
	mov x7, 1
	bl trapecio
	
	//ventana traingulo violeta derecha
	mov x11, 324	
	mov x2, 344
	mov x3, 55
	mov x4, 27
	mov x7, 1
	bl trapecio
	
	//ventana amarillita izquierda
	movz x10, 0xfe, lsl 16
	movk x10, 0xe98a, lsl 00
	mov x11, 262	
	mov x2, 350
	mov x3, 25
	mov x4, 13
	mov x7, 1
	bl trapecio
	
	mov x1, 262
	mov x2, 350
	mov x3, 25
	mov x4, 20
	bl rectangulo
	
	//pilar enorme derecha amarillito
	//base
	mov x11, 313	
	mov x2, 393
	mov x3, 77
	mov x4, 15
	mov x7, 1
	bl trapecio
	//triangulo
	mov x11, 328	
	mov x2, 344
	mov x3, 47
	mov x4, 23
	mov x7, 1
	bl trapecio
	//rectangulo
	mov x1, 328
	mov x2, 345
	mov x3, 47
	mov x4, 34
	bl rectangulo
	
	//ventana base rosa
	movz x10, 0xed, lsl 16
	movk x10, 0x93c7, lsl 00

	mov x1, 268
	mov x2, 350
	mov x3, 13
	mov x4, 16
	bl rectangulo
	
	mov x1, 341
	mov x2, 345
	mov x3, 21
	mov x4, 30
	bl rectangulo
	
	//ventana vidrio
	movz x10, 0x3e, lsl 16
	movk x10, 0x4055, lsl 00
	
	mov x1, 270
	mov x2, 352
	mov x3, 9
	mov x4, 12
	bl rectangulo
	
	mov x1, 344
	mov x2, 348
	mov x3, 15
	mov x4, 24
	bl rectangulo
	
	//chimenea
	movz x10, 0xa4, lsl 16
	movk x10, 0x6a54, lsl 00
	mov x1, 300
	mov x2, 324
	mov x3, 10
	mov x4, 21
	bl rectangulo
	
	ldur lr, [sp] // Recupero el puntero de retorno del stack
        add sp, sp, #8 
	br lr    


/*------------------------------------------------------------------------------
funcion: dibuja una nube
		parametros : 	x10 color de la nube
				x3 coordenada x
				x16 coordenada y	coordenadas del primer circulo izquierdo
 
 	todos los registros: x1 x2 x3 x4 x7 x16 x22 x23
-------------------------------------------------------------------------------*/
nube:
	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    	stur lr, [sp]
    	
	mov x22, x3	//registro temporal para hacer las sumas
	mov x23, x16
	
	//mov x3, 100
	//mov x16, 207
	mov x4, 9
	mov x7, 9
	bl circulo
	
	mov x1, x22
	sub x2, x16, 7
	mov x3, 40
	mov x4, 15
	bl rectangulo
	
	add x3, x22, 40
	mov x16, x23
	mov x4, 9
	mov x7, 9
	bl circulo
	
	add x3, x22, 14
	sub x16, x23, 8
	mov x4, 14
	mov x7, 14
	bl circulo
	
	add x3, x22, 30
	sub x16, x23, 7
	mov x4, 11
	mov x7, 11
	bl circulo
	
	ldur lr, [sp] // Recupero el puntero de retorno del stack
        add sp, sp, #8 
	br lr
	

/*---------------------------------------------------------------------------------------------------
 conjunto de nubes		parametros x3 coordenada x
 					   x16 coordenada y
 					   
 	todos los registros: x3 x10 x16
---------------------------------------------------------------------------------------------------*/
conjunto_nubes:
	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    	stur lr, [sp]
    	
    	movz x10, 0xff, lsl 16
	movk x10, 0xffff, lsl 00
	
    	
    	
    	bl nube
    	add x3, x3, 200
    	add x16, x16, 40
    	bl nube
    	sub x3, x3, 150
    	add x16, x16, 120
    	bl nube
    	add x3, x3, 250
    	add x16, x16, 20
    	bl nube
    	sub x3, x3, 180
    	add x16, x16, 100
    	bl nube
    	sub x3, x3, 300
    	add x16, x16, 30
    	bl nube
    	add x3, x3, 130
    	add x16, x16, 60
    	bl nube
    	add x3, x3, 250
    	add x16, x16, 60
    	bl nube
    	
   
    	    	
    	
    	ldur lr, [sp] // Recupero el puntero de retorno del stack
    	add sp, sp, #8 
   	br lr

.endif

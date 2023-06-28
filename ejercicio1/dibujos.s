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

	mov x16, 20
	mov x3, 80
	
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

/*---------------------------------------------------------------------------------------------------
PINTAR PIXAR
---------------------------------------------------------------------------------------------------*/
pintar_pxar:
	sub sp, sp, #40 // Guardo el puntero de retorno en el stack
    str x1, [sp,#32]
	str x2, [sp,#24]
	str x5, [sp,#16]
	str x6, [sp,#8]
	str lr, [sp,#0]
	mov x5,90
	mov x6,190
	bl pintar_p

	mov x1, 290
	mov x2, 190
	bl pintar_x

	mov x1, 425
	mov x2, 190
	bl pintar_a

	mov x5, 510
	mov x6, 190
	bl pintar_r
	ldr x1, [sp,#32]
	ldr x2, [sp,#24]
	ldr x5, [sp,#16]
	ldr x6, [sp,#8]
	ldr lr, [sp,#0]
    add sp, sp, #40 
	br lr

/*------------------------------------------------------------------------------
funcion: dibuja el pasto
 todos los registros: 
-------------------------------------------------------------------------------*/  
pasto:  	

	mov x1, 0
	mov x2, 460
	
	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    	stur lr, [sp]
    	
    	mov x9, x2		//guardo en x9 la coordenada y
    	
	movz x10, 0x67, lsl 16
	movk x10, 0xb250, lsl 00
	mov x3, 640
	mov x4, 5
	bl rectangulo
	
	movz x10, 0x54, lsl 16
	movk x10, 0x412a, lsl 00
	add x2, x9, 5
	mov x3, 640
	mov x4, 15
	bl rectangulo


	ldur lr, [sp] // Recupero el puntero de retorno del stack
    	add sp, sp, #8 
   	br lr
   	
/*------------------------------------------------------------------------------
funcion: anima el PIXAR
-------------------------------------------------------------------------------*/
ultra_animation:
	sub sp, sp, #24 // Guardo el puntero de retorno en el stack
	str lr,[sp,#16]
	mov x5,200
	mov x6,190
	
	mov x4, 70
	str x4, [sp,#0]
	str x6, [sp,#8]

	mov x1, 190
	mov x2, 96
	mov x7, 5
	
	mov x22, x2
	mov x29, 2	//para contar los saltos
	
saltoarriba:
	bl direccion_secundaria
	
	ldr w10, fondoPixar
	bl fondo

	ldr x21, delay

	bl pintar_pxar
	mov x5,200
	ldr x4, [sp,#0]
	ldr x6, [sp,#8]
	bl pintar_i
	
	mov x1, 190
	mov x7, 5
	mov x2, x22
	bl pintar_lampara
	
	bl actualizar_framebuffer
	
time:
	subs x21, x21, 1
        b.ne time
        
        sub x2, x22, 1
        sub x22, x22, 1
        cmp x2, 40
        b.eq finalis
        
  	b saltoarriba

finalis:
	cbz x29, bajartodo

bajar:	
	bl direccion_secundaria
	ldr w10, fondoPixar
	bl fondo

	ldr x21, delay

	bl pintar_pxar
	mov x5,200
	ldr x4, [sp,#0]
	ldr x6, [sp,#8]
	bl pintar_i

	mov x1, 190
	mov x7, 5
	mov x2, x22
	bl pintar_lampara
	bl actualizar_framebuffer
	ldr x4, [sp,#0]
	ldr x6, [sp,#8]
time2:
	subs x21, x21, 1
        b.ne time2
        
        add x22, x22, 1
		cmp x22, 96
		b.lt seguir_sini
		sub x4,x4,1
		add x6,x6,1
		str x4, [sp,#0]
		str x6, [sp,#8]
seguir_sini:        
		cmp x2, 116
        b.eq finalis2
        
  	b bajar

finalis2:
	
volverinicio:
	bl direccion_secundaria
	ldr w10, fondoPixar
	bl fondo

	ldr x21, delay

	bl pintar_pxar
	mov x5,200
	ldr x4, [sp,#0]
	ldr x6, [sp,#8]
	bl pintar_i

	mov x1, 190
	mov x7, 5
	mov x2, x22
	bl pintar_lampara
	
	bl actualizar_framebuffer
	
	ldr x4, [sp,#0]
	ldr x6, [sp,#8]
	
	
time3:
	subs x21, x21, 1
        b.ne time3
    
        sub x22, x22, 1
        cmp x2, 96
		b.lt seguir_sini2
		add x4,x4,1
		sub x6,x6,1
		str x4, [sp,#0]
		str x6, [sp,#8]
seguir_sini2:
		cmp x2, 96
        b.eq finalis3
        
  	b volverinicio

finalis3:
	
	sub x29, x29, 1
	cbnz x29, saltoarriba
	
	b saltoarriba
	
bajartodo:

	bl direccion_secundaria
	ldr w10, fondoPixar
	bl fondo

	ldr x21, delay

	bl pintar_pxar
	mov x5,200
	ldr x4, [sp,#0]
	ldr x6, [sp,#8]
	bl pintar_i

	mov x1, 190
	mov x7, 5
	mov x2, x22
	bl pintar_lampara
	
	bl actualizar_framebuffer
	
	ldr x4, [sp,#0]
	ldr x6, [sp,#8]
	
	
time4:
	subs x21, x21, 1
        b.ne time4
		add x22, x22, 1
		cmp x22, 96
        b.lt seguir_sini3
		sub x4,x4,1
		add x6,x6,1
		str x4, [sp,#0]
		str x6, [sp,#8]
seguir_sini3:
		cmp x2, 170
        b.eq finalis4
  	b bajartodo

finalis4:
	
	
	mov x7, 5
	mov x22, 5
	
agrandarFoco:

	bl direccion_secundaria
	ldr w10, fondoPixar
	bl fondo

	ldr x21, delay

	bl pintar_pxar

	mov x1, 190
	mov x7, x22
	mov x2, 169
	bl pintar_lampara
	bl actualizar_framebuffer
	
time5:
	subs x21, x21, 1
        b.ne time5
        
        add x22, x22, 1
        cmp x7, 18
        b.eq finalis5
        
  	b agrandarFoco

finalis5:
	ldr lr,[sp,#16]
	add sp, sp, #24 // Guardo el puntero de retorno en el stack
	br lr
	
/*------------------------------------------------------------------------------
funcion: telon rojo
-------------------------------------------------------------------------------*/
telon_negro:

	sub sp, sp, #24 // Guardo el puntero de retorno en el stack
	str lr,[sp,#16]
	
	mov x4, 1	
	
	
telonNegro:
	
	//ldr w10, fondoPixar
	//bl fondo
	ldr w10, negro
	mov x1, 0
	mov x2, 0
	mov x3, 640
	bl rectangulo
	mov x16, x4
	bl circulo
	mov x7, 20
	bl circulo
	
	ldr x21, delay2
	
tiempotelon:
	subs x21, x21, 1
        b.ne tiempotelon
        
        add x4, x4, 1
        cmp x4, 330
        b.eq fin_telon
        
  	b telonNegro
  	
fin_telon:
  	
	ldr lr,[sp,#16]
	add sp, sp, #24 // Guardo el puntero de retorno en el stack
	br lr

/*------------------------------------------------------------------------------
funcion: animacion casa
-------------------------------------------------------------------------------*/
animacion_casa:

	sub sp, sp, #24 // Guardo el puntero de retorno en el stack
	str lr,[sp,#16]

//ANIMACION: valores inciales
	//coordenada ´y´ de la nube
	mov x16, 0
	mov x29, x16
	//color incial del fondo
	ldr w10, fondoComienzo
	
dibujar2: 
	mov x2, 8		//reinicio el contador y lo guardo en memoria
	mov x23, 100
	stur x2, [x23, #20]

dibujar:
	ldr x21, delay3


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


time_casa:
	subs x21, x21, 1
        b.ne time_casa
        
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


	ldr lr,[sp,#16]
	add sp, sp, #24 // Guardo el puntero de retorno en el stack
	br lr

.endif

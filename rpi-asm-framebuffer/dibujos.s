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

globos:
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
    mov x1, 150
    mov x23, 200
    mov x27, 3

/*------------------------------------------------------------------------------
funcion: pintar_globo   AUN ESTÁ EN BETA HAY QUE ARREGLARLO PARA QUE SE PUEDA LLAMAR DESDE LA FUNC GLOBOS
	usa los registro:	x1 x23 y 27
    x24 ---> posicion_y del centro que tomará el globo base del conjunto
    x25 ---> posicion_x del centro que tomará el globo base del conjunto
    x27 ---> cantidad de veces que se expandirá a la derecha ese conjunto   
-------------------------------------------------------------------------------*/
conjunto_globos:
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
    cbnz x27, conjunto_globos
    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr

.endif

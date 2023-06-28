.include "dibujos.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------	
	
	
/* animacion PIXAR con lampara que salta 
Se dibuja la imagen principal y luego va cambiando la letra "i" y la lampara. Se utilizan loops tanto para subir como para bajar ambos elementos
*/
	bl ultra_animation

/* telon que acaba una vez que cubre toda la pantall
Se utiliza la funcion "rectangulo" en un loop aumentando cada vez el alto del mismo pera cubrir toda la pantalla. 
 */
	bl telon_negro
	
/* aniamcion donde la casa vuela (las nubes van bajando)
Lo principal es el movimiento de las nubes que se regeneran infinitamente. Se llama a la funcion "nubes" posiciones mas arribas que va a ir bajando para que siempre haya nubes nuevas en el framebuffer. 
Para el cambio de color en el fondo, se utilizan unos cuantos colores base y a partir de ahí se realizan operaciones en el registro que tiene el RGB para lograr que oscurezca el color.
La funcion de los hilos es la implementacion del algoritmo de Bresenham.
*/
	bl animacion_casa

/*
Se utiliza un Framebuffer secundario para las animacioes para evitar el parpadeo. Para ello se utilizan las funciones:
-	direccion_secundaria (mueve el x0 y el x20 posiciones mas abajo de la direccion base del Framebuffer)
Luego de eso se llaman a las funciones necesarias para pintar los objetos.
-	actualizar_framebuffer (copia lo que se pintó en el framebuffer secundario, en el original)
*/
	
InfLoop: 
	b InfLoop

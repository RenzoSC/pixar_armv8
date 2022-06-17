.include "dibujos.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------	
	ldr w10, fondoPixar
	bl fondo

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
	bl pintar_pxar
	mov x5,200
	mov x6,190
	mov x4,70
	str x4, [sp,#0]
	bl pintar_i
	
	mov x23, 0
	mov x24,2
achica:
	ldr w10, fondoPixar
	bl fondo
	bl pintar_pxar
	ldr x4, [sp,#0]
	bl pintar_i
	ldr x21, delay
	
time:
	subs x21, x21, 1
    b.ne time	
	sub x4,x4,1
	add x6,x6,1
	str x4, [sp,#0]
	add x23,x23,1
	cmp x23,20
	b.eq anim_agranda
	b achica

anim_agranda:
	ldr w10, fondoPixar
	bl fondo
	bl pintar_pxar
	ldr x4, [sp,#0]
	bl pintar_i
	ldr x21, delay
time2:
	subs x21, x21, 1
    b.ne time2	
	add x4,x4,1
	sub x6,x6,1
	str x4, [sp,#0]
	sub x23,x23,1
	cmp x23,0
	b.eq achica2
	b anim_agranda
achica2:
	sub x24,x24,1
	cbnz x24, achica
achica3:
	ldr w10, fondoPixar
	bl fondo
	bl pintar_pxar
	ldr x4, [sp,#0]
	bl pintar_i
	ldr x21, delay
time5:
	subs x21, x21, 1
    b.ne time5	
	sub x4,x4,1
	add x6,x6,1
	str x4, [sp,#0]
	add x23,x23,1
	cmp x23,70
	b.eq finalis
	b achica3
finalis:	
	
	
	
	
	
	
	
	
	
	
	
	
InfLoop: 
	b InfLoop
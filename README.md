# FrameBuffer en Raspberry Pi 3

Este proyecto tiene como objetivo explorar y comprender el uso del framebuffer en la plataforma Raspberry Pi 3,
utilizando programas escritos en lenguaje ensamblador ARMv8. El framebuffer es un método de acceso a dispositivos 
gráficos que representa cada píxel de la pantalla como ubicaciones en el mapa de memoria de acceso aleatorio. 
En este caso, utilizaremos el Video Core (VC) de la Raspberry Pi 3 para manejar la interfaz gráfica.

## Instalación

1 Actualiza los repositorios:

  $ sudo apt update

2 Configura el conjunto de herramientas AARCH64:

  $ sudo apt install gcc-aarch64-linux-gnu

3 Configura QEMU ARM (incluye AARCH64):

  $ sudo apt install qemu-system-arm

4 Obtén y compila GDB AARCH64:

  $ sudo apt install gdb-multiarch

5 Configura GDB para mayor comodidad:

  $ wget -P ~ git.io/.gdbinit

## Ejecución

Dentro de cada ejercicio se encuentra un readme con informacion para ejecutar el codigo y una descripcion del mimso

## Notas
En la carpeta ./ejemplos se encuentra una foto y un video de como sería la ejecucion del ejercicio 1 y 2 respectivamente

## Modalidad virtual de dictado de la materia

Este proyecto se realiza en una modalidad virtual de dictado de la materia, por lo que la Raspberry Pi 3 se emula en lugar de utilizarse físicamente.

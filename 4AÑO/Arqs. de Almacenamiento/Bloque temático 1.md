
*En este bloque usaremos las transparencias:*
[Texto](file:\\\C:\Users\Máximo\Desktop\obsidian_srcs\Bloque-tematico-1.pdf)

## Índice:
- [Tema I: Organización de la E/S](#tema1)
- [Tema II: Análisis y evolución del bus PCI](#tema2)

## Tema I: Organización de la E/S
#tema1

![[Pasted image 20231018015431.png]]
![[Pasted image 20231018020306.png]]

### 1. Estructura de la E/S

![[Estructura de E-S.png]]

La interfase suele estar integrada en el periférico, pero puede ser un dispositivo independiente.

El **Driver** del dispositivo es el software que gestiona y controla la transferencia de datos y es ejecuta en el sistema procesador.

La dirección de las transferencias con referencia al sistema procesador:
- Lectura (Read): los datos provienen del periférico y entran al sistema procesador.
- Escritura (Write): los datos provienen del sistema procesador y van al periférico.

![[Registros interfase.png]]

Los **registros de control** permiten el control indirecto del hardware escribiendo valores en ellos.

Los **registros de estado** aportan información actual del periférico.

Los **registros de entrada de datos** albergan temporalmente los datos entregados desde el periférico para el sistema procesador (un único registro o un buffer RAM).

Los **registros de salida de datos** albergan temporalmente los datos enviados hacia el periférico (un único registro o un buffer RAM).
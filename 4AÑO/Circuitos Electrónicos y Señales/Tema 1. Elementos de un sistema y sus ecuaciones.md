## Índice
1. [[#Introducción a los sistemas|Introducción a los sistemas]]
2. [[#Señales|Señales]]
3. [[#Elementos y ecuaciones de un sistema|Elementos y ecuaciones de un sistema]]
----
## 1. Introducción a los sistemas
#Introducción
- Definición de un sistema: 
<mark style="background: #FFF3A3A6;">"Ente formado por un conjunto de elementos (señales) que evolucionan según a unas reglas, variando en función de una variable independiente que es el tiempo."</mark>

Los hay continuos (analógicos)  y discretos (digitales).

Ventajas:
- Mayor precisión en la representación
- Mayor inmunidad al ruido
- Mayor capacidad de cálculo y procesamiento
- Diseño simple y estructurado
- Flexibilidad de diseños
![[Pasted image 20231020115307.png]]

Se respeta la causalidad (la respuesta 'y' en un instante 't' depende de la entrada 'x' y en instantes anteriores), la estabilidad (si se anula 'x' se anula 'y'), la linealidad (superposición, $ay_1 + by_2 = ax_1 + bx_2$), y la invarianza en el tiempo.

El <u>análisis de los sistemas</u> corresponde a la determinación y evaluación de la respuesta en cuestión de la entrada conocida y la determinación de las propiedades del mismo.
La <u>síntesis de los sistemas o diseño</u> corresponde a la determinación de la estructura de un sistema en función de las especificaciones de entradas conocidas y salidas deseadas.

---
## 2. Señales
#Señales
*¿Qué es una señal?*
<mark style="background: #FFF3A3A6;">"Cualquier magnitud física que puede utilizarse para representar información relativa a un sistema asociado. En los sistemas electrónicos, las señales se asocian a variaciones temporales de magnitudes eléctricas (tensión, corrientes)"</mark>

Se pueden representar con **funciones matemáticas, series numéricas, gráficas o tablas de valores.**

### Clasificación de las señales

1. Señales de Tiempo Continuo
![[Pasted image 20231020121222.png]]
2. Señales de Tiempo Discreto
![[Pasted image 20231020121248.png]]

3. Señales causales
	- Si para valores de $x(t) = 0$ con $t < 0$ o $x[n] = 0$ con $n < 0$.
![[Pasted image 20231020124431.png]]

4. Señales periódicas
	- Si $x(t) = x(t + T)$ o $x[n] = x[n + N]$
![[Pasted image 20231020124611.png]]

5. Señales deterministas
	- Si para $x(t)$ o $x[n]$ no hay incertidumbre en ningún $t$ o $n$.
![[Pasted image 20231020124739.png]]
![[Pasted image 20231020124751.png]]

6. Señales aleatorias
	- Si para $x(t)$ o $x[n]$ sí hay incertidumbre en ningún $t$ o $n$.
![[Pasted image 20231020125441.png]]
![[Pasted image 20231020125450.png]]

7. Señales pares
	- Si $\forall t, n$ se cumple que $x(-t) =x(t) \land x[-n] = x[n]$ 
![[Pasted image 20231020130523.png]]
![[Pasted image 20231020130535.png]]

8. Señales impares
	- Si $\forall t, n$ se cumple que $x(-t) =-x(t) \land x[-n] = -x[n]$ 
![[Pasted image 20231020130809.png]]
![[Pasted image 20231020130823.png]]

### Muestreo

El muestreo consiste en seleccionar ciertos valores de una señal continua para obtener una discreta.
$x(t)$ puede reconstruirse a partir de $x[n] = x(n T_s)$ si $f_s > 2f_b$ siendo $f_b$ componente de frecuencia más alta de $x(t)$.

![[Pasted image 20231020160325.png]]


### Conversión Analógico/Digital y Digital/Analógico

Un sistema digital tiene que tener un paso previo por un dispositivo que convierte una señal analógica en una señal digital o discreta para usarla de entrada. 

![[Pasted image 20231020161056.png]]

Algunas operaciones sobre la variable independiente:
![[Pasted image 20231020164354.png]]
![[Pasted image 20231020164408.png]]
![[Pasted image 20231020164651.png]]

### Señales elementales
1. Señal Exponencial
![[Pasted image 20231020165021.png]]

2. Señal Sinusoidal

![[Pasted image 20231020165105.png]]
![[Pasted image 20231020165250.png]]

3. Señal Escalón Unitario

![[Pasted image 20231020170400.png]]

4.  Señal Pulso

![[Pasted image 20231020170413.png]]

5. Señal Rampa

![[Pasted image 20231020170517.png]]

6. Señal Triangular

![[Pasted image 20231020170539.png]]

7. Señal Signo

![[Pasted image 20231020170617.png]]

8. Señal Impulso

![[Pasted image 20231020171712.png]]

## 3. Elementos y ecuaciones de un sistema

![[Pasted image 20231024041738.png]]

El estado de un sistema son los valores de las variables de los elementos del sistema en un instante de tiempo $t_0$. 
- El <mark style="background: #FFF3A3A6;">estado inicial</mark> es cuando $t = 0$
- <mark style="background: #FFF3A3A6;">Respuesta a estado inicial cero</mark> es la evolución del estado cuando $y = 0$ para $t = 0$
- <mark style="background: #FFF3A3A6;">Régimen libre</mark> es la evolución del estado cuando $x = 0$

En los sistemas discretos se usarán ecuaciones de recurrencia mientras que en los continuos, ecuaciones diferenciales.

![[Pasted image 20231024045701.png]]
![[Pasted image 20231024045717.png]]
![[Pasted image 20231024045732.png]]
![[Pasted image 20231024045826.png]]
![[Pasted image 20231024045850.png]]
![[Pasted image 20231024045910.png]]
![[Pasted image 20231024050256.png]]
![[Pasted image 20231024050309.png]]
![[Pasted image 20231024050323.png]]
![[Pasted image 20231024050336.png]]
![[Pasted image 20231024050349.png]]
![[Pasted image 20231024050403.png]]
![[Pasted image 20231024050418.png]]
![[Pasted image 20231024050429.png]]
![[Pasted image 20231024051201.png]]
![[Pasted image 20231024051226.png]]
![[Pasted image 20231024051452.png]]

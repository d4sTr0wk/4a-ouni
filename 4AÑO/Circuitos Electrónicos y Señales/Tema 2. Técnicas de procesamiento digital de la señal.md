## Índice
1. [[]]
----
## Objetivos
Conocer unas herramientas para analizar digitalmente señales. Una parte basado en el análisis de la señal en el tiempo (cálculo de medias, aplicación de ventanas de integración, comparaciones con umbrales de amplitud) y la otra parte se basa en analizar la frecuencia de la señal, se obtiene el espectro de frecuencia con la <mark style="background: #FFF3A3A6;">Transformada Rápida de Fourier</mark>  (FFT), y se aplican unos criterios/algoritmos.

Estas herramientas en resumen son:
- Muestreo
- Transformada Z
- Transformada de Fourier
- Filtros digitales
- Diagramas de polos y ceros
- Técnicas de 'enventanado'
- Técnica del "Zero Padding"
- Filtrado adaptativo
## Muestreo
Para aplicar herramientas de procesamiento digital primero hay que digitalizar la señal.

Para que tenga la calidad suficiente el criterio de <u>Nyquist</u> nos dice que hay que muestrear mínimo al doble de la frecuencia máxima.

Se crean armónicos entre $f_s$/2 y $f_s$ que actúan como un “espejo” de las frecuencias originales situadas entre 0 y $f_s$/2, y se repite todo el espectro cada $f_s$ Hercios (Hz).

Si el ancho de banda de $f_c$ es mayor que $f_s/2$ se produce <mark style="background: #FFF3A3A6;">"<u>aliasing</u>"</mark>, se superponen el espectro original y el "espejo".

![[Pasted image 20231024055323.png]]

También se debe escoger la cuantificación para las muestras, el número de bits para codificar los niveles de tensión, así como el mínimo y el máximo a registrar para la conversión analógico/digital.

La relación señal/ruido (SNR = Signal to Noise Ratio) para calcular los bits necesarios expresado en decibelios (dB) y será $20*log_{10}2^{bits}$ . Cada vez que usamos 1 bit más de precisión se dobla la resolución y mejora la SNR en 6 dB.

![[Pasted image 20231024055933.png]]

El <u>error de cuantificación (η)</u> tendrá un orden que estará situado entre –q/2 y q/2, siendo q la amplitud que hay entre 2 niveles consecutivos según el número de bits escogidos. Si tenemos más bits de resolución el intervalo ‘q’ se hace más pequeño, dado que se aproximan los niveles al cuantificar (son más “finos”), por lo que el error se reduce.

## Transformada Z

Resuelve ecuaciones de recurrencia transformándolas al dominio de la variable $Z$ y eliminando la recurrencia (sin recursividad).  

![[Pasted image 20231024060337.png]]

La **región de convergencia (ROC)** es el conjunto de valores para los que la serie converge, es decir: $F(z) = f[0] + f[1]z^{-1} + f[2]z^{-2} + ... = \sum_{n=0}^{\infty} f[n]z^{-1} < \infty$

![[Pasted image 20231024060717.png]]

16/62 EJEMPLO

- <u>Teorema del desplazamiento</u>: Si obtenemos una secuencia desplazada, la relación entre sus transformadas es la siguiente:

![[Pasted image 20231024060908.png]]
![[Pasted image 20231024060935.png]]
![[Pasted image 20231024061003.png]]

- <u>Inversión de transformadas Z</u>: para la inversa de una transformada Z aplicamos las propiedades vistas.

![[Pasted image 20231024061215.png]]
![[Pasted image 20231024061315.png]]
![[Pasted image 20231024061345.png]]
![[Pasted image 20231024061426.png]]
![[Pasted image 20231024061454.png]]


22/62 EJEMPLO

- <u>Ecuaciones de recurrencia</u>: una ecuación lineal con coeficientes constantes es una ecuación de la forma:
  $𝑦[𝑛] + 𝑎_1𝑦[𝑛 − 1] + ⋯ + 𝑎_𝑚𝑦[𝑛 − 𝑚] = 𝑏_0𝑥[𝑛] + ⋯ + 𝑏_𝑚𝑥[𝑛 − m]$

Para la recurrencia es necesario unas condiciones iniciales, unos <mark style="background: #FFF3A3A6;">valores de y[n] para instantes anteriores</mark>
$y[-1]=y_{-1}$
$y[-1] = y_{-2}$
...
$y[-m] = y_{-m}$

![[Pasted image 20231024061944.png]]

- <u>Ecuación o función de sistema</u>: es la ecuación que define el comportamiento de una ecuación de recurrencia expresada en el dominio de Z:
$H(z) = \frac{Y(z)}{X(z)}$

- Si usamos la entrada $x[n] = \delta[n]$ podemos calcular la transformada Z inversa de H(z) y se obtiene h[n], **respuesta impulsional del sistema**
 ![[Pasted image 20231024062329.png]]
 - Si usamos $x[n] = u[n]$ (secuencia escalón), podemos calcular la transformada Z inversa de Y(z) y se obtiene y[n], **respuesta al escalón**:
![[Pasted image 20231024062526.png]]


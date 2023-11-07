## Índice
1. [[Introducción]]

## Introducción

**Principio de localidad**: los programas no acceden a todo el código o a todos los datos uniformemente. 
- **Localidad temporal.** Si se referencia un elemento, tenderá a ser referenciado pronto.
- **Localidad espacial.** Si se referencia un elemento, los elementos cercanos a él tenderán a ser referenciados pronto.
Una <mark style="background: #FFF3A3A6;">jerarquía de memoria</mark> está organizada en niveles, los más pequeños y rápidos son más caros por byte. Los niveles de la jerarquía están contenidos en el siguiente nivel, todos los datos de un nivel se encuentran también en el siguiente. Aprovechando el principio de localidad se puede mejorar el rendimiento. 

## Principios generales de jerarquía de memoria

En una jerarquía de memoria hay un <mark style="background: #FFF3A3A6;">nivel superior</mark> (más cercano al procesador) y un <mark style="background: #FFF3A3A6;">nivel inferior.</mark> 

La mínima unidad de información presente o no en un nivel de memoria se denomina **bloque**. El tamaño de este puede ser fijo o variable. Si fuese fijo, el tamaño de la memoria sería un múltiplo del tamaño del bloque. 

Un **acierto** o hit es un acceso a memoria que se encuentra en el nivel superior, mientras que un **fallo** o miss significa que no se encuentra en ese nivel. La **frecuencia o tasa de aciertos** es el porcentaje de accesos con éxito el nivel de memoria. La **frecuencia de fallos** es la de accesos a memoria no encontrados en el nivel ($1,0 - frecuencia_{aciertos}$).

**Tiempo de acierto** es lo que tarda en acceder al nivel de memoria, incluyendo el tiempo para determinar si el acceso es un acierto o un fallo. **Penalización de fallo** es el tiempo que se tarda en sustituir un bloque del nivel superior por el bloque correspondiente más abajo, sumado al tiempo en proporcionar el bloque al dispositivo que lo pidió. Son dos tiempos lo que lo componen:
- **Tiempo de acceso.** Lo que tarda en determinar que es un fallo.
- **Tiempo de transferencia.** Lo que tarda en transferir las palabras de bloque.
El tiempo de acceso se relaciona con la latencia del nivel más bajo en memoria y el tiempo de transferencia con el ancho de banda entre las memorias del nivel superior e inferior.

La dirección de memoria está dividido en dos piezas:
- **Dirección de la estructura del bloque.** Orden superior de la dirección que identifica un bloque en el nivel de la jerarquía.
- **Dirección del desplazamiento del bloque.** Orden superior de la dirección que identifica un elemento en un bloque. El tamaño de esta parte es $log_2(tam_{bloque}$).
### Evaluación del rendimiento de una jerarquía de memoria

Una buena medida de rendimiento en comparación con el número de instrucciones o la tasa de fallos de la jerarquía de memoria es el tiempo medio para acceder a memoria.

$AMAT = \text{Tiempo de acceso a memoria} = \text{Tiempo de acierto} + \text{Frecuencia de fallos} \times \text{Penalización de fallo}$
Se puede medir el *AMAT* en tiempo absoluto (10 nanosegundos por ejemplo) o en ciclos de reloj. 

El *AMAT* sigue siendo una medida temporal indirecta, así que aunque sea mejor que la tasa de fallos, sigue NO SIENDO un sustituto para el tiempo de ejecución. 

![[Pasted image 20231026195508.png]]
![[Pasted image 20231026195522.png]]

El objetivo de una jerarquía de memoria es reducir el tiempo de ejecución, no los fallos. Aumentar el tamaño de bloque puede aumentar gradualmente la penalización de fallos, puesto que aumentaría el tiempo de transferencia. Sin embargo reduciría considerablemente la frecuencia de fallos, aunque llegado a un punto, el aumentar mucho el tamaño de bloque puede ser perjudicial puesto que se reduce el número de bloques en memoria. Se prefiere un *AMAT* menor mejor a una frecuencia de fallos menor. El rendimiento global de la CPU es el último test de rendimiento igualmente. 

### Implicaciones de una jerarquía de memoria  a la CPU

Cualquier acceso a memoria puede producir una interrupción de la CPU. Si un tratamiento de fallo provoca decenas de ciclos de reloj no pasa nada, pero, ¿y si son miles de ciclos de reloj? La CPU quedaría inactiva durante mucho tiempo, sin hacer nada mientras que se realiza el acierto y se transfieren los bloques que se solicitan. Por esto se implementan interrupciones, para que la CPU pueda proseguir trabajando con otros procesos. Cuando se completa la transferencia, se restaura el proceso original y se reintenta la instrucción que falló. 

El procesador tiene mecanismos para determinar si la información se encuentra en el nivel. Mantener un rendimiento óptimo se traduce en que habitualmente la comprobación se implemente en hardware. La implicación final es cuando se transfieren bloques. Si la transferencia es de decenas de ciclos de reloj, se controla por hardware; si es de miles, se puede controlar por software.

### Definiciones interesantes de las jerarquías de memoria

1. ¿Dónde puede ubicarse un bloque en el nivel superior? **Ubicación de bloque.**
2. ¿Cómo se encuentra un bloque si está en el nivel superior? **Identificación de bloque**.
3. ¿Qué bloque debe reemplazarse en caso de fallo? **Sustitución de bloque.**
4. ¿Qué ocurre en una escritura? **Estrategia de escritura.**

## Cachés

Es el nivel de jerarquía de memoria entre CPU y memoria principal.

![[Pasted image 20231026195414.png]]

### *¿Dónde puede ubicarse un bloque de la caché?*

Las restricciones sobre la ubicación de un bloque crean tres categorías de organización caché:

- **Direct mapped (correspondencia directa).**  Cada bloque tiene únicamente un lugar donde aparecer en caché. (dirección de la estructura de bloque) módulo (número de bloques de la caché)
- **Totalmente asociativa.** Un bloque se puede colocar en cualquier parte de la caché.
- **Asociativa por conjuntos.** Un bloque se coloca en un *conjunto* restringido de lugares. Un *conjunto* es un grupo de dos o más bloques. El conjunto se escoge por (dirección de la estructura de bloque) módulo (número de conjuntos en la caché). Si hay *n* bloques en un conjunto, la ubicación se dice **asociativa por conjuntos en n vías (asociatividad n)**.

![[Pasted image 20231027083204.png]]

### **¿Cómo se encuentra un bloque si está en la caché?**

Las cachés incluyen etiquetas de dirección que identifican la dirección de la estructura del bloque. Dependiendo de las características de la caché la búsqueda será distinta. 

![[Pasted image 20231027083542.png]]

**Bit de validez**. Se le añade un bit a la etiqueta para indicar si la entrada contiene, o no, una dirección válida.

![[Pasted image 20231027084134.png]]

- El índice es redundante comprobarlo puesto que se usó para seleccionar el conjunto (una dirección en el conjunto 0 debe de tener 0 en el campo de índice). **<mark style="background: #FFF3A3A6;">?????????</mark>**
- El desplazamiento es innecesario en la comparación.

Si el tamaño total se mantiene igual, incrementando la asociatividad, se aumenta el número de bloques por conjunto, disminuyendo así el tamaño del índice e incrementando el tamaño de la etiqueta.

### **¿Qué bloque debe reemplazarse en un fallo de la caché?**

La frecuencia elevada de aciertos en la caché hace que en la mayoría de casos el reemplazo de datos sea entre datos válidos.

Con la ubicación de correspondencia directa las decisiones se simplifican. Solo hay una opción posible para cada bloque. Para la asociativa o asociativa por conjuntos hay varios bloques a elegir cuando hay un fallo, y se siguen dos estrategias para elegir el bloque a reemplazar:

- *Aleatoria.*
- *LRU o menos recientemente usado.* Para elegir los bloques candidatos a ser reemplazados se lleva un registro de accesos a bloques, y los que llevan más tiempo sin ser utilizados son los reemplazados. Esto ayuda a reducir la probabilidad de desechar información que será necesitada posteriormente. <mark style="background: #FFF3A3A6;">(localidad temporal)</mark>

![[Pasted image 20231027165312.png]]

La estrategia aleatoria es sencilla de construir en hardware. Cuando aumentan los bloques a gestionar, la estrategia LRU se encarece. La política de reemplazo cobra un papel importante en cachés pequeñas más que en las más grandes donde hay más opciones para sustituir.

### ¿Qué ocurre en una escritura?

El **caso común rápido** significa optimizar las cachés para las lecturas. El bloque se puede leer al mismo tiempo que se lee la etiqueta. Así si es un acierto, el bloque pasa a la CPU; si es un fallo, no hay beneficio ni perjuicio.

Esto no pasa en las escrituras. Con las escrituras se lleva a cabo una serie de operaciones de lectura->modificación->escritura en el bloque. Como la comprobación de la etiqueta no puede hacerse en paralelo con la escritura, las escrituras duran más que las lecturas generalmente.

Hay dos opciones para escribir en la caché:

- **Escritura directa o almacenamiento directo (Write through o store through).** La información se escribe en el bloque de la caché y en el de la memoria de nivel inferior.
- **Postescritura (Write back, copy back o store in).** La información se escribe sólo en la caché. Cuando es reemplazado es cuando se escribe en la memoria principal.
*Limpio o modificado* hace referencia a que la información de caché difiera de la memoria de nivel inferior. El *bit de modificación (dirty bit)* sirve para indicar si el bloque fue modificado o no en la caché.

Con la postescritura las escrituras se hacen a velocidad caché, y múltiples escrituras en un bloque sólo representan una escritura en memoria de nivel inferior <mark style="background: #BBFABBA6;">(útil en multiprocesadores).</mark>
La escritura directa es más fácil de implementar en hardware. La memoria principal tiene la copia más reciente de los datos. 

En resumen, los multiprocesadores quieren postescritura para reducir el tráfico de memoria (baja el ancho de banda de memoria) y escritura directa para mantener la caché y memoria consistentes.

La CPU se detiene en las escrituras con la escritura directa mientras espera que termine cada una de las escrituras que realiza. Para optimizarlo se usa un **buffer de escritura** para que la CPU prosiga mientras se actualiza la memoria. 

Hay dos opciones en un fallo de escritura:

- **Ubicar en escritura o búsqueda en escritura.** El bloque que se carga, seguido de las acciones anteriores de acierto de escritura.
- **No ubicar en escritura o evitar escritura.** El bloque se modifica en un nivel inferior y no se carga en la caché. 

### Rendimiento de la caché

El tiempo de CPU se puede dividir en los ciclos que la CPU emplea en ejecutar un programa y en los ciclos que emplea en esperar al sistema de memoria.

$\text{Tiempos de CPU} = \text{(Ciclos de reloj de ejecución CPU)} + \text{Ciclos de reloj de detención-memoria)} \times \text{Duración ciclo de reloj}$
$\text{Ciclos de reloj de detención de memoria} = \frac {\text{Lecturas}}{\text{Programa}} \times \text{Frecuencia fallos lectura} \times \text{Penalización de fallos de lectura} + \frac{\text{Escrituras}}{\text{Programa}}$
$\text{Ciclos de reloj de detención de memoria} = \frac {\text{Acceso a memoria}}{\text{Programa}} \times \text{Frecuencia fallos lectura} \times \text{Penalización de fallos de lectura}$


*En este bloque usaremos las transparencias:*
[Texto](file:\\\C:\Users\Máximo\Desktop\obsidian_srcs\Bloque-tematico-1.pdf)

# Índice:
- [Tema I: Organización de la E/S](#tema1)
- [Tema II: Análisis y evolución del bus PCI](#tema2)

# Tema I: Organización de la E/S
#tema1

![[Pasted image 20231018015431.png|700]]
![[Pasted image 20231018020306.png|700]]

## Estructura de la E/S

![[Estructura de E-S.png|700]]

La interfase suele estar integrada en el periférico, pero puede ser un dispositivo independiente.

El **Driver** del dispositivo es el software que gestiona y controla la transferencia de datos y se ejecuta en el sistema procesador.

La dirección de las transferencias con referencia al sistema procesador:
- Lectura (Read): los datos provienen del periférico y entran al sistema procesador.
- Escritura (Write): los datos provienen del sistema procesador y van al periférico.

![[Registros interfase.png|700]]

Los **registros de control** permiten el control indirecto del hardware escribiendo valores en ellos.

Los **registros de estado** aportan información actual del periférico.

Los **registros de entrada de datos** albergan temporalmente los datos entregados desde el periférico para el sistema procesador (un único registro o un buffer RAM).

Los **registros de salida de datos** albergan temporalmente los datos enviados hacia el periférico (un único registro o un buffer RAM).

## Interfase y modelo de programación del periférico

- Registros de interfase
- Organización y estructura
- Conjunto de comandos y parámetros que acepta
- Temporización y condiciones de error

El modelo de programación permite desacoplar el hardware y no cambiar su comportamiento lógico, así se puede cambiar el hardware sin alterar su función. Lo único a comprobar es la conservación de la compatibilidad.

## Direccionamiento de la interfase

Para realizar una transferencia desde el sistema computador hay que saber qué periférico está involucrado y el registro origen o destino.

**Direccionamiento** es el mecanismo que permite identificar estas cosas.

Este mecanismo requiere la combinación de otros mecanismos hardware:
- Asignación de valor  a la línea de bus de direcciones.
- Uso de línea de activación selectiva de la interfase (Chip Select, CS),
- Decodificación del valor en el bus de direcciones lo que provoca la activación de una interfase y un cierto registro de ésta.

![[Estructura E-S.png|700]]

![[Direccionamiento local.png|700]]

![[Ejemplo E-S mapeada por memoria.png|700]]

Las direcciones de E/S están mezcladas con las de memoria por lo que la CPU usará la misma instrucción para acceder a una posición de ambas. Este tipo de direccionamiento se llama **E/S mapeada por memoria**.

Este tipo de direccionamiento tiene una serie de <mark style="background: #FFF3A3A6;">ventajas</mark>:
- Registro E/S se ve como posición "especial" de memoria.
- CPU no necesita instrucciones especiales para acceder a E/S.

También trae <mark style="background: #FFF3A3A6;">inconvenientes</mark>:
- Fragmenta el espacio de direcciones.
- Errores de programación puede direccionar accidentalmente posiciones de E/S y provocar daños físicos. 

Una *alternativa* a este direccionamiento es la **E/S diferenciada:**
- Espacio de direcciones separado para la E/S.
- Usa línea física para identificar accesos al espacio de E/S.
- Por ende necesita instrucción especial (IN o OUT).

![[E-S diferenciada.png|700]]

![[Estructura E-S diferenciada.png|700]]

Las <mark style="background: #FFF3A3A6;">ventajas:</mark>
- Separa totalmente los accesos a E/S con los de memoria.
- Evita fragmentación del espacio de direcciones de memoria.

Los <mark style="background: #FFF3A3A6;">inconvenientes:</mark>
- Requiere instrucciones especiales (las cuales sólo existen en algunos procesadores INTEL y el direccionamiento es limitado a 16 bits = 65536 direcciones).
- Accesos más lentos que en E/S mapeada por memoria.

```
Las computadoras actuales usan un modelo mixto de direccionamiento.

Se usan puertos de E/S para acceder a registros críticos o dispositivos "legacy". Luego se usa E/S mapeada por memoria para accesos veloces y también para direccionar funciones que requieren muchos registros.
```


## Métodos de E/S: PIO y DMA

Hay dos formas de realizar las transferencias de E/S: PIO y DMA.

- **E/S por programa (PIO = Program I/O):** La CPU está involucrada en cada transferencia (registro CPU intermediario entre memoria y periférico).

- **E/S por DMA (Direct Memory Access):**  No requiere explícitamente a la CPU para la transferencia. Emplea *hardware especial* para controlar la transferencia.

## E/S por programa (PIO)

![[Diagrama transacción de lectura.png|700]]


<mark style="background: #FFF3A3A6;">Ventajas:</mark>
- No requiere hardware especial
- Sencilla de implementar

<mark style="background: #FFF3A3A6;">Inconvenientes:</mark>
- Requiere el uso continuo de CPU para las transferencias. Estos movimientos de bloques ralentizan el sistema.

Se suele usar para transferencias puntuales que involucran poco datos.

## Consulta de estado

Antes de realizar la transferencia se debe comprobar si el periférico está preparado (protocolo *handshaking*).

La **consulta de estado** se basa en el acceso a registros de la interfase (estado o control) para realizar el *handshaking*.

![[Esquema handshaking.png|700]]

Consulta de estado mediante:
- **Bloqueo de programa:** bucle de espera hasta que el periférico esté preparado. El tiempo de respuesta es mínimo pero paraliza la operación del sistema.
- **Consulta periódica:** si no estuviese listo el periférico el driver permite al programa seguir haciendo otras cosas antes de volver a intentar el acceso. El tiempo ya no está asegurado para que sea mínimo y puede ser difícil acotar el tiempo máximo de respuesta pero permite al sistema operar concurrentemente con la E/S.

## Ejemplo de E/S por PIO

- **DAV (Dato válido):** la interfase le indica al periférico el envío de dato. Activa hasta recibir DAC.
- **DAC (Dato Aceptado):** el periférico indica que ha aceptado el dato.
- **RTR (Ready To Receive):** La interfase activa esta señal para indicar al periférico disponibilidad para recibir un dato.
- **DENV (Dato Enviado):** el periférico indica a la interfase que le está enviando un dato.

Dos ejemplos de lectura y escritura de datos :

![[Lectura de datos.png|700]]

![[Escritura de datos.png|700]]

## Interrupciones

Las **interrupciones hardware** permiten a la interfase crear un evento que provoque la respuesta de la CPU, eliminando la indeterminación en la temporización de la E/S.

Para haber interrupción se necesita una línea hardware que conecte la CPU con la interfase puesto que son dispositivos hardware distintos.

La **rutina de servicio de interrupción** gestiona la operación de E/S.

![[Estructura con interrupción.png|700]]

![[Servicio de una interrupción.png|700]]

La interrupción se atiende al finalizar la instrucción que está en ejecución cuando se detecta la activación de INT.

Sin embargo este esquema no funcionaría porque si se termina la ejecución de la rutina de servicio y la señal INT sigue a 1 se provocará otra interrupción que es incorrecta. A esto es le llama **interrupción autointerrumpida.**

Las **interrupciones autointerrumpidas** provocan **serios problemas hardware**. La interfase es accedida dos veces consecutivas cuando solo se espera una vez provocando fallas y bloqueos físicos del sistema (Pantallazo azul de la muerte BOSD en Windows, Kernel panic en Linux).

Para evitarlo hay dos formas:
- Usar como señalización de INT los flancos de subida o bajada.
- Usar enmascaramiento de interrupciones: se bloquea nueva interrupción hasta que termine la actual.
![[Enmascaramiento interrupcion.png|700]]

## Vector de interrupción

Las interrupciones provocan la ejecución de una rutina de servicio. El **vector de interrupción** es el mecanismo que enlaza el origen de la interrupción con la rutina de servicio. Es un valor entero de 8 bits que actúa como identificador del origen de la interrupción. Proporciona un puntero al inicio de la rutina de servicio a través de una o más tablas de vectores de interrupción.

En interrupciones generadas desde software, el vector se genera automáticamente. Para el resto de interrupciones, el vector de interrupciones debe ser entregado por el hardware que produce la interrupción.

![[Secuencia eventos en interrupcion.png|700]]

1. Activación línea INT.
2. Procesamiento de interrupción, CPU activa línea de reconocimiento de interrupción INTA.
3. Dispositivo externo deposita en el bus de datos el valor del vector de interrupción.
4. Con este puntero la CPU continúa el procesamiento de la interrupción ejecutando al rutina de servicio correspondiente.

## Gestión de orígenes múltiples: polling

Si múltiples periféricos pueden generar interrupciones, deben compartir la línea INT. Por esto se necesita un mecanismo de identificación del origen de la interrupción. El mecanismo más sencillo para esto es el **polling**.

1. La activación INT hace que la CPU entre en *rutina de servicio genérica*.
2. Esta rutina genérica comprueba los registros estado de las interfaces de los periféricos para encontrar el que tiene la interrupción pendiente.
3. Rutina usa el vector establecido por software para ese periférico.

![[Polling.png]]

<mark style="background: #FFF3A3A6;">Ventajas:</mark>
- No requiere hardware especial.
- La prioridad de periféricos se cambia fácilmente alterando el orden del muestreo.

<mark style="background: #FFF3A3A6;">Inconvenientes:</mark>
- Es lento para el último dispositivo muestreado.

El **polling** suele ser usado en sistemas sencillos con un único vector de interrupciones (microcontroladores).
Esta figura muestra el mapa del espacio de direcciones de un microcontrolador con un único vector de interrupciones en 0004h, dirección que apunta a rutina común de servicio y donde es necesario el polling para identificar el origen de la interrupción:

![[Polling example.png|450]]

## Controlador de interrupciones

Es un circuito especializado que aplica como gestor de orígenes múltiples de interrupciones. Es el intermediario entre los periféricos y la CPU. El controlador:
- Prioriza las peticiones y determina si se atienden o no.
- Activa la señal de interrupción INT que va a la CPU.
- Entrega a ésta el vector de interrupción asociado al periférico.
![[Controlador de interrupciones esquema.png]]

El controlador no es más que una interfase por lo que tiene registros y un modelo de programación. Estos registros permiten:
- Enmascarar interrupciones individuales.
- Evitar interrupciones autointerrumpidas (sólo se atienden a otras interrupciones si son más prioritarias que la que se está ejecutando).
- Determinar el rango de posibles vectores de interrupción.

![[Ejemplo controlador de interrupciones.png]]

## MSI (Message Signaled Interrupts)

Una especificación del estándar del bus PC introdujo una nueva forma de señalizar la necesidad de una interrupción sin el requerimiento de la activación de las líneas de interrupción del procesador:  El MSI = Interrupciones señalizadas por mensaje.

La interrupción MSI **no emplea la línea de petición INT**.

Se señaliza desde el controlador de interrupciones realizando una operación de escritura en una dirección de memoria especificada. Por esto...

```` 
MSI es un caso especial de E/S mapeada por memoria
````

Al ser una escritura en memoria, el mensaje es transmitido a través del bus de datos. Este mensaje es interceptado por el <mark style="background: #FFF3A3A6;">controlador de interrupciones local del procesador (APIC)</mark>.

La dirección donde hay que escribir se obtiene de un registro en la interfase del controlador de interrupciones

La interfase de la CPU ofrece un registro llamado Message Data Register en esa dirección obtenida del controlador de interrupciones en el cual con la simple operación de escritura se carga en el registro todos los parámetros de la petición de interrupción.

MSI simplifica el diseño de multiprocesadores ya que el mismo bus de transacciones CPU - Memoria se usa para las peticiones de interrupción. La sincronización con la operación de interrupción es mucho más fácil.

MSI simplifica también el diseño e interfaz de los chipsets. La interrupción se enruta por los integrados del chipset (Puente norte y sur) por donde se pasan también los datos. Esto quita la necesidad de poner líneas de activación de interrupciones por la placa madre.

Todos los ordenadores modernos señalizan sus interrupciones usando solamente MSI.

## Servicio diferido de interrupciones

La complejidad de los procesadores hace obligatorio deshabilitar las interrupciones durante la rutina de servicio, un problema para las rutinas largas.

Se soluciona si se divide el procesamiento de la interrupción en dos partes.

![[Servicio diferido de interrupciones.png]]

## E/S por DMA

PIO enlentece el ordenador porque involucra la CPU en cada movimiento de datos.

La E/S por DMA transfiere los datos sin necesidad de usar la CPU:
- Requiere el uso de hardware especial (controlador DMA) para que realice los direccionamientos (asignaciones a la línea de bus de direcciones y de control).
	- El controlador DMA **NO mueve los datos**; sólo controla el movimiento.

![[Arquitectura DMA tradicional.png]]

El controlador DMA solo da valores a líneas del bus de direcciones y a algunas líneas de control.

Si se da una transferencia, DMA usa bus de direcciones y bus de datos, entonces la CPU no puede emplearlos durante la transferencia porque supondría un conflicto.
- La CPU se desconecta físicamente. 

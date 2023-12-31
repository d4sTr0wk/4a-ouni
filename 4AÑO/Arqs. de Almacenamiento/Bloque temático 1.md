# Índice:
- [Tema I: Organización de la E/S](#tema1)
- [Tema II: Análisis y evolución del bus PCI](#tema2)

# Tema I: Organización de la E/S
#tema1
## I - Estructura de la E/S

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

### Interfase y modelo de programación del periférico

- Registros de interfase
- Organización y estructura
- Conjunto de comandos y parámetros que acepta
- Temporización y condiciones de error

El modelo de programación permite desacoplar el hardware y no cambiar su comportamiento lógico, así se puede cambiar el hardware sin alterar su función. Lo único a comprobar es la conservación de la compatibilidad.

### Direccionamiento de la interfase

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


### Métodos de E/S: PIO y DMA

Hay dos formas de realizar las transferencias de E/S: PIO y DMA.

- **E/S por programa (PIO = Program I/O):** La CPU está involucrada en cada transferencia (registro CPU intermediario entre memoria y periférico).

- **E/S por DMA (Direct Memory Access):**  No requiere explícitamente a la CPU para la transferencia. Emplea *hardware especial* para controlar la transferencia.

### E/S por programa (PIO)

![[Diagrama transacción de lectura.png|700]]


<mark style="background: #FFF3A3A6;">Ventajas:</mark>
- No requiere hardware especial
- Sencilla de implementar

<mark style="background: #FFF3A3A6;">Inconvenientes:</mark>
- Requiere el uso continuo de CPU para las transferencias. Estos movimientos de bloques ralentizan el sistema.

Se suele usar para transferencias puntuales que involucran poco datos.

### Consulta de estado

Antes de realizar la transferencia se debe comprobar si el periférico está preparado (protocolo *handshaking*).

La **consulta de estado** se basa en el acceso a registros de la interfase (estado o control) para realizar el *handshaking*.

![[Esquema handshaking.png|700]]

Consulta de estado mediante:
- **Bloqueo de programa:** bucle de espera hasta que el periférico esté preparado. El tiempo de respuesta es mínimo pero paraliza la operación del sistema.
- **Consulta periódica:** si no estuviese listo el periférico el driver permite al programa seguir haciendo otras cosas antes de volver a intentar el acceso. El tiempo ya no está asegurado para que sea mínimo y puede ser difícil acotar el tiempo máximo de respuesta pero permite al sistema operar concurrentemente con la E/S.

### Ejemplo de E/S por PIO

- **DAV (Dato válido):** la interfase le indica al periférico el envío de dato. Activa hasta recibir DAC.
- **DAC (Dato Aceptado):** el periférico indica que ha aceptado el dato.
- **RTR (Ready To Receive):** La interfase activa esta señal para indicar al periférico disponibilidad para recibir un dato.
- **DENV (Dato Enviado):** el periférico indica a la interfase que le está enviando un dato.

Dos ejemplos de lectura y escritura de datos :

![[Lectura de datos.png|700]]

![[Escritura de datos.png|700]]

### Interrupciones

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

### Vector de interrupción

Las interrupciones provocan la ejecución de una rutina de servicio. El **vector de interrupción** es el mecanismo que enlaza el origen de la interrupción con la rutina de servicio. Es un valor entero de 8 bits que actúa como identificador del origen de la interrupción. Proporciona un puntero al inicio de la rutina de servicio a través de una o más tablas de vectores de interrupción.

En interrupciones generadas desde software, el vector se genera automáticamente. Para el resto de interrupciones, el vector de interrupciones debe ser entregado por el hardware que produce la interrupción.

![[Secuencia eventos en interrupcion.png|700]]

1. Activación línea INT.
2. Procesamiento de interrupción, CPU activa línea de reconocimiento de interrupción INTA.
3. Dispositivo externo deposita en el bus de datos el valor del vector de interrupción.
4. Con este puntero la CPU continúa el procesamiento de la interrupción ejecutando al rutina de servicio correspondiente.

### Gestión de orígenes múltiples: polling

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

### Controlador de interrupciones

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

### MSI (Message Signaled Interrupts)

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

### Servicio diferido de interrupciones

La complejidad de los procesadores hace obligatorio deshabilitar las interrupciones durante la rutina de servicio, un problema para las rutinas largas.

Se soluciona si se divide el procesamiento de la interrupción en dos partes.

![[Servicio diferido de interrupciones.png]]

### E/S por DMA

PIO enlentece el ordenador porque involucra la CPU en cada movimiento de datos.

La E/S por DMA transfiere los datos sin necesidad de usar la CPU:
- Requiere el uso de hardware especial (controlador DMA) para que realice los direccionamientos (asignaciones a la línea de bus de direcciones y de control).
	- El controlador DMA **NO mueve los datos**; sólo controla el movimiento.

![[Arquitectura DMA tradicional.png]]

El controlador DMA solo da valores a líneas del bus de direcciones y a algunas líneas de control.

Si se da una transferencia, DMA usa bus de direcciones y bus de datos, entonces la CPU no puede emplearlos durante la transferencia porque supondría un conflicto.
- La CPU se desconecta físicamente. 
- No puede leer instrucciones desde memoria.
- Necesario parar CPU durante la transferencia.

Como se para e procesador esto implica que el bloque no puede ser muy largo. Sin embargo, el movimiento del bloque es más rápido que en PIO porque cada transferencia individual se hace más rápido.
![[Arquitectura DMA.png]]

La CPU programa la transferencia cargando en registros del controlador DMA la dirección de inicio de transferencia y el número de datos a mover (dirección final).

### Control de acceso al bus: Arbitración

En un mismo ordenador habrá varios dispositivos que le den datos al bus de direcciones y líneas de control:
- Al menos una CPU.
- Varios controladores DMA.

Arbitración de bus es el mecanismo de coordinación que determina en cada transferencia cual es el dispositivo que tomará el control de los buses.

#### Arbitración paralela centralizada

Usa un **árbitro de bus** que selecciona qué dispositivo toma el control del bus. Usa para cada posible controlador una pareja independiente de líneas:
- BR = Bus Request
- BG = Bus Grant (cesión)

<mark style="background: #FFF3A3A6;">Ventajas:</mark>
- Sencillo de implementar.
- Distintos algoritmos para controlar prioridad.
- No usa el bus de datos para arbitrar.
<mark style="background: #FFF3A3A6;">Inconvenientes:</mark>
- Requiere el circuito árbitro de bus en la placa madre.
- Enrutar líneas de petición y cesión.

![[Arbitración centralizada.png]]
#### Arbitración distribuida con autoselección

Cada dispositivo tiene su propia circuitería de control de arbitración.

![[Arbitración distribuida con autoselección.png]]

Al inicio de la arbitración el dispositivo que quiera usar el bus pone a 1 la línea que se corresponde con su ID. Si un dispositivo más prioritario solicita el control, los de menos prioridad deben retirar su solicitudes y poner a 0 sus líneas. Quien gana el control pone a 1 BBSY = Bus Busy.

<mark style="background: #FFF3A3A6;">Ventajas:</mark>
- Reduce el total de líneas (no hay BR, BG).
- Más fácil sincronizar entre dispositivos de diferentes velocidades.
<mark style="background: #FFF3A3A6;">Inconvenientes:</mark>
- La función de control es más compleja que en arbitración centralizada.
- Necesita usar el bus de datos durante la arbitración, por lo que **las arbitraciones no pueden ser frecuentes o producirá una ineficiencia en el bus de datos.**

### DMA con E/S por buffer (Buffered I/O)

En buffered I/O, las transferencias DMA requieren paso de datos a través de una zona intermedia de memoria (buffer), gestionada por sistema operativo. Las operaciones de E/S con buffer requieren dos pasos:
- En escritura (Write):
	1. El SO copia datos de memoria de programa a buffer.
	2. Transferencia DMA mueve bloque de datos de buffer a periférico.
- En lectura (Read):
	1. Transferencia DMA mueve bloque de datos de periférico a buffer.
	2. SO copia datos de buffer a memoria de programa.

Propósito de buffer es dar a DMA bloque de direcciones contiguas para la transferencia. Permite que driver DMA sea más sencillo de implementar.

### DMA con E/S directa (Direct I/O)

En Direct I/O la transferencia se hace directamente entre memoria principal y periférico. No hay buffer intermedio y por esto es más rápida.

Por esto también requiere más sofisticación en controlador y driver DMA:
- Debe gestionar una única transferencia con bloques no contiguos de memoria (**scatter-gather**).
- Controlador DMA necesita una lista de direcciones inicio y longitudes de bloque.

### Implementación DMA en chipsets modernos

En ordenadores modernos no es necesario detener la CPU durante el acceso DMA a memoria. Los chipsets introducen un controlador de memoria intermediario entre DRAM y procesador llamado **Puente norte o North Bridge o Memory Controller Hub (MCH).** Este Puente norte proporciona buses diferenciados para accesos a CPU, memoria y E/S.

El Puente Norte desacopla el acceso a estos tres sitios y permite la operación concurrente de todos estos accesos.

Al ser el bus de acceso a memoria mucho más rápido que los otros permite la multiplexación en el tiempo. A efectos prácticos es como si existieran caminos paralelos simultáneos que permiten la concurrencia.

Ya no se necesita interferir en la operación de la CPU para realizar la transferencia DMA, importante en multiprocesadores.<mark style="background: #BBFABBA6;"> Los MCH también vigilan la coherencia entre caché y memoria principal.</mark>

![[Puente Norte.png|700]]

## II - Buses e interfaces

Es imprescindible aprender a diferenciar entre bus e interfaz. En el interfaz, el periférico tiene inteligencia para ejecutar comandos recibidos a través de un bus, y devolver por éste el resultado de dicha ejecución.

### Bus

Un bus es un subsistema que interconecta dos o más dispositivos por líneas comunes.
- La especificación de la señalización física y las líneas que unen subsistemas.
- La especificación del intercambio de datos por esas líneas, y los mecanismos que monitorizan que funcione correctamente.

**En la definición de un bus no se hace interpretación de los datos transferidos. La temporización, o protocolo de intercambio de señales, nos permite distinguir entre señales de control y de datos pero no se interpreta el contenido de estos.**

![[Interfaz.png|700]]

El periférico que usa interfaz puede procesar comandos. Su interfase tiene una unidad de control:
- Un microprocesador simple o microcontrolador avanzado.
- Un programa en ROM (firmware), con código que ejecutará para implementar comandos.

La unidad de control recibe la petición de ejecutar un comando a través del registro de comandos. Será un código de operación (codop). Estos son los pasos para cada operación:
1. El sistema procesador recibe en el registro de comandos el codop del comando.
2. La unidad de control identifica y ejecuta el comando.
3. La UC supervisa la ejecución por el hardware del periférico. Los datos a mover se intercambian con el sistema procesador a través del bus.
4. El periférico termina y devuelve por el bus códigos de estado/error.

La interfaz se caracteriza por:
- Involucra un periférico con capacidad de procesamiento de comandos.
- Requiere la interpretación de datos transferidos por bus.
- Siempre requiere un bus subyacente entre procesador y periférico.

````
Interfaz = Bus + "inteligencia" = Bus + procesamiento autónomo de comandos.
````

Esta figura muestra los datos que componen un comando, y sus parámetros.

![[Bus SCSI.png]]

**La misma secuencia de datos se puede transferir por otro tipo de bus y el comando SCSI será interpretado correctamente independientemente del bus usado porque la interpretación del comando reside en el interfaz SCSI.**

### Transacción de bus

**Secuencia de operaciones que componen una transferencia de datos completa.**

La dirección de la transacción usa el criterio <mark style="background: #FFF3A3A6;">"CPU céntrico:"</mark>
- Transacción de lectura: desde periférico hacia sistema procesador.
- Transacción de escritura: desde sistema procesador hacia periférico.

Las transacciones de bus tienen:
- Fase de direccionamiento (Dir): En el bus el dispositivo coloca el valor identificativo del dispositivo con quien hacer el intercambio de datos y el tipo de transacción.
- Fase de datos (D): Realización de transferencia.

![[Transacción de bus.png|700]]

### Maestro y esclavo de bus

Una transacción de bus involucra un maestro y un esclavo.
El **maestro de bus** es el dispositivo con capacidad de iniciar una transacción de bus:
- Direcciona al dispositivo objetivo, indicándole que actúe como esclavo.
- Señaliza qué tipo de transacción se va a realizar.
El **esclavo de bus** es el dispositivo que carece de la capacidad de iniciar transacciones de bus:
- Espera pasivamente a que sea direccionado.

**Durante una transacción solo puede haber un maestro de bus. El mecanismo de arbitración determinará qué maestro de bus se activará en cada transacción.**

Los controladores DMA y la CPU son maestros de bus.

### Relación entre transacción de bus e interfaz

Las transacciones de bus son realizadas por la capa encargada del transporte de los datos, no de su interpretación. Durante la fase de direccionamiento no se transfiere el comando a la interfaz. Los códigos de operación y parámetros se envían en fases de datos.

### Iniciador y diana

El **iniciador** es el dispositivo capaz de iniciar un comando a nivel de interfaz.

La **diana** es un dispositivo que carece de capacidad de iniciar autónomamente un comando a nivel de interfaz. Sólo puede esperar a que un iniciador le ordene ejecutar un comando y que devuelva el resultado.

No hay una correlación directa entre Iniciador - Maestro de bus y Diana - Esclavo de bus. Independientemente de su papel la diana siempre es pasiva.

En algunas terminologías se confunden estos dos conceptos distintos. En PCI-X se introdujo el <u>requester</u> como iniciador a nivel de interfaz y <u>completer</u> como diana.

### Transferencia en modo ráfaga

La transacción de bus está compuesta mínimamente de una fase de direccionamiento y una única fase de transferencia de datos. 

Las transacciones monofase de datos usan el bus ineficientemente:
- Las fases de direccionamiento son redundantes y no transportan carga útil. 
- Hay tiempos muertos entre transacciones.

![[Transferencia monofase.png|700]]

Para mejorar tiempos se usa **transferencias en modo ráfaga** (burst mode).

Hay una única fase de direccionamiento seguida de múltiples fases de datos consecutivas lo que elimina fases de direccionamiento adicionales y redundantes y los tiempos muertos intermedios.

![[Transferencia en modo ráfaga.png|700]]

La transferencia en modo ráfaga suele usarse entre buffers de memoria. Ambos dispositivos deben apuntar a la posición de buffer involucrada en el movimiento e ir incrementando por cada transferencia. El modo ráfaga es esencialmente una variante de DMA.

### Transacciones de bus bloqueantes: eficiencia

Las transacciones de bus son bloqueantes:
- Sólo existe una única transacción en curso.
- Una vez empezada una transacción, el bus queda bloqueado. Con el bus bloqueado aunque esté inactivo el bus por falta de datos, no se puede iniciar otra transacción.
La implementación bloqueante es sencilla pero presenta problemas de eficiencia, sobre todo con el modo ráfaga.

![[Latencias de acceso inicial a datos.png|700]]
1. <u>Latencias de acceso inicial a datos</u>
	- El origen de datos tarda en acceder a los datos a transferir y prepararlos en el buffer.
	- Durante la espera el bus está inactivo.

![[Latencias de procesamiento.png]]

2. <u>Latencias de procesamiento o acceso intermedio a datos</u>
	- Durante la transacción origen se queda sin datos en buffer y necesita leer físicamente más datos.
	- Durante la transacción destino necesita detener la transferencia para procesar y continuar.
	- En ambos casos aparece un tiempo muerto de espera.

![[Monopolización del bus.png]]

1. <u>Monopolización del bus</u>
	- Problema específico de transacciones bloqueantes con transferencias en modo ráfaga.
	- Una vez iniciada la transacción, ningún maestro de bus puede comenzar otra hasta que se transfiera el último dato de la ráfaga actual.

### Transacciones divididas ("*split transactions*")

Son la solución a los problemas de eficiencia descritos al usar transacciones bloqueantes es usar transacciones no bloqueantes.

Un bus soporta transacciones divididas o interrumpibles si la  transferencia puede ser:
- interrumpida para intercalar otras transacciones.
- continuada desde donde se dejó hasta terminar la transferencia.

<mark style="background: #FFF3A3A6;">Características:</mark>
- La interrupción ocurre entre la fase de DIR y la primera fase de D, o entre dos fases de D consecutivas.
- Necesita que maestro y esclavo mantengan información de estado sobre el momento de la interrupción y la dirección del próximo ítem de datos a transferir.
- La reanudación requiere una nueva fase de DIR donde maestro y esclavo reconozcan la continuación.
Las transacciones divididas **son muy importantes a nivel de interfaz:**
- Permiten intercalar la ejecución de múltiples comandos.
- Los conceptos son los mismos salvo cambiando "maestro de bus"  y "esclavo de bus" por "iniciador" y "diana".

![[Ejemplo transacciones divididas.png|700]]

<mark style="background: #FFF3A3A6;">Ventajas:</mark>
- Permiten aprovechar las latencias evitando así la inactividad del bus.
- Evitan la monopolización del bus, fragmentando las transferencias largas.
- Mejoran la concurrencia y reducen tiempos de respuesta.

<mark style="background: #FFF3A3A6;">Inconvenientes:</mark>
- El diseño es más complejo.
- Requiere unidades de control complejas en maestro y esclavo de bus
	- Esto no supone un problema en periféricos con interfaz hardware puesto que ya vienen con una UC compleja incorporada.

### Clasificación de los buses según su propósito

![[Bus local.png]]

<u>Bus CPU - Memoria (Bus local)</u>
Diseñado para interconectar CPU y memoria principal:
- Buses de alta velocidad, trabajando a la máxima frecuencia posible.
- Necesariamente las líneas deben de ser muy cortas.
- Diseño muy optimizado y ligado al tipo de CPU y subsistema de memoria.
- Puede contemplar el uso de múltiples CPUs.

En diseños actuales, el bus está desacoplado del resto del sistema por el "Puente Norte".

### Buses de E/S o de expansión

Su propósito es la conexión de dispositivos E/S o adaptadores de estos. No tienen conexión directa al bus local, requiriendo siempre un circuito intermedio de adaptación.

![[Pasted image 20231127181758.png]]

- Los hay rápidos, optimizados y cortos (AGP, PCI-eXpress, etc.).
- Otros permiten conexiones múltiples con longitudes moderadas y velocidad media, media-alta (PCI, SCSI, USB).
- Optimizados para largas distancias (bus serie RS-422).

### Clasificación de buses según su temporización

En una transacción es imprescindible la señalización de sincronismo entre maestro y esclavo para que sepan en qué fase se encuentran y el momento exacto en qeu pueden leer e interpretar con seguridad los valores de la línea de bus.

Dependiendo del origen e interpretación de las señales de sincronismo, los buses se clasifican en **síncronos** o **asíncronos**.

### Bus síncrono

Existe una señal periódica de sincronismo (CLK) común a todos los dispositivos.
- CLK es generada por un dispositivo externo distinto al maestro y al esclavo.
- Los ciclos delimitan precisamente intervalos de tiempo (ciclos de reloj o *time-slots*).

Cada fase se produce en un *time-slot*:
- Fijado por las especificaciones del bus.
- El instante de comienzo y final se puede calcular contando el número de ciclos CLK transcurridos.

![[Ejemplo bus síncrono.png]]

En el primer ciclo CLK ocurre la fase de direccionamiento:
- Maestro señala dirección y tipo.
- Esclavo interpreta la señalización.
En las fases de datos:
- Cada movimiento de datos requiere un ciclo.
- En cada ciclo el maestro debe colocar en bus los datos a transferir, y el esclavo leerlos y almacenarlos.

La **temporización es muy estricta:**
- Si maestro o esclavo necesitan tiempo adicional deben señalizarlo.
	- Activación de línea específica del bus, llamada **WAIT o READY**.
- El tiempo adicional se consigue añadiendo ciclos de espera (WAIT STATES)
	- CLK sigue oscilando pero no cuenta a efectos de la evolución de la transacción.

![[Ciclos de espera.png]]

<mark style="background: #FFF3A3A6;">Ventajas:</mark>
- Implementación relativamente sencilla al no requerir señalización bidireccional.
- Señalización unidireccional que permite transferencias modo ráfaga a la máxima velocidad posible.

<mark style="background: #FFF3A3A6;">Inconvenientes:</mark>
- Para eficacia máxima se necesita que los dispositivos trabajen a velocidades similares
	- Mezcla de dispositivos rápidos y lentos provoca frecuente inserción de estados de espera.
- Requiere distribuir una señal de reloj común por el bus.

### Bus asíncrono

En este bus la sincronización se consigue mediante señales de control (*handshaking*). Esto hace que la señalización pueda ser tanto unidireccional como bidireccional (*one-way, two-way*).

Se usa un *strobe* para delimitar el intervalo de tiempo durante el que los valores en el bus de datos son estables. Los datos deben escribirse en el bus antes de activar el *strobe* y retirarse del bus después de desactivarlo.

![[Strobe.png]]

![[Señalización bidireccional.png]]

- Sistema D = destino de datos
	- Utiliza el REQ para solicitar que le transfieran datos.
- Sistema O = origen de datos
	- Utiliza ACK para indicar cuándo hay datos válidos en el bus.

![[Secuencia bus asíncrono.png]]

![[Handshaking asíncrono bidireccional.png]]

![[Ejemplo handshaking asíncrono.png]]

<mark style="background: #FFF3A3A6;">Ventajas:</mark>
- Mayor flexibilidad para sincronizar la operación con distintas velocidades.
- El estado de transacción no evoluciona hasta que hay señal de control.
	- No se requieren estados de espera.

<mark style="background: #FFF3A3A6;">Inconvenientes:</mark>
- Implementación más compleja.
- En bidireccionales, la necesidad de esperar ACK reduce la capacidad del bus.

# Tema II: Análisis y evolución del bus PCI

## I - Bus PCI: Introducción

Aparece a finales de los 80 para solucionar la limitación de rendimiento de la E/S de la arquitectura del PC. La arquitectura dominante era la ISA. Arquitectura basada en un bus local CPU-Memoria, más un bus ISA (AT) para E/S.

![[Arquitectura ISA.png|700]]

La capacidad del bus de expansión muy limitada a 24 bits de direcciones, 16 bits de datos, bus síncrono y no soporta modo ráfaga.

La velocidad máxima de transferencia ISA es 8.33MBytes/s.




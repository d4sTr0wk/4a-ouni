
*En este bloque usaremos las transparencias:*
[Texto](file:\\\C:\Users\Máximo\Desktop\obsidian_srcs\Bloque-tematico-1.pdf)

## Índice:
- [Tema I: Organización de la E/S](#tema1)
- [Tema II: Análisis y evolución del bus PCI](#tema2)

## Tema I: Organización de la E/S
#tema1

![[Pasted image 20231018015431.png]]
![[Pasted image 20231018020306.png]]

### Estructura de la E/S

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

![[Ejemplo E-S mapeada por memoria.png]]

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




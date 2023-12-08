# Sobrecostes inherentes a la virtualización

## Procesador: Virtualización SW
![[Procesador virtualización sw.png]]

## Procesador: Virtualización HW
![[Procesador Virtualización HW.png]]

## Procesador

El **problema** son las instrucciones **privilegiadas** y la **E/S**.

- **Con traducción binaria** en tiempo de ejecución
	- Se traducen a un código seguro para CPU real.
	- Código emulación por software
	- Tiempo adicional por traducir.
- **Con Trap & Emulate**
	- Excepciones en CPU real que emula por software.
Soporte HW reduce efecto E/S.

Pérdida de eficiencia por virtualización:
$S_v=f_p\times N_e+(1-f_p)$
- $f_p$ : fracción de instrucciones privilegiadas:
- $N_e$ : Número medio de instrucciones que las reemplazan
	- Rutina emulación
	- Excepción
$f_p$ depende de aplicación
- Bajo para CPU bound
- Alto para I/O bound
$N_e$ depende de técnica de virtualización (cientos o incluso miles).

![[Carita feliz carita triste.png]]
![[Fraction of privileged instructions.png]]

## El problema de las excepciones

Las excepciones invalidan trabajo anticipado por pipeline de procesador (prefetch, localidad caché, predicción saltos, otras optimizaciones de procesador y compilador). Cuanto más longitud tenga el pipeline, mayor pérdida de rendimiento con cada excepción.

Los programas I/O bound tienen syscall (trap) cada pocas instrucciones:
- Sumar efecto de todos los traps.
- Los traps tienen menor efecto que los accesos a disco.

## Memoria

La MV requiere simulación del espacio físico de memoria RAM y la MMU del procesador (overhead de memoria y procesamiento).

## Discos duros

Implementación:
- **By pass:** directamente sobre discos físicos, particiones, volúmenes lógicos.
- **Ficheros:** del sistema de archivos del hipervisor.

<mark style="background: #FFF3A3A6;">Volúmenes físicos:</mark>
- Menos retardo adicional en acceso.
- Uso para aplicaciones críticas o migrar servidor.

<mark style="background: #FFF3A3A6;">Implementados sobre ficheros:</mark>
- Overhead por sistema de ficheros (menos velocidad y más latencia).
- No asignar espacio libre ahorra espacio pero provoca **inanición** por falta de disco real e introduce **fragmentación**.

## Snapshots de disco


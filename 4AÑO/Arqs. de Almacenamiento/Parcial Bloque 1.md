![[Figura1.png]]

1) Como se observa en la Figura 1, el procesador Z80 tiene líneas MREQ ,  IOREQ y dispone de instrucciones específicas IN y OUT. Suponiendo que la interfase del  periférico P1 tiene cuatro registros, y que se activa al poner a 1 la señal CS (activa en alta):
	1)   Dibuja cómo serían el conexionado y la lógica de decodificación necesarios  para que el procesador pueda acceder a los registros de P1 usando E/S diferenciada. ¿Qué  instrucción debería usar el driver el dispositivo P1 para escribir en estos registros, en  este caso?
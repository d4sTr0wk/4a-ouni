% 1.- Señal continua senoidal
% ---------------------------
% Número de puntos por segundo tomados para representar la señal original,
% supuestamente continua; 10 Hz por defecto
Fs = 10;
% Resolución de la señal, 100 ms por defecto
Ts = 1/Fs; 
% Tiempo máximo de captura, en segundos
TMax = 10;
% Frecuencia de la señal, en Hz.
Frec_senal_1 = 0.21;
% Intervalo de representación de la señal
t = 0:Ts:(TMax-Ts);
% Señal sen (t)
senal = sin (Frec_senal_1*2*pi*t);
% Representamos sen (t)
figure (1); plot (t, senal); grid;
title ('Señal sen (F1*t)');
xlabel ('Tiempo (segundos)'); ylabel ('Señal sen (F1*t)');


% 2.- Tren de pulsos para muestreo
% --------------------------------
% Frecuencia de muestreo para el tren de pulsos, 1 Hz por defecto
Fm = 1;
% Periodo de muestreo, inversa del periodo, 1 segundo por defecto
Tm = 1/Fm;
% Valores iniciales a cero del tren de pulsos de muestreo
tren = zeros([1,length(t)]);
% Rellenamos el tren de pulsos con los puntos de muestreo,
% cogiendo 1 punto cada Fs/Fm posiciones
for n = 1:round(Fs/Fm):length(t);       
   tren(n) = 1;
end;
% Representamos la señal y el tren de pulsos
figure (2); subplot (2,1,1); plot (t, senal); grid;
title ('Señal sen (F1*t)');
figure (2); subplot (2,1,2); plot (t, tren); grid;
title ('Tren de pulsos para muestreo');


% 3.- Señal muestreada
% --------------------
% Calculamos la señal muestreada multiplicando punto a punto
% el tren del pulsos por la señal senoidal
senal_muestreada = senal .* tren;
% Representamos gráficamente las 3 señales:
% senoidal original, el tren de pulsos y la senoidal mustreada
figure (3); subplot (3,1,1); plot (t, senal); grid; title ('Señal sen (F1*t)');
figure (3); subplot (3,1,2); plot (t, tren); grid; title ('Señal tren de pulsos');
figure (3); subplot (3,1,3); plot (t, senal_muestreada,'r'); grid; title ('Señal sen (F1*t) muestreada');


% 4.- Análisis en frecuencia (Completo)
% -------------------------------------
% Representamos la información en frecuencia del seno original
% Número de muestras de la señal
longitud = length (senal);
% Calculamos la FFT de la señal
% Devuelve "longitud" posiciones con los valores presentes para cada componente de frecuencia.
senal_fft = fft (senal,longitud);
% Calculamos la magnitud de la FFT como el valor abosoluto
% de sus números complejos
Magnitud = abs (senal_fft);
% Calculamos también la fase de la FFT como el ángulo
% de sus números complejos
Fase = unwrap (angle (senal_fft));
% Generamos un vector con las muestras en frecuencia para el eje X
% de la representación en frecuencia
EjeX = linspace (0,Fs-(Fs/longitud),longitud);
% Dibujamos la magnitud en frecuencia
figure (4); subplot (4,1,1); plot (EjeX, Magnitud); grid;
title ('Representación Espectral sen (F1*t) (Completa)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (4); subplot (4,1,2); plot (EjeX, Fase); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');


% 5.- Análisis en frecuencia (Zoom)
% ---------------------------------
% Representamos la información en frecuencia del seno original
% Número de muestras de la señal
longitud = length (senal);
% Calculamos la FFT de la señal
% Devuelve "longitud" posiciones con los valores presentes para cada componente de frecuencia.
senal_fft = fft (senal,longitud);
% Calculamos la magnitud de la FFT como el valor abosoluto
% de sus números complejos
Magnitud = abs (senal_fft);
% Calculamos también la fase de la FFT como el ángulo
% de sus números complejos
Fase = unwrap (angle (senal_fft));
% Generamos un vector con las muestras en frecuencia para el eje X
% de la representación en frecuencia
EjeX = linspace (0,Fs-(Fs/longitud),longitud);
% Dibujamos la magnitud en frecuencia,
% pero sólo la mitad+1 de la longitud, quitando la zona de "espejo"
% que no aporta información nueva
figure (4); subplot (4,1,3); plot (EjeX(1:(longitud/2)+1), Magnitud(1:(longitud/2)+1)); grid;
title ('Representación Espectral sen (F1*t) (1ª Mitad)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (4); subplot (4,1,4); plot (EjeX(1:(longitud/2)+1), Fase(1:(longitud/2)+1)); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');


% 6.- Mezcla de 2 señales senoidales
% ----------------------------------
% Defino la frecuencia de la señal senoidal a mezclar, senal2
Frec_senal_2 = 1;
% Genero la señal senoidal nueva
senal2 = sin (Frec_senal_2*2*pi*t);
% Genero la señal mezclada sumando las dos senoidales
senal_mezclada = senal + senal2;
% Dibujo las tres señales: la senoidal del apartado 1,
% la definida en el presente apartado (senal2),
% ya suma de ambas (senal_mezclada)
figure (5); subplot (3,1,1); plot (t, senal); grid;
title ('Mezcla de señales');
xlabel ('Tiempo (segundos)'); ylabel ('Señal sen (F1*t)');
figure (5); subplot (3,1,2); plot (t, senal2); grid;
xlabel ('Tiempo (segundos)'); ylabel ('Señal sen (F2*t)');
figure (5); subplot (3,1,3); plot (t, senal_mezclada); grid;
xlabel ('Tiempo (segundos)'); ylabel ('sen (F1*t) + sen (F2*t)');


% 7.- Análisis en frecuencia de la señal mezclada
% -----------------------------------------------
% Representamos la información en frecuencia de la señal mezclada
% Número de muestras de la señal
longitud = length (senal_mezclada);
% Calculamos la FFT de la señal
% Devuelve "longitud" posiciones con los valores presentes para cada componente de frecuencia.
senal_fft = fft (senal_mezclada,longitud);
% Calculamos la magnitud de la FFT como el valor abosoluto
% de sus números complejos
Magnitud = abs (senal_fft);
% Calculamos también la fase de la FFT como el ángulo
% de sus números complejos
Fase = unwrap (angle (senal_fft));
% Generamos un vector con las muestras en frecuencia para el eje X
% de la representación en frecuencia
EjeX = linspace (0,Fs-(Fs/longitud),longitud);
% Dibujamos la magnitud en frecuencia,
% pero sólo la mitad+1 de la longitud, quitando la zona de "espejo"
% que no aporta información nueva
figure (6); subplot (2,1,1); plot (EjeX(1:(longitud/2)+1), Magnitud(1:(longitud/2)+1)); grid;
title ('Representación Espectral sen (F1*t) + sen (F2*t) (1ª Mitad)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (6); subplot (2,1,2); plot (EjeX(1:(longitud/2)+1), Fase(1:(longitud/2)+1)); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');

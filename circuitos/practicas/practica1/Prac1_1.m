% 1.- Se�al continua senoidal
% ---------------------------
% N�mero de puntos por segundo tomados para representar la se�al original,
% supuestamente continua; 10 Hz por defecto
Fs = 10;
% Resoluci�n de la se�al, 100 ms por defecto
Ts = 1/Fs; 
% Tiempo m�ximo de captura, en segundos
TMax = 10;
% Frecuencia de la se�al, en Hz.
Frec_senal_1 = 0.21;
% Intervalo de representaci�n de la se�al
t = 0:Ts:(TMax-Ts);
% Se�al sen (t)
senal = sin (Frec_senal_1*2*pi*t);
% Representamos sen (t)
figure (1); plot (t, senal); grid;
title ('Se�al sen (F1*t)');
xlabel ('Tiempo (segundos)'); ylabel ('Se�al sen (F1*t)');


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
% Representamos la se�al y el tren de pulsos
figure (2); subplot (2,1,1); plot (t, senal); grid;
title ('Se�al sen (F1*t)');
figure (2); subplot (2,1,2); plot (t, tren); grid;
title ('Tren de pulsos para muestreo');


% 3.- Se�al muestreada
% --------------------
% Calculamos la se�al muestreada multiplicando punto a punto
% el tren del pulsos por la se�al senoidal
senal_muestreada = senal .* tren;
% Representamos gr�ficamente las 3 se�ales:
% senoidal original, el tren de pulsos y la senoidal mustreada
figure (3); subplot (3,1,1); plot (t, senal); grid; title ('Se�al sen (F1*t)');
figure (3); subplot (3,1,2); plot (t, tren); grid; title ('Se�al tren de pulsos');
figure (3); subplot (3,1,3); plot (t, senal_muestreada,'r'); grid; title ('Se�al sen (F1*t) muestreada');


% 4.- An�lisis en frecuencia (Completo)
% -------------------------------------
% Representamos la informaci�n en frecuencia del seno original
% N�mero de muestras de la se�al
longitud = length (senal);
% Calculamos la FFT de la se�al
% Devuelve "longitud" posiciones con los valores presentes para cada componente de frecuencia.
senal_fft = fft (senal,longitud);
% Calculamos la magnitud de la FFT como el valor abosoluto
% de sus n�meros complejos
Magnitud = abs (senal_fft);
% Calculamos tambi�n la fase de la FFT como el �ngulo
% de sus n�meros complejos
Fase = unwrap (angle (senal_fft));
% Generamos un vector con las muestras en frecuencia para el eje X
% de la representaci�n en frecuencia
EjeX = linspace (0,Fs-(Fs/longitud),longitud);
% Dibujamos la magnitud en frecuencia
figure (4); subplot (4,1,1); plot (EjeX, Magnitud); grid;
title ('Representaci�n Espectral sen (F1*t) (Completa)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (4); subplot (4,1,2); plot (EjeX, Fase); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');


% 5.- An�lisis en frecuencia (Zoom)
% ---------------------------------
% Representamos la informaci�n en frecuencia del seno original
% N�mero de muestras de la se�al
longitud = length (senal);
% Calculamos la FFT de la se�al
% Devuelve "longitud" posiciones con los valores presentes para cada componente de frecuencia.
senal_fft = fft (senal,longitud);
% Calculamos la magnitud de la FFT como el valor abosoluto
% de sus n�meros complejos
Magnitud = abs (senal_fft);
% Calculamos tambi�n la fase de la FFT como el �ngulo
% de sus n�meros complejos
Fase = unwrap (angle (senal_fft));
% Generamos un vector con las muestras en frecuencia para el eje X
% de la representaci�n en frecuencia
EjeX = linspace (0,Fs-(Fs/longitud),longitud);
% Dibujamos la magnitud en frecuencia,
% pero s�lo la mitad+1 de la longitud, quitando la zona de "espejo"
% que no aporta informaci�n nueva
figure (4); subplot (4,1,3); plot (EjeX(1:(longitud/2)+1), Magnitud(1:(longitud/2)+1)); grid;
title ('Representaci�n Espectral sen (F1*t) (1� Mitad)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (4); subplot (4,1,4); plot (EjeX(1:(longitud/2)+1), Fase(1:(longitud/2)+1)); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');


% 6.- Mezcla de 2 se�ales senoidales
% ----------------------------------
% Defino la frecuencia de la se�al senoidal a mezclar, senal2
Frec_senal_2 = 1;
% Genero la se�al senoidal nueva
senal2 = sin (Frec_senal_2*2*pi*t);
% Genero la se�al mezclada sumando las dos senoidales
senal_mezclada = senal + senal2;
% Dibujo las tres se�ales: la senoidal del apartado 1,
% la definida en el presente apartado (senal2),
% ya suma de ambas (senal_mezclada)
figure (5); subplot (3,1,1); plot (t, senal); grid;
title ('Mezcla de se�ales');
xlabel ('Tiempo (segundos)'); ylabel ('Se�al sen (F1*t)');
figure (5); subplot (3,1,2); plot (t, senal2); grid;
xlabel ('Tiempo (segundos)'); ylabel ('Se�al sen (F2*t)');
figure (5); subplot (3,1,3); plot (t, senal_mezclada); grid;
xlabel ('Tiempo (segundos)'); ylabel ('sen (F1*t) + sen (F2*t)');


% 7.- An�lisis en frecuencia de la se�al mezclada
% -----------------------------------------------
% Representamos la informaci�n en frecuencia de la se�al mezclada
% N�mero de muestras de la se�al
longitud = length (senal_mezclada);
% Calculamos la FFT de la se�al
% Devuelve "longitud" posiciones con los valores presentes para cada componente de frecuencia.
senal_fft = fft (senal_mezclada,longitud);
% Calculamos la magnitud de la FFT como el valor abosoluto
% de sus n�meros complejos
Magnitud = abs (senal_fft);
% Calculamos tambi�n la fase de la FFT como el �ngulo
% de sus n�meros complejos
Fase = unwrap (angle (senal_fft));
% Generamos un vector con las muestras en frecuencia para el eje X
% de la representaci�n en frecuencia
EjeX = linspace (0,Fs-(Fs/longitud),longitud);
% Dibujamos la magnitud en frecuencia,
% pero s�lo la mitad+1 de la longitud, quitando la zona de "espejo"
% que no aporta informaci�n nueva
figure (6); subplot (2,1,1); plot (EjeX(1:(longitud/2)+1), Magnitud(1:(longitud/2)+1)); grid;
title ('Representaci�n Espectral sen (F1*t) + sen (F2*t) (1� Mitad)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (6); subplot (2,1,2); plot (EjeX(1:(longitud/2)+1), Fase(1:(longitud/2)+1)); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');

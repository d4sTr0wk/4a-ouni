% 1.- Se�al de ECG
% ----------------
% Cargamos el fichero con el ECG a procesar
load ('E1040552.MAT');
% Definimos ECG_1 como la variable de entrada con el ECG.
ECG_1 = e1040552;
% Calculamos la longitud de la secuencia
longitud = length (e1040552);
% Creamos el intervalo de representaci�n de la se�al, en muestras
m = 0:(longitud-1);
% Representamos gr�ficamente el ECG de entrada
figure (1); plot (m, ECG_1); grid;
title ('ECG de Entrada');
xlabel ('Muestras'); ylabel ('ECG');


% 2.- Se�al de ECG (en funci�n del tiempo)
% ----------------------------------------
% Frecuencia de muestreo, 500 Hz por defecto
Fs = 500;
% Resoluci�n de la se�al (periodo de muestreo), inversa de la frecuencia
Ts = 1 / Fs;
% Definimos el intervalo de tiempo de representaci�n de la se�al del ECG
t = 0:Ts:(longitud-1)/Fs;
% Representamos gr�ficamente el ECG de entrada, en valores de mV y de tiempo
figure (2); subplot (2,1,1); plot (t, ECG_1); grid;
title ('ECG de Entrada con escalas ajustadas en eje X e Y');
xlabel ('Tiempo (s)'); ylabel ('ECG');


% 3.- Se�al de ECG (en funci�n del tiempo, sin DC, en mV)
% ------------------------------------------------------
% Calculamos la ECG sin OFFSET, es decir, la centramos verticalmente en el eje Y
ECG_sin_DC = ECG_1 - mean (ECG_1);
% Representamos gr�ficamente el ECG de entrada, en valores de mV y de tiempo
figure (2); subplot (2,1,2); plot (t, ECG_sin_DC); grid;
xlabel ('Tiempo (s)'); ylabel ('ECG en mV');


% 4.- An�lisis en frecuencia
% --------------------------
% Representamos la informaci�n en frecuencia del ECG original
% N�mero de muestras de la se�al
longitud = length (ECG_sin_DC);
% Calculamos la FFT de la se�al
% Devuelve "longitud" posiciones con los valores presentes para cada componente de frecuencia.
senal_fft = fft (ECG_sin_DC,longitud);
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
figure (3); subplot (2,1,1); plot (EjeX(1:(longitud/2)+1), Magnitud(1:(longitud/2)+1)); grid;
title ('Representaci�n en Frecuencia de ECG');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (3); subplot (2,1,2); plot (EjeX(1:(longitud/2)+1), Fase(1:(longitud/2)+1)); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');
% Dibujamos la magnitud en frecuencia, pero haciendo "zoom" a la parte m�s
% importante (0-60 Hz aprox.)
figure (4); subplot (2,1,1); plot (EjeX(1:(longitud/8)+1), Magnitud(1:(longitud/8)+1)); grid;
title ('Representaci�n en Frecuencia de ECG (0-70 Hz)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (4); subplot (2,1,2); plot (EjeX(1:(longitud/8)+1), Fase(1:(longitud/8)+1)); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');
% Dibujamos la magnitud en frecuencia, pero haciendo m�s "zoom" (0-20 Hz aprox.)
figure (5); subplot (2,1,1); plot (EjeX(1:(longitud/25)+1), Magnitud(1:(longitud/25)+1)); grid;
title ('Representaci�n en Frecuencia de ECG (0-20 Hz)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');
figure (5); subplot (2,1,2); plot (EjeX(1:(longitud/25)+1), Fase(1:(longitud/25)+1)); grid;
xlabel ('Frecuencia (Hz)');
ylabel ('Fase (rad)');

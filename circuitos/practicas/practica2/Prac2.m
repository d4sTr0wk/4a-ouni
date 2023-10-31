% ----------
% PR�CTICA 2
% ----------
%% 

% 1.- Se�al de ECG
% ----------------
% Cargar el ECG "e1071230.MAT", eliminar la componente de continua,
% y representarlo gr�ficamente en funci�n del tiempo y de la frecuencia.

% Cargamos el fichero con el electrocardiograma
load ('e1071230.MAT');
% Declaro variable con entrada al electrocardiograma
ECG_1 = e1071230;
% Calculo longitud de la se�al
longitud = length (ECG_1);
% Frecuencia de muestreo
Fs = 500;
% Periodo de muestreo
Ts = 1 / Fs;
% Intervalo de representaci�n de la se�al
t = 0:Ts:(longitud-1)/Fs;
% ECG sin DC
ECG_sin_DC = ECG_1 - mean(ECG_1);
% Calculo la FFT de la se�al ECG_sin_DC
senal_fft = fft (ECG_sin_DC, longitud);
% Calculamos la magnitud de FFT
magnitud = abs (senal_fft);
% Vector con las muestras
ejex = linspace (0, Fs-(Fs/longitud),longitud);
% Representaci�n gr�fica de lo que se pide
figure (1); subplot(2,1,1); plot(t, ECG_sin_DC); grid;
title ('Se�al ECG en funci�n del tiempo, sin DC y en mV');
xlabel ('Tiempo (s)'); ylabel ('ECG en mV');
figure (1); subplot (2,1,2); plot (ejex(1:(longitud/2)+1), magnitud(1:(longitud/2)+1)); grid;
title ('Representaci�n Espectral sen (F1*t) (1� Mitad)');
xlabel ('Frecuencia (Hz)');
ylabel ('|Magnitud|');

%%

% 2.- Simulaci�n de interferencia de l�nea de alimentaci�n (50 Hz)
% ----------------------------------------------------------------
% Generar una se�al senoidal de 50 Hz y 150 mV de amplitud para mezclala
% con el ECG del apartado anterior, simulando la introducci�n de ruido.
% Dibujar el resultado en funci�n del tiempo y de la frecuencia.



%%

% 3.- Ejemplo de filtro IIRNOTCH.
% -------------------------------
% Filtramos la se�al del ECG para eliminar el ruido introducido en la banda de 50 Hz
% Definimos la frecuencia que deseamos eliminar, centrada en W0
% La dividimos entre "Fs/2" porque hay que dar la frecuencia normalizada al filtro,
% es decir, un valor entre 0 y 1.
% Las frecuencias ir�n desde la 0 (0 radianes) hasta la 1 (Pi radianes, que es Fs/2).
W0 = 50/(Fs/2);
% Definimos el ancho de banda del filtro (BW), es decir, cu�nto m�s va a eliminar
% alrededor de la frecuencia base W0.
% Factor_calidad ser� un n�mero entre 0 y 100, habitualmente
% BW ser� W0 dividido entre el factor de calidad.
% Si el factor de calidad crece, la banda a filtrar se estrecha
Factor_calidad = 10;
BW = W0/Factor_calidad;
% Obtenemos los coeficientes del filtro
[b,a] = iirnotch (W0, BW);
% Mostramos el filtro, figura 3
fvtool (b,a);
% Aplicamos el filtro sobre la se�al "ECG_mezclado"
ECG_filtrado1 = filter (b,a,ECG_mezclado);
% Dibujo la se�al ECG_filtrado1 en funci�n del tiempo y de la frecuencia

% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 4.- Filtrado del ECG para eliminar la interferencia de la respiraci�n (< 1 Hz)
% ------------------------------------------------------------------------------
% Filtro iirnotch

% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 5.- Filtramos la se�al del ECG para eliminar la interferencia de la respiraci�n (< 1 Hz)
% (M�todo Alternativo)
% ----------------------------------------------------------------------------------------
Fstop = 0.1;         % Stopband Frequency
Fpass = 1;           % Passband Frequency
Astop = 30;          % Stopband Attenuation (dB)
Apass = 0.5;         % Passband Ripple (dB)
match = 'passband';  % Band to match exactly
% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);
fvtool (Hd);
ECG_filtrado3 = filter (Hd,ECG_filtrado1);
% Dibujo la se�al ECG_filtrado3 en funci�n del tiempo y de la frecuencia

% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------


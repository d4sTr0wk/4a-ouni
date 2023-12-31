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
figure (1); subplot(2,1,1); plot(t, ECG_sin_DC); grid();
title ('Se�al ECG en funci�n del tiempo, sin DC y en mV');
xlabel ('Tiempo (s)'); ylabel ('ECG en mV');
figure (1); subplot (2,1,2); plot (ejex(1:(longitud/2)+1), magnitud(1:(longitud/2)+1)); grid;
title ('Representaci�n Espectral sen (F1*t) (1� Mitad)');
xlabel ('Frecuencia (Hz)');
ylabel ('Magnitud');

%%

% 2.- Simulaci�n de interferencia de l�nea de alimentaci�n (50 Hz)
% ----------------------------------------------------------------
% Generar una se�al senoidal de 50 Hz y 150 mV de amplitud para mezclala
% con el ECG del apartado anterior, simulando la introducci�n de ruido.
% Dibujar el resultado en funci�n del tiempo y de la frecuencia.

Frecuencia_senal_ruido = 50;
Ampiltud_senal_ruido = 150;
senal_ruido = Ampiltud_senal_ruido*sin(Frecuencia_senal_ruido*2*pi*t);
ECG_mezclado = senal_ruido + ECG_sin_DC;
figure (2); subplot (2,1,1); plot (t, ECG_mezclado); grid;
title ('ECG sin DC + Senal ruido');
xlabel ('Tiempo (s)'); ylabel ('ECG sin DC + Senal ruido');
% FFT a ECG_mezclado
longitud = length (ECG_mezclado);
senal_fft = fft (ECG_mezclado, longitud);
magnitud = abs (senal_fft);
ejex = linspace (0, Fs-(Fs/longitud), longitud);
% Uso round porque la divisi�n puede dar decimal y salta warning
figure (2); subplot (2,1,2); plot (ejex (1:round((longitud/9)+1)), magnitud (1:round((longitud/9)+1))); grid;
title ('FFT');
xlabel ('Frecuencia (Hz)'); ylabel('Magnitud')

%%

% 3.- Ejemplo de filtro IIRNOTCH.
% -------------------------------
% Filtramos la se�al del ECG para eliminar el ruido introducido en la banda de 50 Hz
% Definimos la frecuencia que deseamos eliminar, centrada en W0
% La dividimos entre "Fs/2" porque hay que dar la frecuencia normalizada al filtro,
% es decir, un valor entre 0 y 1.
% Las frecuencias ir�n desde la 0 (0 radianes) hasta la 1 (Pi radianes, que es Fs/2).
Fs = 500;
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

% ECG_filtrado1 en frecuencia = FFT
longitud = length (ECG_filtrado1);
senal_fft = fft (ECG_filtrado1, longitud);
magnitud = abs (senal_fft);
ejex = linspace (0, Fs-(Fs/longitud), longitud);

figure (4); subplot (2,1,1); plot (t, ECG_filtrado1); grid();
title ('ECG Filtrado');
xlabel ('Tiempo (s)');
ylabel ('ECG Filtrado en mV');
figure (4); subplot (2,1,2); plot (ejex (1:round((longitud/9)+1)), magnitud (1:round((longitud/9)+1))); grid;
title ('FFT');
xlabel ('Frecuencia (Hz)'); ylabel('Magnitud')

%%

% 4.- Filtrado del ECG para eliminar la interferencia de la respiraci�n (< 1 Hz)
% ------------------------------------------------------------------------------
% Filtro iirnotch

% Filtramos la se�al del ECG para eliminar el ruido introducido en la banda de 50 Hz
% Definimos la frecuencia que deseamos eliminar, centrada en W0
% La dividimos entre "Fs/2" porque hay que dar la frecuencia normalizada al filtro,
% es decir, un valor entre 0 y 1.
% Las frecuencias ir�n desde la 0 (0 radianes) hasta la 1 (Pi radianes, que es Fs/2).
Fs = 500;
W0 = 0.1/(Fs/2);
% Definimos el ancho de banda del filtro (BW), es decir, cu�nto m�s va a eliminar
% alrededor de la frecuencia base W0.
% Factor_calidad ser� un n�mero entre 0 y 100, habitualmente
% BW ser� W0 dividido entre el factor de calidad.
% Si el factor de calidad crece, la banda a filtrar se estrecha
Factor_calidad = 0.25;
BW = W0/Factor_calidad;
% Obtenemos los coeficientes del filtro
[b,a] = iirnotch (W0, BW);
% Mostramos el filtro, figura 3
fvtool (b,a);
% Aplicamos el filtro sobre la se�al "ECG_mezclado"
ECG_filtrado2 = filter (b,a,ECG_filtrado1);
% Dibujo la se�al ECG_filtrado1 en funci�n del tiempo y de la frecuencia

% ECG_filtrado2 en frecuencia = FFT
longitud = length (ECG_filtrado2);
senal_fft = fft (ECG_filtrado2, longitud);
magnitud = abs (senal_fft);
ejex = linspace (0, Fs-(Fs/longitud), longitud);

figure (6); subplot (2,1,1); plot (t, ECG_filtrado2); grid();
title ('ECG Filtrado');
xlabel ('Tiempo (s)');
ylabel ('ECG Filtrado en mV');
figure (6); subplot (2,1,2); plot (ejex (1:round((longitud/9)+1)), magnitud (1:round((longitud/9)+1))); grid();
title ('FFT');
xlabel ('Frecuencia (Hz)'); ylabel('Magnitud');

%%

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
% Longitud se�al
longitud = length (ECG_filtrado3);
% Calculamos FFT
senal_fft = fft(ECG_filtrado3, longitud);
% Magnitud de se�al
magnitud = abs (senal_fft);
% Vector con las muestras para el eje X
ejex = linspace (0,Fs-(Fs/longitud),longitud);
% Dibujo ECG_filtrado3 en funci�n de tiempo y frecuencia
figure (8); subplot (2,1,1); plot (t, ECG_filtrado3); grid();
title ('ECG filtrado 3 en base al tiempo');
xlabel ('Tiempo (s)');
ylabel ('ECG Filtrado\_3 en mV');
figure (8); subplot (2,1,2);plot (ejex(1:(longitud/2)+1), magnitud(1:(longitud/2)+1)); grid();
title ('EGC filtrado 3 en base a frecuencia');
xlabel ('Tiempo (s)');
ylabel ('Magnitud');


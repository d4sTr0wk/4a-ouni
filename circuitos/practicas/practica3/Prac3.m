% --------------------------------------------------
% Práctica 3. Transformada Z y de Fourier.
% Filtros Digitales FIR e IIR.
% --------------------------------------------------



% --------------------------------------------------
% 1.- Resolución analítica de una función de
% transferencia de un sistema (Filtro FIR).
% --------------------------------------------------
% H(z) = (1-0.5*z^-1)*(1+0.5*z^-1)
% (Sólo resolución analítica, no hay que hacer nada en MATLAB
% en este primer apartado)



% --------------------------------------------------
% 2.- Script de MATLAB para calcular y aplicar
% el filtro H(z) anterior.
% --------------------------------------------------
% Frecuencias de representación del filtro (en radianes)
% Utilizo una buena resolución para representarlo gráficamente
% (0.01 en este caso).
w = [0:0.01:pi];

% Definimos el filtro, Función de transferencia H(z) con z = e^jw:

H = (1.0 - 0.5*exp((-1)*i*w)) .* (1.0 + 0.5*exp((-1)*i*w));

% Normalizo el filtro, buscando el valor máximo del módulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro
[H_max,p] = max(abs(H));
H_norm = H ./ H_max;

% Dibujo la Figura 1:
% A) magnitud sin normalizar (lineal)
% B) Fase
% C) magnitud normalizada entre 0 y 1
% d) magnitud en dB

figure (1); subplot(2,2,1); plot(w, abs(H));
title ('magnitud sin normalizar');
xlabel('Frecuencia');
ylabel('magnitud');
figure (1); subplot(2,2,2); plot(w, unwrap(angle(H)));
title ('Fase');
xlabel('Frecuencia');
ylabel('magnitud');
figure (1); subplot(2,2,3); plot(w, abs(H_norm));
title ('magnitud Normalizada');
xlabel('Frecuencia');
ylabel('magnitud');
figure (1); subplot(2,2,4); plot(w, 20*log10(abs(H_norm)));
title ('magnitud en dB');
xlabel('Frecuencia');
ylabel('magnitud');

% Dibujo la Figura 2:
% A) Señal Senoidal de Entrada en función del tiempo
% B) Señal Senoidal de Entrada en función de la frecuencia (magnitud)
% C) Señal Senoidal en función del tiempo tras aplicar el filtro e IFFT
% D) Señal Senoidal en función de la frecuencia tras aplicar el filtro
% Aplico el filtro sobre la señal senoidal.
% Debemos generar un filtro igual al anterior pero con el mismo nº de muestras
% que el seno de entrada, que vendrá dado en la variable "Longitud".
% Este nº de muestras debe coincidir con las de la FFT del seno de entrada,
% que será de 0 a 2*pi espaciados "2*pi/Longitud"

Fc = 100;
Fmuestreo = 800;
Ts = 1 / Fmuestreo;
Tc = 1 / Fc;
Longitud = Tc / Ts;
numero_ciclos = 16;
% Definimos el intervalo de tiempo de representación de la señal
w = 0:Ts:(Longitud*numero_ciclos-1)/Fmuestreo;
senal = 4*sin (Fc*2*pi*w);
Longitud = length (senal);
% Calculo la FFT de la señal
senal_fft = fft (senal,Longitud);
% Calculo la magnitud de la FFT
magnitud = abs (senal_fft);
ejex = linspace (0,Fmuestreo-(Fmuestreo/Longitud),Longitud);

w2 = [0:2*pi/Longitud:2*pi-(2*pi/Longitud)];
H2 = (1.0 - 0.5*exp(-1i*w2)).*(1.0 + 0.5*exp(-1i*w2));
sfilt_1 = H2 .* senal_fft;
sfilt_1_ifft = ifft(sfilt_1);


Longitud = length (real(sfilt_1_ifft));
% Calculo la FFT de la señal
senal_fft = fft (real(sfilt_1_ifft),Longitud);
% Calculo la magnitud de la FFT
magnitud = abs (senal_fft);
ejex = linspace (0,Fmuestreo-(Fmuestreo/Longitud),Longitud);

figure (2); subplot(2,2,1); plot(w, senal);
title ('Señal senoidal en tiempo');
xlabel('Tiempo');
ylabel('Amplitud');
figure(2); subplot(2,2,2); plot (ejex(1:(Longitud/2)+1), magnitud(1:(Longitud/2)+1)); grid();
title ('Señal senoidal en frecuencia');
xlabel('Frecuencia');
ylabel('magnitud');
figure (2); subplot(2,2,3); plot(w, real(sfilt_1_ifft));
title ('Señal senoidal filtrada + FFT en tiempo');
xlabel('Tiempo'); 
ylabel('Amplitud'); 
figure (2); subplot(2,2,4); plot (ejex(1:(Longitud/2)+1), magnitud(1:(Longitud/2)+1)); grid;
title ('Señal senoidal filtrada en frecuencia');
xlabel('Frecuencia (pi/rad)');
ylabel('magnitud');

% Dibujo la Figura 3:
% A) Señal Senoidal de Entrada en función del tiempo
% B) Señal Senoidal de Entrada en función de la frecuencia (magnitud)
% C) Señal Senoidal en función del tiempo tras aplicar el filtro e IFFT
% D) Señal Senoidal en función de la frecuencia tras aplicar el filtro
% Aplico el filtro sobre la señal senoidal.
% Debemos generar un filtro igual al anterior pero con el mismo nº de muestras
% que el seno de entrada, que vendrá dado en la variable "Longitud".
% Este nº de muestras debe coincidir con las de la FFT del seno de entrada,
% que será de 0 a 2*pi espaciados "2*pi/Longitud"
w2 = [0:2*pi/Longitud:2*pi-(2*pi/Longitud)];

% --------------------------------------------------
% 3.- Resolución analítica de una función de
% transferencia de un sistema (Filtro FIR).
% --------------------------------------------------
% H(z) = (1-0.5*z^-1)/(1+0.5*z^-1)
% (Sólo resolución analítica, no hay que hacer nada en MATLAB
% en este tercer apartado)

% A)
Fmuestreo = 800;
A = 4;
Ts = 1 / Fmuestreo;
% Frecuencias
Fc1 = 30;
Fc2 = 220;
TMax = 16 / Fc2;
% Intervalo de reprentación de tiempo
t = 0:Ts:(TMax - Ts);
% Creo las señales y las sumo
senal1 = A * sin (Fc1*2*pi*t);
senal2 = A * sin (Fc2*2*pi*t);
suma_senales= senal1 + senal2;

figure (3); subplot(2,2,1); plot(t, suma_senales);
title ('Suma de señales en tiempo');
xlabel('Tiempo (s)');
ylabel('Amplitud');

% B)
Longitud = length(suma_senales);
senal_sum_fft = fft(suma_senales,Longitud);
magnitud = abs(suma_senales);
ejex = linspace (0, Fmuestreo - (Fmuestreo/Longitud), Longitud);

figure (3); subplot(2,2,2); plot(ejex(1:(Longitud/2)+1), magnitud(1:(Longitud/2)+1));
title ('Señal  en frecuencia');
xlabel ('Frecuencia (Hz)');
ylabel ('magnitud');

% C)
w3 = [0:2*pi/Longitud:2*pi-(2*pi/Longitud)];

H3 = (1.0 - 0.5*exp(-1i*w3)) .* (1.0 + 0.5*exp(-1i*w3));
% Filtro H
senal_sum_filt = H3 .* senal_sum_fft;
% Realizo IFFT
senal_sum_ifft = ifft(senal_sum_filt);

figure (3); subplot(2,2,3); plot(t,real(senal_sum_ifft));
title ('Señal senoidal IFFT');
xlabel ('Tiempo');
ylabel ('Amplitud');

% D)
Longitud = length (senal_sum_ifft);
senal_fft = fft (senal_sum_ifft, Longitud);
magnitud = abs (senal_fft);
ejex = linspace (0, Fmuestreo - (Fmuestreo/Longitud), Longitud);

figure (3); subplot(2,2,4); plot(ejex(1:(Longitud/2)+1), magnitud(1:(Longitud/2)+1));
title ('Señal de Senoidal en frecuencia');
xlabel ('Frecuencia');
ylabel ('magnitud');

% --------------------------------------------------
% 4. Código MATLAB para calcular y aplicar
% otro filtro H(z).
% --------------------------------------------------
% Frecuencias de representación del filtro (en radianes)
% Buena resolución para representarlo gráficamente
% (0.01 en este caso).
frequencies_filter = [0:0.01:pi];

% Definimos otro filtro, Función de transferencia H(z) con z = e^jw:
H_another_filter = (1.0 - 0.5*exp(-1i*frequencies_filter)) ./ (1.0 + 0.5*exp(-1i*frequencies_filter));

% Dibujo la Figura 4:
% A) Magnitud sin normalizar
% B) Fase
% C) Magnitud normalizada entre 0 y 1
% D) Magnitud en dB

figure(4);
subplot(2,2,1);
plot(frequencies_filter, abs(H_another_filter));
title('Otro Filtro H: Magnitud Sin Normalizar');
xlabel('Frecuencia');
ylabel('Magnitud');

subplot(2,2,2);
plot(frequencies_filter, unwrap(angle(H_another_filter)));
title('Otro Filtro H: Fase');
xlabel('Frecuencia');
ylabel('Fase');

subplot(2,2,3);
plot(frequencies_filter, abs(H_another_filter/H_max));
title('Otro Filtro H: Magnitud Normalizada');
xlabel('Frecuencia');
ylabel('Magnitud');

subplot(2,2,4);
plot(frequencies_filter, 20*log10(abs(H_another_filter/H_max)));
title('Otro Filtro H: Magnitud Normalizada (dB)');
xlabel('Frecuencia');
ylabel('Magnitud');

% --------------------------------------------------
% 5. Señal senoidal de entrada y salida con el filtro H(z).
% --------------------------------------------------
% A) Frecuencia de la señal senoidal
Fc_signal = 100;
% Frecuencia de muestreo
Fs_signal = 800;
% Amplitud
A_signal = 4;
% Periodo de muestreo
Ts_signal = 1 / Fs_signal;
% Para mostrar solo 16 ciclos:
Tmax_signal = 16/Fc_signal;
t_signal = 0:Ts_signal:(Tmax_signal - Ts_signal);
Signal = A_signal * sin(Fc_signal*2*pi*t_signal);
% A)
figure (5); subplot(2,2,1); plot(t_signal, Signal);
title ('Señal senoidal en tiempo');
xlabel('Frecuencia');
ylabel('Magnitud');


Length_signal = length(Signal);
% Calculo de la FFT
Signal_fft = fft(Signal, Length_signal);
% Magnitud
Magnitude_signal = abs(Signal_fft);
% Vector eje x
X_axis_signal = linspace (0, Fs_signal - (Fs_signal/Length_signal), Length_signal);
% B)
figure (5); subplot (2,2,2); plot (X_axis_signal(1:(Length_signal/2)+1),Magnitude_signal(1:(Length_signal/2)+1));
title ('Señal de senoidal en frecuencia');
xlabel ('Frecuencia');
ylabel ('Magnitud');

% C) Resolución gráfica
W2 = [0:2*pi/Length_signal:2*pi-(2*pi/Length_signal)];
H2 = (1.0 - 0.5*exp(-1i*W2)) ./ (1.0 + 0.5*exp(-1i*W2));
Filtered_signal = H2.*Signal_fft;
% Realizo IFFT
Signal_ifft = ifft(Filtered_signal);
% C)
figure (5); subplot(2,2,3); plot(t_signal,real(Signal_ifft));
title ('Señal senoidal IFFT');
xlabel ('Frecuencia');
ylabel ('Magnitud');

Length_signal_ifft = length (Signal_ifft);
Signal_fft = fft (Signal_ifft, Length_signal_ifft);
Magnitude_signal = abs (Signal_fft);
% Vector eje x
X_axis_signal = linspace (0, Fs_signal - (Fs_signal/Length_signal_ifft), Length_signal_ifft);
% D) 
figure (5); subplot(2,2,4); plot(X_axis_signal(1:(Length_signal_ifft/2)+1), Magnitude_signal(1:(Length_signal_ifft/2)+1));
title ('Señan senoidal en frecuencia con filtro');
xlabel ('Frecuencia');
ylabel ('Magnitud');

% --------------------------------------------------
% 6. Suma de señales senoidales y salida con el filtro H(z).
% --------------------------------------------------
% Datos para las señales seno: Frec.Muestreo, Amplitud, Periodo de muestreo
Fs_sum = 800;
A_sum = 4;
Ts_sum = 1 / Fs_sum;
% Frecuencia de la señal 1
Fc1_sum = 30;
% Frecuencia de la señal 2
Fc2_sum = 220;
% Modifico el periodo máximo para una mejor visualización
TMax_sum = 16 / Fc2_sum;
% Intervalo de reprentación de tiempo
t_sum = 0:Ts_sum:(TMax_sum - Ts_sum);
% Creo las señales y las sumo
Signal_1 = A_sum * sin (Fc1_sum*2*pi*t_sum);
Signal_2 = A_sum * sin (Fc2_sum*2*pi*t_sum);
Signal_Sum = Signal_1 + Signal_2;
% A)
figure (6); subplot(2,2,1); plot(t_sum, Signal_Sum);
title ('Suma de señales en tiempo');
xlabel('Frecuencia');
ylabel('Magnitud');

% B) 
Length_sum = length(Signal_Sum);
Signal_Sum_fft = fft(Signal_Sum, Length_sum);
Magnitude_sum = abs(Signal_Sum_fft);
% Vector del eje x para la representación
X_axis_sum = linspace (0, Fs_sum - (Fs_sum/Length_sum), Length_sum);
% B) Señal Senoidal de Entrada en función de la frecuencia (Magnitud)
figure (6); subplot(2,2,2); plot(X_axis_sum(1:(Length_sum/2)+1), Magnitude_sum(1:(Length_sum/2)+1));
title ('Señal senoidal en frecuencia');
xlabel ('Frecuencia');
ylabel ('Magnitud');

% C) Resolución gráfica
W3 = [0:2*pi/Length_sum:2*pi-(2*pi/Length_sum)];
% Filtro H
H3 = (1.0 - 0.5*exp(-1i*W3)) ./ (1.0 + 0.5*exp(-1i*W3));
Signal_Sum_filtered = H3 .* Signal_Sum_fft;
% Realizo IFFT
Signal_Sum_ifft = ifft(Signal_Sum_filtered);
% C) 
figure (6); subplot(2,2,3); plot(t_sum,real(Signal_Sum_ifft));
title ('Señal senoidal IFFT');
xlabel ('Frecuencia');
ylabel ('Magnitud');

Length_sum_ifft = length (Signal_Sum_ifft);
Signal_fft = fft (Signal_Sum_ifft, Length_sum_ifft);
Magnitude_sum = abs (Signal_fft);
X_axis_sum = linspace (0, Fs_sum - (Fs_sum/Length_sum_ifft), Length_sum_ifft);

% D)
figure (6); subplot(2,2,4); plot(X_axis_sum(1:(Length_sum_ifft/2)+1), Magnitude_sum(1:(Length_sum_ifft/2)+1));
title ('Señal de Senoidal en frecuencia con filtro');
xlabel ('Frecuencia');
ylabel ('Magnitud');


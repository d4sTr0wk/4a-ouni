% Señal de ECG, algoritmo de Pam-Tompkins, Mejora 1
% -----------------------------------------------------

% 1.- Cargar la señal del ECG de un fichero externo
% -------------------------------------------------
load ('E1000000.MAT');
load ('E1040552.MAT');
load ('E1001103.MAT');
load ('E1010954.MAT');
load ('E1071230.MAT');
load ('E1140536.MAT');
load ('E1162547.MAT');
load ('E2002449.MAT');
load ('E2140221.MAT');
load ('E2202029.MAT');
load ('E2322334.MAT');
load ('e113.mat');
load ('e222.mat');
% Definimos ECG_1 como la variable de entrada con el ECG.
ECG_1 = e1000000;
% ECG_1 = e1040552;
% ECG_1 = e1001103;
% ECG_1 = e1010954;
% ECG_1 = e1071230;
% ECG_1 = e1140536;
% ECG_1 = e1162547;
% ECG_1 = e2002449;
% ECG_1 = e2140221;
% ECG_1 = e2202029;
% ECG_1 = e2322334;
% ECG_1 = e113;
% ECG_1 = e222;
% Calculamos la longitud de la secuencia
longitud = length (ECG_1);
% Creamos el intervalo de representación de la señal, en muestras
m = 0:(longitud-1);
% Frecuencia de muestreo, 500 Hz por defecto
Fs = 500;
% Resolución de la señal (periodo de muestreo), inversa de la frecuencia
Ts = 1 / Fs;
% Definimos el intervalo de tiempo de representación de la señal del ECG
t = 0:Ts:(longitud-1)/Fs;




% 2.- Eliminar el OFFSET de esta señal del ECG.
% ---------------------------------------------
% Calculamos la ECG sin OFFSET, es decir, la centramos verticalmente en el eje Y

ECG_sin_DC = ECG_1 - mean(ECG_1);

% Figura 1, subplot 1
% Representamos gráficamente el ECG sin DC, en valores de mV y de tiempo

figure(1); subplot(2,1,1); plot(t, ECG_sin_DC);
title('ECG sin OFFSET'); ylabel('ECG_1'); xlabel('Tiempo'); 



% 3.- Realizar un primer análisis en frecuencia (FFT) de toda la señal del ECG 
% ----------------------------------------------------------------------------
% Calculamos la FFT de la señal del ECG sin DC y
% Generamos un vector con las muestras en frecuencia para el eje X de la representación

senal_fft = fft(ECG_sin_DC, longitud);
ejey_magnitud = abs(senal_fft);
ejex_frecuencia = linspace(0,Fs-(Fs/longitud),longitud);

% Figura 1, subplot 2
% Dibujamos la magnitud en frecuencia del ECG sin DC

figure(1); subplot(2,1,2); plot(ejex_frecuencia(1:longitud), ejey_magnitud(1:longitud));
title('Análisis FFT'); xlabel('Frecuencia'); ylabel('Magnitud');



% 4.- Representar de nuevo la señal del ECG sin OFFTSET y la FFT entre 0 y 35 Hz
% ------------------------------------------------------------------------------
% Figura 2, subplot 1
% Representamos gráficamente el ECG sin DC de nuevo, en valores de mV y de tiempo

figure(2); subplot(2,1,1); plot(t, ECG_sin_DC);
title('ECG sin OFFSET'); ylabel('ECG_1'); xlabel('Tiempo'); 

% Figura 2, subplot 2
% Dibujamos la magnitud en frecuencia del ECG sin DC, pero sólo entre 0 y 35 Hz
Fs_aux = 35;
ejex_frecuencia = linspace(0,Fs_aux-(Fs_aux/longitud),longitud);
figure(2); subplot(2,1,2); plot(ejex_frecuencia(1:(longitud/2)+1), ejey_magnitud(1:(longitud/2)+1));
title('Análisis FFT'); xlabel('Frecuencia'); ylabel('Magnitud');


% 5.- Aplicar un filtro pasa-bajos a la señal del ECG (H1)
% --------------------------------------------------------
% Generamos un filtro H basado en el nº de muestras de la señal,
% que vendrá dado en la variable "longitud".
% Este nº de muestras debe coincidir con las de la FFT de la propia señal del ECG,
% que será de 0 a 2*pi espaciados "2*pi/longitud"
w = 0:2*pi/longitud:2*pi-(2*pi/longitud);
% Definimos el filtro pasa-bajos para una Fs = 500 Hz (modificado respecto al Pan-Tompkins).

H1 = ((1-exp((-15)*i*w)).^2) / ((1-exp((-1)*i*w)).^2)

% Normalizamos el filtro, buscando el valor máximo del módulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro

[H1_maxvalue,plot] = max(abs(H1));
H1_realvalue = H1 ./ H1_maxvalue;

% El valor del filtro en la frecuencia 0 es infinito,
% pero debería tener ganancia 1
% (al ser un filtro pasa-bajos)


% Multiplicamos en frecuencia dato a dato


% Calculamos FFT inversa.


% Figura 3, subplot 2
% Representamos gráficamente la señal de la FFT filtrada pasa-bajos

% Figura 3, subplot 1
% Representamos gráficamente la señal en el tiempo


%%

% 6.- Aplicar un filtro pasa-altos a la señal del ECG (H3)
% --------------------------------------------------------
% Definimos el filtro pasa altos para una Fs = 500 Hz (modificado respecto al Pan-Tompkins).
% Lo hacemos definiendo primero un pasa bajos H2
H2 = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Normalizamos el filtro H2, buscando el valor máximo del módulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% El valor del filtro en la frecuencia 0 es infinito,
% pero debería tener ganancia 1
% (al ser un filtro pasa-bajos)
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Restamos a un filtro pasa todo el filtro pasa bajos H2,
% y obtenemos así el filtro definitivo pasa altos H3.
H3 = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Normalizamos el filtro H3, buscando el valor máximo del módulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------


% Multiplicamos en frecuencia dato a dato la señal ya filtrada en el paso anterior
% por el filtro H3 pasa altos normalizado.
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Calculamos FFT inversa.
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 4, subplot 2
% Representamos gráficamente la señal de la FFT filtrada pasa-bajos y pasa altos
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 4, subplot 1
% Representamos gráficamente la señal en el tiempo
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 8.- Calcular la derivada a la señal ya filtrada
% -----------------------------------------------
% Definimos el filtro que calcula la derivada del ECG filtrado
H5 = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Normalizamos el filtro, buscando el valor máximo del módulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Multiplicamos en frecuencia dato a dato la señal ya filtrada en el paso anterior
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Calculamos FFT inversa.
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 5, subplot 2
% Representamos gráficamente la señal de la FFT derivada
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 5, subplot 1
% Representamos gráficamente la señal en el tiempo
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 9.- Elevar la señal al cuadrado muestra a muestra, en el tiempo
% ---------------------------------------------------------------
% Multiplicamos en el tiempo dato a dato la señal ya filtrada y derivada
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 6, subplot 1
% Representamos gráficamente la señal en el tiempo
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 10.- Aplicar una ventana de integración a la señal
% ---------------------------------------------
% Tiempo de la ventana de integración, en segundos.
% Por defecto, 150 ms
tiempo_ventana = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Nº de muestras de la ventana de integración
muestras_vent = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Aplicar la ventana de integración. CONSEJO: se puede definir como si fuera un filtro,
% y aplicar con el comando "filter" a la señal elevada al cuadrado.
% Coeficientes del filtro:
% a = 1 (filtro FIR)
% b = (1/muestras_vent) para todos los datos de entrada de la ventana
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 6, subplot 2
% Representamos gráficamente la señal en el tiempo
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 11.- Algoritmo de detección del QRS mediante umbrales
% -----------------------------------------------------
% Inicializamos los valores de "spki" y "npki"
% a partir de los "entren" primeros segundos de señal
entren = 1;
% spki será 1/3 del máximo de la señal integrada en ese periodo
spki = max (ECG_integ(1:entren*Fs)) / 3;
% npki será la mitad de la media de la señal integrada en ese periodo
npki = mean (ECG_integ(1:entren*Fs)) / 2;
% Inicializamos el umbral "thri1" que nos indicará si el pico
% es de ruido (<= thri1) o señal (> thri1)
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Buscamos los picos en la señal integrada
% (utilizar "findpeaks")
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Creamos un vector relleno de ceros que indicará si hay QRS en un punto o no
% Si hay 0 es que no hay QRS, si hay otro valor es que sí lo hay
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Creo un vector para llevar el control de los "thri1", "npkis" y "spkis" que tengo
% en la evaluación de cada pico encontrado, y lo dibujaré junto con la señal integrada
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Realizamos un blucle identificando si cada pico es de señal o ruido,
% y tomando las acciones oportunas
for i = 1:total_picos
    % ------------------------
    % A RELLENAR POR EL ALUMNO
    % ------------------------
end;    

% Figura 7, subplot 1
% Dibujamos la ECG integrada y el vector QRS en dos subplots
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 7, subplot 2
% Dibujamos la ECG sin DC para comprobar los sitios donde hemos encontrado complejos QRS
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

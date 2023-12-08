% Se�al de ECG, algoritmo de Pam-Tompkins, Mejora 1
% -----------------------------------------------------

% 1.- Cargar la se�al del ECG de un fichero externo
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
% Creamos el intervalo de representaci�n de la se�al, en muestras
m = 0:(longitud-1);
% Frecuencia de muestreo, 500 Hz por defecto
Fs = 500;
% Resoluci�n de la se�al (periodo de muestreo), inversa de la frecuencia
Ts = 1 / Fs;
% Definimos el intervalo de tiempo de representaci�n de la se�al del ECG
t = 0:Ts:(longitud-1)/Fs;




% 2.- Eliminar el OFFSET de esta se�al del ECG.
% ---------------------------------------------
% Calculamos la ECG sin OFFSET, es decir, la centramos verticalmente en el eje Y

ECG_sin_DC = ECG_1 - mean(ECG_1);

% Figura 1, subplot 1
% Representamos gr�ficamente el ECG sin DC, en valores de mV y de tiempo

figure(1); subplot(2,1,1); plot(t, ECG_sin_DC);
title('ECG sin OFFSET'); ylabel('ECG_1'); xlabel('Tiempo'); 



% 3.- Realizar un primer an�lisis en frecuencia (FFT) de toda la se�al del ECG 
% ----------------------------------------------------------------------------
% Calculamos la FFT de la se�al del ECG sin DC y
% Generamos un vector con las muestras en frecuencia para el eje X de la representaci�n

senal_fft = fft(ECG_sin_DC, longitud);
ejey_magnitud = abs(senal_fft);
ejex_frecuencia = linspace(0,Fs-(Fs/longitud),longitud);

% Figura 1, subplot 2
% Dibujamos la magnitud en frecuencia del ECG sin DC

figure(1); subplot(2,1,2); plot(ejex_frecuencia(1:longitud), ejey_magnitud(1:longitud));
title('An�lisis FFT'); xlabel('Frecuencia'); ylabel('Magnitud');



% 4.- Representar de nuevo la se�al del ECG sin OFFTSET y la FFT entre 0 y 35 Hz
% ------------------------------------------------------------------------------
% Figura 2, subplot 1
% Representamos gr�ficamente el ECG sin DC de nuevo, en valores de mV y de tiempo

figure(2); subplot(2,1,1); plot(t, ECG_sin_DC);
title('ECG sin OFFSET'); ylabel('ECG_1'); xlabel('Tiempo'); 

% Figura 2, subplot 2
% Dibujamos la magnitud en frecuencia del ECG sin DC, pero s�lo entre 0 y 35 Hz
Fs_aux = 35;
ejex_frecuencia = linspace(0,Fs_aux-(Fs_aux/longitud),longitud);
figure(2); subplot(2,1,2); plot(ejex_frecuencia(1:(longitud/2)+1), ejey_magnitud(1:(longitud/2)+1));
title('An�lisis FFT'); xlabel('Frecuencia'); ylabel('Magnitud');


% 5.- Aplicar un filtro pasa-bajos a la se�al del ECG (H1)
% --------------------------------------------------------
% Generamos un filtro H basado en el n� de muestras de la se�al,
% que vendr� dado en la variable "longitud".
% Este n� de muestras debe coincidir con las de la FFT de la propia se�al del ECG,
% que ser� de 0 a 2*pi espaciados "2*pi/longitud"
w = 0:2*pi/longitud:2*pi-(2*pi/longitud);
% Definimos el filtro pasa-bajos para una Fs = 500 Hz (modificado respecto al Pan-Tompkins).

H1 = ((1-exp((-15)*i*w)).^2) / ((1-exp((-1)*i*w)).^2)

% Normalizamos el filtro, buscando el valor m�ximo del m�dulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro

[H1_maxvalue,plot] = max(abs(H1));
H1_realvalue = H1 ./ H1_maxvalue;

% El valor del filtro en la frecuencia 0 es infinito,
% pero deber�a tener ganancia 1
% (al ser un filtro pasa-bajos)


% Multiplicamos en frecuencia dato a dato


% Calculamos FFT inversa.


% Figura 3, subplot 2
% Representamos gr�ficamente la se�al de la FFT filtrada pasa-bajos

% Figura 3, subplot 1
% Representamos gr�ficamente la se�al en el tiempo


%%

% 6.- Aplicar un filtro pasa-altos a la se�al del ECG (H3)
% --------------------------------------------------------
% Definimos el filtro pasa altos para una Fs = 500 Hz (modificado respecto al Pan-Tompkins).
% Lo hacemos definiendo primero un pasa bajos H2
H2 = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Normalizamos el filtro H2, buscando el valor m�ximo del m�dulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% El valor del filtro en la frecuencia 0 es infinito,
% pero deber�a tener ganancia 1
% (al ser un filtro pasa-bajos)
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Restamos a un filtro pasa todo el filtro pasa bajos H2,
% y obtenemos as� el filtro definitivo pasa altos H3.
H3 = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Normalizamos el filtro H3, buscando el valor m�ximo del m�dulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------


% Multiplicamos en frecuencia dato a dato la se�al ya filtrada en el paso anterior
% por el filtro H3 pasa altos normalizado.
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Calculamos FFT inversa.
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 4, subplot 2
% Representamos gr�ficamente la se�al de la FFT filtrada pasa-bajos y pasa altos
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 4, subplot 1
% Representamos gr�ficamente la se�al en el tiempo
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 8.- Calcular la derivada a la se�al ya filtrada
% -----------------------------------------------
% Definimos el filtro que calcula la derivada del ECG filtrado
H5 = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Normalizamos el filtro, buscando el valor m�ximo del m�dulo (importante)
% Obtenemos un valor real por el que dividimos todo el filtro
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Multiplicamos en frecuencia dato a dato la se�al ya filtrada en el paso anterior
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Calculamos FFT inversa.
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 5, subplot 2
% Representamos gr�ficamente la se�al de la FFT derivada
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 5, subplot 1
% Representamos gr�ficamente la se�al en el tiempo
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 9.- Elevar la se�al al cuadrado muestra a muestra, en el tiempo
% ---------------------------------------------------------------
% Multiplicamos en el tiempo dato a dato la se�al ya filtrada y derivada
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 6, subplot 1
% Representamos gr�ficamente la se�al en el tiempo
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 10.- Aplicar una ventana de integraci�n a la se�al
% ---------------------------------------------
% Tiempo de la ventana de integraci�n, en segundos.
% Por defecto, 150 ms
tiempo_ventana = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% N� de muestras de la ventana de integraci�n
muestras_vent = ...
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Aplicar la ventana de integraci�n. CONSEJO: se puede definir como si fuera un filtro,
% y aplicar con el comando "filter" a la se�al elevada al cuadrado.
% Coeficientes del filtro:
% a = 1 (filtro FIR)
% b = (1/muestras_vent) para todos los datos de entrada de la ventana
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Figura 6, subplot 2
% Representamos gr�ficamente la se�al en el tiempo
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------



% 11.- Algoritmo de detecci�n del QRS mediante umbrales
% -----------------------------------------------------
% Inicializamos los valores de "spki" y "npki"
% a partir de los "entren" primeros segundos de se�al
entren = 1;
% spki ser� 1/3 del m�ximo de la se�al integrada en ese periodo
spki = max (ECG_integ(1:entren*Fs)) / 3;
% npki ser� la mitad de la media de la se�al integrada en ese periodo
npki = mean (ECG_integ(1:entren*Fs)) / 2;
% Inicializamos el umbral "thri1" que nos indicar� si el pico
% es de ruido (<= thri1) o se�al (> thri1)
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Buscamos los picos en la se�al integrada
% (utilizar "findpeaks")
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Creamos un vector relleno de ceros que indicar� si hay QRS en un punto o no
% Si hay 0 es que no hay QRS, si hay otro valor es que s� lo hay
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Creo un vector para llevar el control de los "thri1", "npkis" y "spkis" que tengo
% en la evaluaci�n de cada pico encontrado, y lo dibujar� junto con la se�al integrada
% ------------------------
% A RELLENAR POR EL ALUMNO
% ------------------------

% Realizamos un blucle identificando si cada pico es de se�al o ruido,
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

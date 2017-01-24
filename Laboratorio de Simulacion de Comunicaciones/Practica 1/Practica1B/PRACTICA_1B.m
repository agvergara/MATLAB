%*********************PRACTICA_1B.m**************************
% TITULO:  SIMULACION DE UN AMPLIFICADOR CLASE C
% ASIGNATURA: LABORATORIO DE SIMULACION DE COMUNICACIONES
% GRADO EN INGENIERIA EN SISTEMAS DE TELECOMUNICACION
% ***********************************************************
clear all
clc
p = input('Periodos de la sinusoide: ');
s = input('Escala de graficas espectrales (lin/log): ', 's');

fc = 1000000; %Hz
Ac = 10; %Vpp
fm = 128000000; %Hz
N = 1024; %muestras
L = 1; %V
g = 10; %Ganancia
bw = 1100000; %Hz
Z = 50; %Ohm
[B,A] = butter(7, (bw/(fm/2)), 'low');

%% 1.- Generamos la se�al
% Eje de tiempos
t = [0:1/fm:p*(1/fc)];
% Se�al
x = (Ac/2)*sin(2*pi*fc*t);
% Se�al a la entrada del recortador (espectro y se�al)
figure
plot(t,x)
grid on
title('Se�al a la entrada del recortador')
figure
y = spectrum(x,(1/fm),Z, 'Espectro a la entrada del recortador', s); 

%% 2.- Recortador
xl = recortador(x,L);
% Se�al a la salida del recortador y entrada del amplificador (espectro y se�al)
figure
plot(t,xl)
grid on
title('Se�al a la salida del recortador y entrada del amplificador')
figure
y = spectrum(xl,(1/fm),Z, 'Espectro a la salida del recortador y entrada del amplificador', s); 

%% 3.- Amplificador lineal
xg = xl*g;
% Se�al a la salida del amplificador (espectro y se�al)
figure
plot(t,xg)
grid on
title('Se�al a la salida del amplificador')
figure
y = spectrum(xg,(1/fm),Z, 'Espectro a la salida del amplificador', s); 

%% 4.- Filtrado
% Hallamos la funcion de transferencia del filtro
[H,W] = freqz(B, A, N);
figure
plot(W, abs(H))
grid on
title('Funcion de transferencia del filtro')
% Hallamos la se�al filtrada
XG = fft(xg);
Y = filter(B, A, XG, [], 1);
y = ifft(Y);
figure
plot(t,y)
grid on
title('Se�al filtrada')
figure
y = spectrum(y,(1/fm),Z, 'Espectro de la se�al filtrada', s); 

%% 5.- Diagrama de polos y ceros
polozero(B, A)

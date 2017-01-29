%*********************script_1_c.m**************************
% TITULO: SCRIPT PRACTICA 1_C
% AUTOR: Antonio Gomez Vergara
% ASIGNATURA: LABORATORIO DE SIMULACION DE COMUNICACIONES
% GRADO EN INGENIERIA EN SISTEMAS DE TELECOMUNICACION
%*********************************************************
% Script que debe usarse como guión para la realización
% de la práctica 1C
% CODIFICACION FUENTE
%*********************************************************
% Inicio:
% -------
%
close all
clc,clear
hold off
% Constantes
% ----------
%
fs=1024; % Frecuencia de muestreo
N=128; % Número de muestras
f0=16; % Frecuencia del tono
Ap=1; % Amplitud del tono
b=4; % Número de bits
FE=1; % Fondo de escala de cuantificación
% Cálculos intermedios:
% --------------------
%
t=0:1/fs:(N-1)/fs; % Eje de tiempos
NE=2^b; % Número de escalones
% Señal de entrada:
% -----------------
%
s = input('Escala de graficas espectrales (lin/log): ', 's');
 %f1=20; % Frecuencia del tono 2.
% x=Ap*cos(2*pi*f0*t)+Ap*cos(2*pi*f1*t);
x=Ap*cos(2*pi*f0*t);
%% Señal cuantificada:
% -------------------
%
Qx=cuantif(x,FE,NE);
%% Señal codificada en binario 4 bits:
% -----------------------------------
%
Binx=decabin(Qx,FE,b);
%% Señal a la salida del canal:
% ----------------------------
%
BER=input('Tasa de error, BER:'); % En tanto por uno
[Biny, cherror]=canaldig(Binx, BER);
%% Señales con y sin errores pasadas a decimal:
% --------------------------------------------
%
Decixmal=binadec(Biny,FE,b);
Decixbien=binadec(Binx,FE,b);
%% Señales con y sin errores filtradas paso bajo:
% ----------------------------------------------
%
% Utilizar las funciones butter y filter
% Orden? Impedancia en los espectros?
% [B,A] = butter(7, (bw/(fm/2)), 'low');
% Deciybien = filter(B, A, Decixbien);
% Deciymal = filter(B, A, Decixmal);
%% Representaciones gráficas. Al menos deben aparecer las siguientes:
% ------------------------------------------------------------------
%
% 1. Señal cuantificada
plot(t, Qx)
grid on
title ('Señal cuantificada')
%% 2. Errores introducidos por el canal. Se calcula haciendo la or-exclusiva
% entre la señal a su entrada y la señal a su salida
error = bitxor(Binx, Biny);
%% 3. Señal decimal sin errores en el receptor
figure
plot(t, Decixbien)
grid on
title ('Señal decimal sin errores')
%% 4. Señal decimal con errores en el receptor
figure
plot(t, Decixmal)
grid on
title ('Señal decimal con errores')
%% 5. Densidad espectral de potencia de la señal 3
figure
spectrum(Decixbien, (1/fs), 50, 'D.E.P de señal decimal sin errores', s);
%% 6. Densidad espectral de potencia de la señal 4
figure
spectrum(Decixmal, (1/fs), 50, 'D.E.P de señal decimal con errores', s);
%% 7. Señal sin errores después del filtro
figure
plot(t, Deciybien)
grid on
title ('Señal decimal sin errores filtrada LP')
%% 8. Señal con errores después del filtro
figure
plot(t, Deciymal)
grid onm 
title ('Señal decimal con errores filtrada LP')
%% 9.....otras (a criterio del alumno)
%Para observar que 
%Decixbien y Qx deberían ser iguales o realmente aproximadas
figure
spectrum(Qx, (1/fs), 50, 'D.E.P de señal cuantificada', s); 
% Comparacion entre señales de error generada por el canal y la calculada
% en el punto 2
figure
subplot(2, 1, 1)
spectrum(cherror, (1/fs), 50, 'Señal de error generada', s);
subplot(2, 1, 2)
spectrum(error, (1/fs), 50, 'Señal de error calculada', s);
%%
end
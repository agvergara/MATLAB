%*********************script_1_c.m**************************
% TITULO: SCRIPT PRACTICA 1_C
% AUTOR: Antonio Gomez Vergara
% ASIGNATURA: LABORATORIO DE SIMULACION DE COMUNICACIONES
% GRADO EN INGENIERIA EN SISTEMAS DE TELECOMUNICACION
%*********************************************************
% Script que debe usarse como gui�n para la realizaci�n
% de la pr�ctica 1C
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
N=128; % N�mero de muestras
f0=16; % Frecuencia del tono
Ap=1; % Amplitud del tono
b=4; % N�mero de bits
FE=1; % Fondo de escala de cuantificaci�n
% C�lculos intermedios:
% --------------------
%
t=0:1/fs:(N-1)/fs; % Eje de tiempos
NE=2^b; % N�mero de escalones
% Se�al de entrada:
% -----------------
%
s = input('Escala de graficas espectrales (lin/log): ', 's');
 %f1=20; % Frecuencia del tono 2.
% x=Ap*cos(2*pi*f0*t)+Ap*cos(2*pi*f1*t);
x=Ap*cos(2*pi*f0*t);
%% Se�al cuantificada:
% -------------------
%
Qx=cuantif(x,FE,NE);
%% Se�al codificada en binario 4 bits:
% -----------------------------------
%
Binx=decabin(Qx,FE,b);
%% Se�al a la salida del canal:
% ----------------------------
%
BER=input('Tasa de error, BER:'); % En tanto por uno
[Biny, cherror]=canaldig(Binx, BER);
%% Se�ales con y sin errores pasadas a decimal:
% --------------------------------------------
%
Decixmal=binadec(Biny,FE,b);
Decixbien=binadec(Binx,FE,b);
%% Se�ales con y sin errores filtradas paso bajo:
% ----------------------------------------------
%
% Utilizar las funciones butter y filter
% Orden? Impedancia en los espectros?
% [B,A] = butter(7, (bw/(fm/2)), 'low');
% Deciybien = filter(B, A, Decixbien);
% Deciymal = filter(B, A, Decixmal);
%% Representaciones gr�ficas. Al menos deben aparecer las siguientes:
% ------------------------------------------------------------------
%
% 1. Se�al cuantificada
plot(t, Qx)
grid on
title ('Se�al cuantificada')
%% 2. Errores introducidos por el canal. Se calcula haciendo la or-exclusiva
% entre la se�al a su entrada y la se�al a su salida
error = bitxor(Binx, Biny);
%% 3. Se�al decimal sin errores en el receptor
figure
plot(t, Decixbien)
grid on
title ('Se�al decimal sin errores')
%% 4. Se�al decimal con errores en el receptor
figure
plot(t, Decixmal)
grid on
title ('Se�al decimal con errores')
%% 5. Densidad espectral de potencia de la se�al 3
figure
spectrum(Decixbien, (1/fs), 50, 'D.E.P de se�al decimal sin errores', s);
%% 6. Densidad espectral de potencia de la se�al 4
figure
spectrum(Decixmal, (1/fs), 50, 'D.E.P de se�al decimal con errores', s);
%% 7. Se�al sin errores despu�s del filtro
figure
plot(t, Deciybien)
grid on
title ('Se�al decimal sin errores filtrada LP')
%% 8. Se�al con errores despu�s del filtro
figure
plot(t, Deciymal)
grid onm 
title ('Se�al decimal con errores filtrada LP')
%% 9.....otras (a criterio del alumno)
%Para observar que 
%Decixbien y Qx deber�an ser iguales o realmente aproximadas
figure
spectrum(Qx, (1/fs), 50, 'D.E.P de se�al cuantificada', s); 
% Comparacion entre se�ales de error generada por el canal y la calculada
% en el punto 2
figure
subplot(2, 1, 1)
spectrum(cherror, (1/fs), 50, 'Se�al de error generada', s);
subplot(2, 1, 2)
spectrum(error, (1/fs), 50, 'Se�al de error calculada', s);
%%
end
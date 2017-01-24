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
% f1=20; % Frecuencia del tono 2.
% x=Ap*cos(2*pi*f0*t)+Ap*cos(2*pi*f1*t);
x=Ap*cos(2*pi*f0*t);
%% Señal cuantificada:
% -------------------
%
Qx=cuantif(x,FE,NE);
%sig = sawtooth(t));
%% Señal codificada en binario 4 bits:
% -----------------------------------
%
Binx=decabin(Qx,FE,b);
%% Señal a la salida del canal:
% ----------------------------
%
BER=input('Tasa de error, BER:'); % En tanto por uno
Biny=canaldig(Binx, BER);
%% Señales con y sin errores pasadas a decimal:
% --------------------------------------------
%
Decixmal=binadec(Biny,FE,b);
Decixbien=binadec(Binx,FE,b);
%% Señales con y sin errores filtradas paso bajo:
% ----------------------------------------------
%
% Utilizar las funciones butter y filter
%
%% Representaciones gráficas. Al menos deben aparecer las siguientes:
% ------------------------------------------------------------------
%
% 1. Señal cuantificada
plot(t, Qx)
% 2. Errores introducidos por el canal. Se calcula haciendo la or-exclusiva
% entre la señal a su entrada y la señal a su salida
% 3. Señal decimal sin errores en el receptor
% 4. Señal decimal con errores en el receptor
% 5. Densidad espectral de potencia de la señal 3
% 6. Densidad espectral de potencia de la señal 4
% 7. Señal sin errores después del filtro
% 8. Señal con errores después del filtro
% 9.....otras (a criterio del alumno)
end
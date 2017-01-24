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
% f1=20; % Frecuencia del tono 2.
% x=Ap*cos(2*pi*f0*t)+Ap*cos(2*pi*f1*t);
x=Ap*cos(2*pi*f0*t);
%% Se�al cuantificada:
% -------------------
%
Qx=cuantif(x,FE,NE);
%sig = sawtooth(t));
%% Se�al codificada en binario 4 bits:
% -----------------------------------
%
Binx=decabin(Qx,FE,b);
%% Se�al a la salida del canal:
% ----------------------------
%
BER=input('Tasa de error, BER:'); % En tanto por uno
Biny=canaldig(Binx, BER);
%% Se�ales con y sin errores pasadas a decimal:
% --------------------------------------------
%
Decixmal=binadec(Biny,FE,b);
Decixbien=binadec(Binx,FE,b);
%% Se�ales con y sin errores filtradas paso bajo:
% ----------------------------------------------
%
% Utilizar las funciones butter y filter
%
%% Representaciones gr�ficas. Al menos deben aparecer las siguientes:
% ------------------------------------------------------------------
%
% 1. Se�al cuantificada
plot(t, Qx)
% 2. Errores introducidos por el canal. Se calcula haciendo la or-exclusiva
% entre la se�al a su entrada y la se�al a su salida
% 3. Se�al decimal sin errores en el receptor
% 4. Se�al decimal con errores en el receptor
% 5. Densidad espectral de potencia de la se�al 3
% 6. Densidad espectral de potencia de la se�al 4
% 7. Se�al sin errores despu�s del filtro
% 8. Se�al con errores despu�s del filtro
% 9.....otras (a criterio del alumno)
end
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
% Frecuencia de corte de 32 Hz a la mitad de la frecuencia de muestreo
[B,A] = butter(7, (32/(fs/2)), 'low');
Deciybien = filter(B, A, Decixbien);
Deciymal = filter(B, A, Decixmal);
%% Representaciones gr�ficas. Al menos deben aparecer las siguientes:
% ------------------------------------------------------------------
%
% 1. Se�al cuantificada
plot(t, Qx,'b-')
grid on
title ('Se�al cuantificada')
%% 2. Errores introducidos por el canal. Se calcula haciendo la or-exclusiva
% entre la se�al a su entrada y la se�al a su salida
error = bitxor(Binx, Biny);
%% 3. Se�al decimal sin errores en el receptor
figure
plot(t, Decixbien,'b-')
grid on
title ('Se�al decimal sin errores')
%% 4. Se�al decimal con errores en el receptor
figure
plot(t, Decixmal,'b-')
grid on
title ('Se�al decimal con errores')
%% 5. Densidad espectral de potencia de la se�al 3
% Periodogram calcula una estimaci�n de la D.E.P de la se�al con una
% ventana rectangular de tama�o la longitud de la se�al.
figure
[Pxxbien, Wbien] = periodogram(Decixbien,rectwin(length(Decixbien)),length(Decixbien),fs);
plot(Wbien, Pxxbien,'b-')
grid on
title ('Densidad espectral de potencia de la se�al sin errores')
xlabel('Frecuencia')
ylabel('Densidad espectral de potencia')
%% 6. Densidad espectral de potencia de la se�al 4
figure
[Pxxmal, Wmal] = periodogram(Decixmal,rectwin(length(Decixmal)),length(Decixmal),fs);
plot(Wmal, Pxxmal,'b-')
grid on
title ('Densidad espectral de potencia de la se�al con errores')
xlabel('Frecuencia')
ylabel('Densidad espectral de potencia')
%% 7. Se�al sin errores despu�s del filtro
figure
plot(t, Deciybien,'b-')
grid on
title ('Se�al decimal sin errores filtrada LP')
%% 8. Se�al con errores despu�s del filtro
figure
plot(t, Deciymal,'b-')
grid on 
title ('Se�al decimal con errores filtrada LP')
%% 9.....otras (a criterio del alumno)
%Para observar que las D.E.P de
%Decixbien y Qx deber�an ser iguales o realmente aproximadas
figure
[Pxqx, Wqx] = periodogram(Qx,rectwin(length(Qx)),length(Qx),fs);
plot(Wqx, Pxqx, 'b-')
grid on
title ('Densidad espectral de potencia de la se�al cuantificada')
xlabel('Frecuencia')
ylabel('Densidad espectral de potencia')
% Comparacion entre se�ales de error generada por el canal y la calculada
% en el punto 2
% Siendo "cherror" el vector de error producido por el canal digital y
% "error" el vector de error calculado
figure
title('D.E.P de los errores')
subplot(2, 1, 1)
[Pxche, Wche] = periodogram(cherror,rectwin(length(cherror)),length(cherror),fs);
plot(Wche, Pxche, 'r-')
subplot(2, 1, 2)
[Pxerr, Werr] = periodogram(error,rectwin(length(error)),length(error),fs);
plot(Werr, Pxerr, 'b-')
grid on
% Comparaci�n entre las se�ales Deciymal y Deciybien para ver los efectos
% del canal digital y c�mo el filtro recupera gran parte de la se�al
figure
plot(t, Deciybien, 'r-', 'LineWidth', 2)
hold on
plot(t, Deciymal, 'b-', 'LineWidth', 2)
legend('Deciybien', 'Deciymal')
title('Se�ales obtenidas a la salida del filtro con y sin errores')
grid on
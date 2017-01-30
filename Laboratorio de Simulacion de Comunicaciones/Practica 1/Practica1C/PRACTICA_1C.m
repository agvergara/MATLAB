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
% Frecuencia de corte de 32 Hz a la mitad de la frecuencia de muestreo
[B,A] = butter(7, (32/(fs/2)), 'low');
Deciybien = filter(B, A, Decixbien);
Deciymal = filter(B, A, Decixmal);
%% Representaciones gráficas. Al menos deben aparecer las siguientes:
% ------------------------------------------------------------------
%
% 1. Señal cuantificada
plot(t, Qx,'b-')
grid on
title ('Señal cuantificada')
%% 2. Errores introducidos por el canal. Se calcula haciendo la or-exclusiva
% entre la señal a su entrada y la señal a su salida
error = bitxor(Binx, Biny);
%% 3. Señal decimal sin errores en el receptor
figure
plot(t, Decixbien,'b-')
grid on
title ('Señal decimal sin errores')
%% 4. Señal decimal con errores en el receptor
figure
plot(t, Decixmal,'b-')
grid on
title ('Señal decimal con errores')
%% 5. Densidad espectral de potencia de la señal 3
% Periodogram calcula una estimación de la D.E.P de la señal con una
% ventana rectangular de tamaño la longitud de la señal.
figure
[Pxxbien, Wbien] = periodogram(Decixbien,rectwin(length(Decixbien)),length(Decixbien),fs);
plot(Wbien, Pxxbien,'b-')
grid on
title ('Densidad espectral de potencia de la señal sin errores')
xlabel('Frecuencia')
ylabel('Densidad espectral de potencia')
%% 6. Densidad espectral de potencia de la señal 4
figure
[Pxxmal, Wmal] = periodogram(Decixmal,rectwin(length(Decixmal)),length(Decixmal),fs);
plot(Wmal, Pxxmal,'b-')
grid on
title ('Densidad espectral de potencia de la señal con errores')
xlabel('Frecuencia')
ylabel('Densidad espectral de potencia')
%% 7. Señal sin errores después del filtro
figure
plot(t, Deciybien,'b-')
grid on
title ('Señal decimal sin errores filtrada LP')
%% 8. Señal con errores después del filtro
figure
plot(t, Deciymal,'b-')
grid on 
title ('Señal decimal con errores filtrada LP')
%% 9.....otras (a criterio del alumno)
%Para observar que las D.E.P de
%Decixbien y Qx deberían ser iguales o realmente aproximadas
figure
[Pxqx, Wqx] = periodogram(Qx,rectwin(length(Qx)),length(Qx),fs);
plot(Wqx, Pxqx, 'b-')
grid on
title ('Densidad espectral de potencia de la señal cuantificada')
xlabel('Frecuencia')
ylabel('Densidad espectral de potencia')
% Comparacion entre señales de error generada por el canal y la calculada
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
% Comparación entre las señales Deciymal y Deciybien para ver los efectos
% del canal digital y cómo el filtro recupera gran parte de la señal
figure
plot(t, Deciybien, 'r-', 'LineWidth', 2)
hold on
plot(t, Deciymal, 'b-', 'LineWidth', 2)
legend('Deciybien', 'Deciymal')
title('Señales obtenidas a la salida del filtro con y sin errores')
grid on
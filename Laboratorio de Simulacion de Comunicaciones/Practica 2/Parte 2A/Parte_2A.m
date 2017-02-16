% **********************************************
% Practia 2, parte A: Modulaciones digitales
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%Parámetros para la simulación
simb = 1000;
rolloff = 0.5;
Mmod = [2 4 8 64]; % Orden de modulaciones
sps = [log2(2) log2(4) log2(8) log2(64)]; % Muestras por símbolo
titles = char({'BSPK'; 'QPSK'; '8PSK'; '64QAM'});
titlesSNRpsk = char({'QPSK - SNR 3dB'; 'QPSK - SNR 10dB'; 'QPSK - SNR 20dB'});
titlesSNRqam = char({'64QAM - SNR 3dB'; '64QAM - SNR 10dB'; '64QAM - SNR 20dB'});

%% Parte 2A.1
%Realizamos 4 veces ya que son 4 tipos distintos de modulaciones y las
%señales que obtenemos varían su tamaño, por lo que no podemos meterlas en
%una matriz.
%Utilizamos la funcion "modular.m" (explicada en su archivo) para modular cada vez y devuelve la
%señal resultado, el tamaño del filtro coseno alzado y la modulación
%utilizada para más adelante dibujar la constelacion.
    %% BPSK
        data= randi([0 1], simb*sps(1), 1);
        [signal1, span(1), mod(1)] = modular(Mmod(1), data, sps(1), rolloff);
        y = eyediagram(signal1, round(span(1))); %Representamos los diagramas de ojo
        set(y,'Name',titles(1, :));
    %% QPSK
        data= randi([0 1], simb*sps(2), 1);
        [signal2, span(2), mod(2)] = modular(Mmod(2), data, sps(2), rolloff);
        y = eyediagram(signal2, round(span(2))); %Representamos los diagramas de ojo
        set(y,'Name',titles(2, :));
    %% 8PSK
        data= randi([0 1], simb*sps(3), 1);
        [signal3, span(3), mod(3)] = modular(Mmod(3), data, sps(1), rolloff);
        y = eyediagram(signal3, round(span(3))); %Representamos los diagramas de ojo
        set(y,'Name',titles(3, :));
    %% 64QAM
        data= randi([0 1], simb*sps(4), 1);
        [signal4, span(4), mod(4)] = modular(Mmod(4), data, sps(1), rolloff);
        y = eyediagram(signal4, round(span(4))); %Representamos los diagramas de ojo
        set(y,'Name',titles(4, :));

%% Parte 2A.2
%Realizamos lo mismo que en el apartado anterior con la salvedad de que
%pasamos la función "awgn" que añade un ruido aditivo blanco gaussiano a la
%señal de entrada con una SNR dada en dB y suponiendo una potencia de
%transmisión de 1W.
SNR = [3 10 20]; %SNR a utilizar, en dB
dataqpsk = randi([0 1], simb*sps(2), 1); %Generacion de los datos para QPSK
data64qam = randi([0 1], simb*sps(4), 1); %Generacion de los datos para 64QAM
[signalqpsk, spanqpsk, modqpsk] = modular(4, dataqpsk, sps(2), rolloff); %Modulacion QPSK
[signal64qam, spanqam, modqam] = modular(64, data64qam, sps(4), rolloff); % Modulacion 64QAM
for i=1:length(SNR)
   datanoiseqpsk(i, :) = awgn(signalqpsk, SNR(i)); %Añadimos ruido AWGN a QPSK
   datanoise64qam(i, :) = awgn(signal64qam, SNR(i)); %Añadimos ruido AWGN a 64QAM
   y1 = eyediagram(datanoiseqpsk(i, :), round(spanqpsk)); %Representamos los diagramas de ojo
   set(y1,'Name',titlesSNRpsk(i, :));
   y2 = eyediagram(datanoise64qam(i, :), round(spanqam)); %Representamos los diagramas de ojo
   set(y2,'Name',titlesSNRqam(i, :));
end

%% Parte 2A.3

%% Parte 2A.4

% NOTA:
% https://lost-contact.mit.edu/afs/cs.stanford.edu/pkg/matlab-r2012b/matlab/r2012b/help/comm/ug/scatter-plots.html
% Para poner los bits a las modulaciones

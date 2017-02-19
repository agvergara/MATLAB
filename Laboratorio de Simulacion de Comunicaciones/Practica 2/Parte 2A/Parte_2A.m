% **********************************************
% Practia 2, parte A: Modulaciones digitales
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%Parámetros para la simulación
simb = 1000;
Fd = 1;
Fs = 10; %10 HZ de frecuencia de muestreo
N = Fs/Fd; %
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
        [signal1, mod(1)] = modular(Mmod(1), data, rolloff, Fd, Fs);
        y = eyediagram(signal1, N, 1/Fd); %Representamos los diagramas de ojo
        set(y,'Name',titles(1, :));
    %% QPSK
        data= randi([0 1], simb*sps(2), 1);
        [signal2, mod(2)] = modular(Mmod(2), data, rolloff, Fd, Fs);
        y = eyediagram(signal2, N, 1/Fd); %Representamos los diagramas de ojo
        set(y,'Name',titles(2, :));
    %% 8PSK
        data= randi([0 1], simb*sps(3), 1);
        [signal3, mod(3)] = modular(Mmod(3), data, rolloff, Fd, Fs);
        y = eyediagram(signal3, N, 1/Fd); %Representamos los diagramas de ojo
        set(y,'Name',titles(3, :));
    %% 64QAM
        data= randi([0 1], simb*sps(4), 1);
        [signal4, mod(4)] = modular(Mmod(4), data, rolloff, Fd, Fs);
        y = eyediagram(signal4, N, 1/Fd); %Representamos los diagramas de ojo
        set(y,'Name',titles(4, :));

%% Parte 2A.2
%Realizamos lo mismo que en el apartado anterior con la salvedad de que
%pasamos la función "awgn" que añade un ruido aditivo blanco gaussiano a la
%señal de entrada con una SNR dada en dB y suponiendo una potencia de
%transmisión de 1W.
SNR = [3 10 20]; %SNR a utilizar, en dB
databpsk = randi([0 1], simb*sps(1), 1); %Generacion de los datos para BPSK
dataqpsk = randi([0 1], simb*sps(2), 1); %Generacion de los datos para QPSK
data8psk = randi([0 1], simb*sps(3), 1); %Generacion de los datos para 8PSK
data64qam = randi([0 1], simb*sps(4), 1); %Generacion de los datos para 64QAM
[signalbpsk, modbpsk] = modular(2, databpsk,  rolloff, Fd, Fs); %Modulacion BPSK
[signalqpsk, modqpsk] = modular(4, dataqpsk,  rolloff, Fd, Fs); %Modulacion QPSK
[signal8psk, mod8psk] = modular(8, data8psk,  rolloff, Fd, Fs); %Modulacion 8PSK
[signal64qam, modqam] = modular(64, data64qam,  rolloff, Fd, Fs); % Modulacion 64QAM
for i=1:length(SNR)
   datanoisebpsk(i, :) = awgn(signalbpsk, SNR(i)); %Añadimos ruido AWGN a BPSK
   datanoiseqpsk(i, :) = awgn(signalqpsk, SNR(i)); %Añadimos ruido AWGN a BPSK
   datanoise8psk(i, :) = awgn(signal8psk, SNR(i)); %Añadimos ruido AWGN a QPSK
   datanoise64qam(i, :) = awgn(signal64qam, SNR(i)); %Añadimos ruido AWGN a 64QAM
   y1 = eyediagram(datanoiseqpsk(i, :), N, 1/Fd); %Representamos los diagramas de ojo
   set(y1,'Name',titlesSNRpsk(i, :));
   y2 = eyediagram(datanoise64qam(i, :), N, 1/Fd); %Representamos los diagramas de ojo
   set(y2,'Name',titlesSNRqam(i, :));
end
%% Parte 2A.3
%Las señalse con ruido se obtuvieron en el apartado anterior, simplemente
%se realiza el scatterplot
scatterplot(datanoisebpsk(3,:)); %constelacion BPSK con 20dB de SNR
grid on
title('BSPK 20dB SNR')
scatterplot(datanoiseqpsk(3,:)); %constelacion QPSK con 20dB de SNR
grid on
title('QSPK 20dB SNR')
scatterplot(datanoise8psk(3,:)); %constelacion 8PSK con 20dB de SNR
grid on
title('8SPK 20dB SNR')
scatterplot(datanoise64qam(3,:)); %constelacion 64QAM con 20dB de SNR
grid on
title('64QAM 20dB SNR')
%% Parte 2A.4
taps1 = [1 0.3]; %Taps de multitrayecto 1
taps2 = [1 -0.4 0.25]; %Taps de multitrayecto 2
%Generamos las señales con los taps, como son simulados mediante filtros
%IIR, no tienen coeficiente de filtro 'A' por lo que es 1, simplemente
%tienen coeficientes 'B'
signalmultiqpsk1 = filter(taps1, 1, signalqpsk);
signalmulti64qam1 = filter(taps1, 1, signal64qam);
scatterplot(signalmultiqpsk1); %constelacion QPSK con taps1 de multitrayecto
grid on
title('QSPK con taps [1 0.3]')
scatterplot(signalmulti64qam1); %constelacion QPSK con taps1 de multitrayecto
grid on
title('64QAM con taps [1 0.3]')
signalmultiqpsk2 = filter(taps2, 1, signalqpsk);
signalmulti64qam2 = filter(taps2, 1, signal64qam);
scatterplot(signalmultiqpsk2); %constelacion QPSK con taps1 de multitrayecto
grid on
title('QSPK con taps [1 -0.4 0.25]')
scatterplot(signalmulti64qam2); %constelacion QPSK con taps1 de multitrayecto
grid on
title('64QAM con taps [1 -0.4 0.25]')


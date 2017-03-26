% **********************************************
% Practia 3, ejercicio 4: Estimacion de canal
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%%
%Para crear el simbolo OFDM y hacer su procesado, utilizamos las funciones
%ya creadas con cambios en lo que se devuelve, ya que en este ejercicio hay
%apartados que no nos interesan.
%Variables y generación de los datos:
N = 64; %portadoras
PC = 5; %Prefijo ciclico
Mmod = 4; %QPSK
BW = 100; %Khz
Nb = log2(Mmod) * N * BW; %Bits a transmitir
snr_media = 10; %En dB
ts = 1e-5; %Tiempo de simbolo (s)
fd = 10; %Frecuencia doppler (Hz)
h = [1, 1, 1, 1]; %4 taps con la misma potencia (en amplitud)
pot_chan = abs(h).^2;
pot_chan_dB = 10*log10(pot_chan); %Potencia del canal h en dB
bits = randi([0 1], Nb, 1);
%% Creacion simbolo OFDM
[simbOFDM, modData, mod] = createOFDM(Mmod, bits, N, PC); %Creamos el símbolo OFDM

%% Creamos el canal Rayleigh
[channelRaygh, ganancias] = createRaychan(ts, fd, simbOFDM, snr_media, pot_chan_dB);

%% Realizamos el procesado del simbolo OFDM
[BER, h_elim] = processOFDM(channelRaygh, PC, N, simbOFDM, modData, mod, bits, ganancias, pot_chan_dB);
%Nos interesa la BER y el canal 
disp(['Para una SNR media de 10dB, la BER con canal Rayleigh es: ', num2str(BER)]);

%% Ejercicio 4.1: Pilotos
port1 = 4; %Cada 4 portadoras
inst1 = 5; %Cada 5 instantes
[est_chan_1, ECM_1] = pilotos(port1, inst1, N, h_elim, BW);
%% Representaciones del ejercicio 4.1
% Representamos
figure
subplot(2,1,1)
imagesc(abs(h_elim));
title('Canal original')
subplot(2,1,2)
imagesc(abs(est_chan_1));
title('Canal estimado')
disp(['Error cuadratico medio 1: ', num2str(ECM_1)]);
%% Ejercicio 4.2: Pilotos
port2 = 16; %Cada 16 portadoras
inst2 = 5; %Cada 5 instantes
[est_chan_2, ECM_2] = pilotos(port2, inst2, N, h_elim, BW);
%% Representaciones del ejercicio 4.2
% Representamos
figure
subplot(2,1,1)
imagesc(abs(h_elim));
title('Canal original')
subplot(2,1,2)
imagesc(abs(est_chan_2));
title('Canal estimado')
disp(['Error cuadratico medio 2: ', num2str(ECM_2)]);

%En el caso del ejercicio 4.1, el canal estimado se parece bastante al
%original y obtenemos un ECM muy bajo en cambio, en el 4.2, el canal
%estimado practicamente no se parece en nada al original obteniendo asi un
%ECM bastante mas alto. Por lo que al aumentar la insercion de pilotos de 4
%a 16 portadoras, obtenemos menos precision
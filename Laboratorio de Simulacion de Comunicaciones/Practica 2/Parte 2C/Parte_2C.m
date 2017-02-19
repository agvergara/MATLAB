% **********************************************
% Practia 2, parte C: Efectos del canal
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
simb = 1000;
vector_SNR = (0:1:20);
%% Parte2C.1 Modulacion QPSK para atravesar distintos canales
Mmod = 4; %Orden de modulacion: QPSK
Nb = simb*log2(Mmod); %Numero de bits totales
data= randi([0 1], Nb, 1); %Generacion de bits
%Modulamos
mod = modem.pskmod('M', Mmod, 'SymbolOrder','gray', 'InputType', 'bit');
modData = modulate(mod, data);
% Ahora simulamos los canales, en la funcion "efectocanal.m" está explicado
% el método utilizado
[BERawgn, BERmultisinec, BERdoppsinec] = efectocanal(vector_SNR, modData, data, mod, Nb, simb);
%% Representaciones
semilogy(vector_SNR, BERawgn, '-r')
hold on
semilogy(vector_SNR, BERmultisinec, '-b')
hold on
semilogy(vector_SNR, BERdoppsinec, '-g')
legend ('AWGN', 'Multipath no ecualiz', 'Doppler no ecualiz');
title('Efectos del canal')
xlabel('SNR(dB)');
ylabel('BER');
hold off
%% Parte 2C.2: SNR de 0 a 20dB usando modulaciones BPSK y DBPSK
modbpsk = modem.pskmod('M', 2, 'SymbolOrder','gray', 'InputType', 'bit');
moddbpsk = modem.dpskmod('M', 2, 'SymbolOrder','gray', 'InputType', 'bit');

%Ecualizador ZF https://es.mathworks.com/matlabcentral/fileexchange/39470-zero-forsing-equalizer/content/ZF.m

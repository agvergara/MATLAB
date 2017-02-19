% **********************************************
% Practia 2, parte B: Codificacion de canal
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
% Modulación BPSK
M = 2;
sps = log2(M);
Nb = 10^6; % Numero de bits a transmitir (10^6 simbolos a log2(2) muestras/simbolo) hay 
% tantos bits para que se vean mejor las curvas.
vector_SNR = (0:1:11); % Relaciones señal a ruido
bits = randi([0 1],Nb*sps,1);

%% Sin codificacion de canal
nocodBER = nullenco(bits, Nb, vector_SNR, M);
%% Hamming r = 3
hammingBER3 = hammingenco(bits, Nb, vector_SNR, M, 3);
%% Hamming r = 5
hammingBER5 = hammingenco(bits, Nb, vector_SNR, M, 5);
%% Lineal por bloques 3 bits
linearBER3 = linearrepenco(bits, Nb, vector_SNR, M, 3);
%% Lineal por bloques 5 bits
linearBER5 = linearrepenco(bits, Nb, vector_SNR, M, 5);
%% Plots
figure
semilogy(vector_SNR, nocodBER, '-r');%% Sin codificación de canal
hold on
semilogy(vector_SNR, hammingBER3, '-b');%% Hamming con 3 bits
hold on
semilogy(vector_SNR, hammingBER5, '-g');%% Hamming con 3 bits
hold on
semilogy(vector_SNR, linearBER3, '-c');%% Lineal por bloques de repeticion con 3 bits
hold on
semilogy(vector_SNR, linearBER5, '-m');%% Lineal por bloques de repeticion con 5 bits

legend ('Sin codif', 'Hamming r=3', 'Hamming r=5', 'Lineal r=3', 'Lineal r=5');
title('Tipos de codificacion de canal')
xlabel('SNR(dB)');
ylabel('BER');
hold off
% **********************************************
% Practia 3, ejercicio 7: TDMA
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%% Ejercicio 7.1
BW = 10000; %Ancho de banda, en Hz
SNR_media = 15; %En dB
Mmod1 = 64; %64QAM
Mmod2 = 16; %16QAM
Mmod3 = 4; %4QAM
BER_Umbral = 1e-4;
M = 6; %6 users

mod64 = modem.qammod('M', Mmod1,'SymbolOrder','gray', 'InputType', 'bit');
mod16 = modem.qammod('M', Mmod2,'SymbolOrder','gray', 'InputType', 'bit');
mod4 = modem.qammod('M', Mmod3,'SymbolOrder','gray', 'InputType', 'bit');

users = zeros(1, BW); %Registro de usuarios
Nb_users = zeros(M, 1); %Cantidad de bits a transmitir por cada usuario
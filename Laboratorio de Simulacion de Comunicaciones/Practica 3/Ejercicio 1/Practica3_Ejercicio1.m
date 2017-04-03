% **********************************************
% Practia 3, ejercicio 1: OFDM con 64 portadoras
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
clc
%%
%Variables y generación de los datos:
Potencia_ult = 0.1;
taps = 4;
t_disp = [0:4];
%Generamos un canal con distribución exponencial ya que así nos aseguramos
%que el último rayo tenga 10 veces menos potencia que el primero (suponemos
%que el primer rayo tiene potencia unidad)
h = (nthroot(Potencia_ult,taps)).^t_disp; %Obtenemos la raiz n-ésima (en este caso la raiz cuarta, ya que
% es el numero de taps) para hallar
%el valor para que el ultimo tap tenga 10 veces menos la potencia del
%primero
stem(t_disp, h);

N = 64; %portadoras
PC = 8; %Prefijo cíclico
Mmod = 4; %QPSK
Nb = log2(Mmod) * N * 1000; %Numero de bits a transmitir, un cuarto de millón aproximadamente
snr_media = 10; %En dB
bits = randi([0 1], Nb, 1);
%% Creamos el simbolo OFDM
[simbOFDM, modData, mod] = createOFDM(Mmod, bits, N, PC); %Creamos el símbolo OFDM

%% Creamos el canal a utilizar:
h = h.';
h = sqrt(1/sum(abs(h).^2))*h; % Normalizamos el canal para que la potencia sea unidad
hMulti = filter(h,1,simbOFDM); 
noise = sqrt(1/(2*snr_media)) * (randn(size(hMulti)) + 1i * randn(size(hMulti))); %Creamos el ruido

%% Realizamos el procesamiendo del símbolo OFDM, el receptor sencillo (demodular únicamente) y hayamos la BER de los 3 escenarios
channelMulti = hMulti + noise; %Canal multitrayecto
channelFlat = simbOFDM + noise; %Canal plano

BEROFDM = processOFDM(channelMulti, PC, N, simbOFDM, modData, mod, bits, h); %BER con multitrayecto

hRayoUnico = [h(1); zeros(4,1)]; %Seleccionamos el rayo principal únicamente
BERSC = processOFDM(channelMulti, PC, N, simbOFDM, modData, mod, bits, hRayoUnico); %BER usando solo la primera portadora de OFDM
BERFLAT = processOFDM(channelFlat, PC, N, simbOFDM, modData, mod, bits, hRayoUnico); %BET usando un canal plano

%% Resultados
disp('Para una SNR media de 10dB, los resultados de BER son: ');
disp(['BER con multitrayecto: ', num2str(BEROFDM)]);
disp(['BER usando sólo la primera portadora: ', num2str(BERSC)]);
disp(['BER con canal plano: ', num2str(BERFLAT)]);

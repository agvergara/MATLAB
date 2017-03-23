% **********************************************
% Practia 3, ejercicio 2
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%%
%Supongo los mismos datos que en el ejercicio 1
N = 64; %portadoras
PC = 8; %Prefijo cíclico
Mmod = 4; %QPSK
Nb = log2(Mmod) * N * 1000; %Numero de bits a transmitir, un cuarto de millón aproximadamente
snr_media = 10; %En dB
bits = randi([0 1], Nb, 1);
fd = 250; %Efecto doppler (Hz)
ts = 1e-5; %Tiempo de simbolo (s)
portadoras = randi(64, 1, 4); %Elegimos 4 portadoras al azar
%% Creamos el simbolo OFDM
[simbOFDM, modData, mod, dataPar] = createOFDM(Mmod, bits, N, PC); %Creamos el símbolo OFDM

%% Creamos el canal Rayleigh
[chDoppler, ganancias] = createRaychan(ts, fd, simbOFDM, snr_media);

%% Realizamos el procesado del simbolo OFDM
[dataFFT, y, BER] = processOFDM(chDoppler, PC, N, simbOFDM, modData, mod, bits, ganancias);
%% Con esto, obtenemos todos los datos que necesitamos para responder a las
% 3 cuestiones que nos presenta el ejercicio:
disp(['Para una SNR media de 10dB, la BER con canal Rayleigh es: ', num2str(BER)]);
%% Histograma
k = 1;
figure
for i = portadoras
	snr_port = abs(dataFFT(k,:)).*10;
	subplot(2,2,k)
	hist(snr_port, 40) 
	title(['Portadora: ' num2str(i)])
    k=k+1;
end
%% BER en dichas portadoras:
k = 1;
disp('Para una SNR media de 10dB, la BER en las portadoras elegidas es: ');
for i = portadoras
	%Bits originales en la portadora i.
	dataport = dataPar(i,:);
	bitsport = demodulate(modem.pskdemod(mod), dataport);
	bitsport = bitsport(:);
	%Bits recibidos.
	yRx = y(i,:);
	yDemod = demodulate(modem.pskdemod(mod), yRx);
	yDemod = yDemod(:);
    BERport = mean(abs(yDemod-bitsport));
	disp(['Portadora: ', num2str(i),' ---> BER: ', num2str(BERport)])
 	k=k+1;
end
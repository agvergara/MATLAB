% **********************************************
% Practia 3, ejercicio 5: sistemas MIMO
% Antonio Gomez Vergara - GIST
% **********************************************
close all
clear all
clc
%%
%Parametros:
snr_media = 6; %dB
Ntx = 4; %Antenas en transmision
Ns = 1e5; %Valores a transmitir

%% Creamos el canal Rayleigh:
h = sqrt((10^(snr_media/10))/2)*(randn(Ntx,Ns) + 1i*randn(Ntx,Ns));
% Normalizamos la potencia del canal con la raiz de snr/2 en naturales.
% Para hacer un canal rayleigh sin la funcion Rayleighchan de debe crear
% una distribución gaussiana en la parte real, una distribución gaussiana
% en la parte imaginaria y sumar ambas distribuciones, dando como resultado
% una distribución rayleigh.
% Para hallar el mejor canal en recepción, simplemente buscamos el máximo
% de las 4 antenas disponibles y observamos el histograma.
best_chan = max(h, [], 1); %Asi nos devolverá un vector fila

%% Histograma 4 antenas 
figure
subplot(2,1,1)
histogram(abs(best_chan).^2,100) %Usamos la potencia para representarlo!!
title('Histograma 4 antenas Tx y 1 antena Rx')
xlabel('SNR')

%Histograma 1a antena transmisora
txantenna=h(1,:);
subplot(2,1,2)
histogram(abs(txantenna).^2,100) %Usamos la potencia para representarlo!!
title('Histograma 1 antena Tx y 1 antena Rx')
xlabel('SNR')

% Se observa en el primer histograma que en torno a 6dB se transmite toda
% la potencia ya que es el mejor canal y ganamos en diversidad. Mientras
% que en el segundo caso no existe diversidad alguna ya que se utiliza la
% primera antena para transmitir
% **********************************************
% Practia 3, ejercicio 6: sistemas MIMO
% Antonio Gomez Vergara - GIST
% **********************************************
close all
clear all
clc
%% Ejercicio 6.1
%Parametros:
snr_media = 6; %dB
Ntx = 3; %Antenas en transmision
Nrx = 5; %Antenas en recepción
Ns = 1e5; %Valores a transmitir
%% Creamos el canal Rayleigh:
h = sqrt((10^(snr_media/10))/2)*(randn(Ntx,Nrx,Ns) + 1i*randn(Ntx,Nrx,Ns));
% Normalizamos la potencia del canal con la raiz de snr/2 en naturales.
% Para hacer un canal rayleigh sin la funcion Rayleighchan de debe crear
% una distribución gaussiana en la parte real, una distribución gaussiana
% en la parte imaginaria y sumar ambas distribuciones, dando como resultado
% una distribución rayleigh.
% Tenemos 15 canales posibles (3 en Tx x 5 en Rx), buscamos el mejor
best_chan = max(h, [], 1); % Obtenemos un vector de 3 dimensiones, tenemos que ver el mejor canal
best_chan = max(best_chan); %Ya tenemos el mejor canal, pero seguimos teniendo 3 dimensiones
best_chan = squeeze(best_chan); %Quitamos las dimensiones que son unitarias y nos quedamos únicamente con los 
% valores del mejor canal

select_chan = h(1,:,:); %Elegimos la primera antena en Tx
select_chan = squeeze(select_chan); %Eliminamos dimensiones unitarias
chan_15 = max(select_chan,[],1); %Obtenemos el mejor canal entre 1Tx y 5 Tx

select_chan = h(:,1,:); %Elegimos la primera antena en Rx
select_chan = squeeze(select_chan); %Eliminamos dimensiones unitarias
chan_31 = max(select_chan,[],1); %Obtenemos el mejor canal entre 3Tx y 1Rx

%%
figure
%% Histograma 3Tx y 5Rx
subplot(3,1,1)
histogram(abs(best_chan).^2,100)
title('Histograma 3 antenas Tx y 5 antenas Rx')

%% Histograma 1Tx y 5Rx 
subplot(3,1,2)
histogram(abs(chan_15).^2,100)
title('Histograma 1 antena Tx y 5 antenas Rx')

%% Histograma 3Tx y 1Rx
subplot(3,1,3)
histogram(abs(chan_31).^2,100)
title('Histograma 3 antenas Tx y 1 antena Rx')
xlabel('SNR')

%% Ejercicio 6.2
% Tomamos como datos los mismos del apartado 6.1
% Para realizar el MRC, hacemos descomposición en valores singulares del
% canal equivalente. Utilizamos inclusive el mismo canal generado en el
% apartado anterior
chan_eq = zeros(1, Ns);
for k = 1:Ns
   [U, S, V] = svd(h(:,:,k)); %Descomposición en valores singulares de h
   %Para realizar la descomposición en valores singulares y hacer el
   %beamforming, utilizamos la primera columna de U y V, que son las
   %matrices de conformación (U) y precodificacion (V)
   u = U(:, 1);
   v = V(:, 1);
   chan_eq(k) = (u')*h(:,:,k)*v; %u' = hermitico , u.' = transpuesto  
end
%%
figure;
hist(abs(chan_eq).^2,100);
xlabel('SNR');
title('Beamforming (MRC)');
%% Ejercicio 6.3
%Volvemos a utilizar los mismos canales del apartado 6.1, así ahorramos
%volver a hacer las cuentas. Simplemente pasamos a vector columna: chan_15
%, chan_31 y chan_eq que tambien lo usamos del apartado anterior dado que
%son todos a partir del mismo canal
chan_15 = chan_15.';
chan_31 = chan_31.';
chan_eq = chan_eq.';
%%
Mmod = 8; %8QAM
SNRs = [2 6 10 14 18]; %Vector de SNRs
Nb = log2(8)*Ns; %Numero de bits a transmitir
channels = [best_chan, chan_15, chan_31, chan_eq]; %Canales a usar
mod = modem.qammod('M',Mmod,'SymbolOrder','gray', 'InputType', 'bit');
num_chan = size(channels); %Cuantos canales hay
for w = 1:num_chan(2)
    chann = channels(:,w);
    for n = 1:length(SNRs)
        SNR = SNRs(n);
        BER(w,n) = simulateTXRX(SNR, chann, Nb, mod);
    end
end
%%
disp('La BER obtenida es: ');
disp(['---> Mejor canal (best_chan): ', num2str(BER(1, :))]);
disp(['---> Primera antena TX (chan_15): ', num2str(BER(2, :))]);
disp(['---> Primera antena RX (chan_31): ', num2str(BER(3, :))]);
disp(['---> MRC (chan_eq): ', num2str(BER(4, :))]);
disp('Cada columna representa las distintas SNR para las que se ha calculado la BER, a mas alta, menos BER');
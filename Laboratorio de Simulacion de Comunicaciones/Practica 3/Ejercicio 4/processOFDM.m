function [BER, h_elim] = processOFDM(channel, PC, N, simbOFDM, modData, mod, bits, ganancias, pot_chan)
%Función que, al contrario que createOFDM, hace el procesamiento del
%símbolo OFDM en orden inverso a los bloques que se han creado (para Doppler):
%Hay ligeras diferencias entre procesar en multitrayecto (donde se repiten
%coeficientes del canal con un repmat) a doppler, donde se realiza de otra
%forma
%Bloques:

%%  Conversor serie/paralelo
dataPar = reshape(channel, PC+N, ceil(length(simbOFDM)/(PC+N))); 
canalPar = reshape(ganancias, PC+N,ceil(length(simbOFDM)/(PC+N)), length(pot_chan));
%% Quitamos el prefijo cíclico:
dataNPC = dataPar(PC+1:end,:); % Quitamos el PC, a las filas desde L+1 hasta el final, para todas las columnas
canalNPC = canalPar(PC+1:end,:,:);
%% Realizamos la FFT
dataFFT = sqrt(1/N) * fft(dataNPC, N);

%% Eliminamos los efectos adversos del canal (o se intenta)
h_mean = mean(canalNPC, 1); %Debemos coger un valor que represente a todo el canal, se ha optado por la media
h_mean = squeeze(h_mean); %Quitamos las dimensiones unitarias
h_elim = fft(h_mean.',N); %Se pone una fila de ceros para que la fft se realize por columnas
y = dataFFT./h_elim; %Zero Forcing
% Cada portadora se ve afectada por un coeficiente concreto constante en el
% tiempo

%% Conversor paralelo/serie:
rxData = reshape(y , 1, length(modData)); 

%% Receptor
demodData = demodulate(modem.pskdemod(mod), rxData);
dataRX = demodData(:);

BER = mean(abs(dataRX-bits)); %Hallamos la BER
end
function BER = processOFDM(channel, PC, N, simbOFDM, modData, mod, bits, h)
%Función que, al contrario que createOFDM, hace el procesamiento del
%símbolo OFDM en orden inverso a los bloques que se han creado (para Multitrayecto):
%Hay ligeras diferencias entre procesar en multitrayecto (donde se repiten
%coeficientes del canal con un repmat) a doppler, donde se realiza de otra
%forma
%Bloques:

%%  Conversor serie/paralelo
dataPar = reshape(channel, PC+N, ceil(length(simbOFDM)/(PC+N))); 

%% Quitamos el prefijo cíclico:
dataNPC = dataPar(PC+1:end,:); % Quitamos el PC, a las filas desde L+1 hasta el final, para todas las columnas

%% Realizamos la FFT
dataFFT = sqrt(1/N) * fft(dataNPC, N);

%% Eliminamos los efectos adversos del canal (o se intenta)
h_elim = fft(h, N);
h_elim = repmat (h_elim, 1, length(dataFFT(1,:)));
y = dataFFT./h_elim;
% Cada portadora se ve afectada por un coeficiente concreto constante en el
% tiempo

%% Conversor paralelo/serie:
rxData = reshape(y , 1, length(modData)); 

%% Receptor
demodData = demodulate(modem.pskdemod(mod), rxData);
dataRX = demodData(:);

BER = mean(abs(dataRX-bits)); %Hallamos la BER
end
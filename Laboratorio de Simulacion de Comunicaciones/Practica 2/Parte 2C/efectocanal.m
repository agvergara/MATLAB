function [BERawgn, BERmultisinec, BERdoppsinec] = efectocanal(vector_SNR, modData, data, mod, Nb, simb)
%% AWGN
contador = 1;
%Simulamos un canal AWGN
for SNR = vector_SNR,
   snr = 10^(SNR/10);
   w = (randn(length(modData),1) + 1i.*randn(length(modData),1)) * (1/sqrt(2)) * sqrt(1/snr);
   y = modData + w;
   demoData = demodulate(modem.pskdemod(mod),y);
   %Para calcular la BER, se halla si los datos originales son distintos de
   %los datos demodulados (obtendremos 1 si el valor en una posicion es distinto y 0 si no lo es)
   % Se suma y se divide entre el numero de bits, así se halla el numero de
   % bits erroneo medio.
   BERawgn(contador) = sum((data~=demoData))./Nb;
   contador = contador + 1;  
end
%% Multitrayecto
    taps = [1 -0.3 0.1];
    % y = h*x+n? h = taps, multiqpsk = h*x, n???
    multiqpsk = filter(taps, 1, modData); %Hallamos la señal con multitrayecto
    demomultiData = demodulate(modem.pskdemod(mod),multiqpsk); %Demodulamos la señal para compararla 
    % con los datos originales
    %Hallamos la BER comparando con los datos originales
    for i = vector_SNR
        BERmultisinec(i+1) = sum((data~=demomultiData))./Nb;
    end
 %% Doppler con desvanecimiento Rayleigh
 %El canal Rayleigh sigue una distribución Gaussiana tanto en su parte real
 %como en su parte imaginaria.
  for i = vector_SNR
    h = ((randn(1,simb) + 1i.*randn(1,simb)) * sqrt(1/2))'; %Generacion del canal Rayleigh  
    %Como es un canal plano, simplemente multiplicamos el canal por la señal modulada.
    doppler = h.*modData;
    demodoppData = demodulate(modem.pskdemod(mod),doppler);
    BERdoppsinec(i+1) = sum((data~=demodoppData))./Nb;
  end
end
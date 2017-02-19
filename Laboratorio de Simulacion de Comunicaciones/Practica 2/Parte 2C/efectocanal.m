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
   % bits erroneos, por lo que a mayor SNR, más diferentes serán entre sí,
   % entonces los últimos valores serán 0 o tan proximos a 0 que Matlab no
   % los representa correctamente.
   BERawgn(contador) = sum((data~=demoData))./Nb;
   contador = contador + 1;  
end
%% Multitrayecto
    taps = [1 -0.3 0.1];
    %multiqpsk = filter(taps, 1, modData); %Hallamos la señal con multitrayecto.
    %Utilizamos un filtro IIR para simular el multitrayecto.
    %demomultiData = demodulate(modem.pskdemod(mod),multiqpsk); %Demodulamos la señal para compararla 
    % con los datos originales
    %Hallamos la BER comparando con los datos originales
    for i = vector_SNR
        snr = 10^(SNR/10);
        w = (randn(length(modData),1) + 1i.*randn(length(modData),1)) * (1/sqrt(2)) * sqrt(1/snr);
        h = ((randn(1,simb) + 1i.*randn(1,simb)))';
        multiqpsk = filter(taps, 1, modData);
        multiqpsk = h.*multiqpsk + w;
        demomultiData = demodulate(modem.pskdemod(mod),multiqpsk); %Demodulamos la señal para compararla 
        BERmultisinec(i+1) = sum((data~=demomultiData))./Nb;
    end
 %% Doppler con desvanecimiento Rayleigh
 %El canal Rayleigh sigue una distribución Gaussiana tanto en su parte real
 %como en su parte imaginaria, la suma de ambas distribuciones da como resultado 
 %una distribución Rayleigh en amplitud.
  for i = vector_SNR
    h = ((randn(1,simb) + 1i.*randn(1,simb)))'; %Generacion del canal Rayleigh  
    %Como es un canal plano, simplemente multiplicamos el canal por la señal modulada.
    doppler = h.*modData;
    demodoppData = demodulate(modem.pskdemod(mod),doppler);
    BERdoppsinec(i+1) = sum((data~=demodoppData))./Nb;
  end
end
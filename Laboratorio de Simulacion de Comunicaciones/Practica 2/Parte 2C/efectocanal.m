function [BERawgn, BERmultisinec, BERdoppsinec, BERmulticonec, BERdoppconec] = efectocanal(vector_SNR, modData, data, mod, Nb, simb, ecualizador, flag)
% El parámetro flag se utiliza para ver si es una modulación diferenciar
% PSK o no lo es, para la demodulación de los datos
barra = waitbar(0, 'Calculando efecto de AWGN');
%% AWGN
contador = 1;
%Simulamos un canal AWGN
progreso = 0.0157;
for SNR = vector_SNR,
   snr = 10^(SNR/10);
   w = (randn(length(modData),1) + 1i.*randn(length(modData),1)) * (1/sqrt(2)) * sqrt(1/snr);
   y = modData + w;
   if flag
       demoData = demodulate(modem.dpskdemod(mod), y);
   else
       demoData = demodulate(modem.pskdemod(mod),y);
   end
   %Para calcular la BER, se halla si los datos originales son distintos de
   %los datos demodulados (obtendremos 1 si el valor en una posicion es distinto y 0 si no lo es)
   % Se suma y se divide entre el numero de bits, así se halla el numero de
   % bits erroneos, por lo que a mayor SNR, más diferentes serán entre sí,
   % entonces los últimos valores serán 0 o tan proximos a 0 que Matlab no
   % los representa correctamente.
   BERawgn(contador) = sum((data~=demoData))./Nb;
   contador = contador + 1;
   waitbar(progreso, barra, 'Calculando efecto de AWGN')
   progreso = progreso + 0.0157;
end
%% Multitrayecto
    %La forma de simular el multitrayecto es tener distintos rayos (taps),
    %siendo el rayo con valor 1 el rayo directo y el resto los productos
    %del multitrayecto.
    % Después se filtra con un filtro IIR para ver su respuesta a lo largo
    % del tiempo
    taps = [1 -0.3 0.1];
    multiqpsk = filter(taps, 1, modData);
    %Utilizamos un filtro IIR para simular el multitrayecto.
    %demomultiData = demodulate(modem.pskdemod(mod),multiqpsk); %Demodulamos la señal para compararla 
    % con los datos originales
    %Hallamos la BER comparando con los datos originales
    for i = vector_SNR
        snr = 10^(i/10);
        multiqpsk = filter(taps, 1, modData);
        w = (randn(length(modData),1) + 1i.*randn(length(modData),1)) * (1/sqrt(2)) * sqrt(1/snr);
        y = multiqpsk + w;
        yecual = equalize(ecualizador, y, modData); %Ecualizamos
        if flag
            demomultiData = demodulate(modem.dpskdemod(mod),y); %Demodulamos la señal para compararla (Para mod diferenciales)
            demomultiDataec = demodulate(modem.dpskdemod(mod),yecual); %Demodulamos la señal para compararla (Para mod diferenciales)
        else
            demomultiData = demodulate(modem.pskdemod(mod),y); %Demodulamos la señal para compararla 
            demomultiDataec = demodulate(modem.pskdemod(mod),yecual); %Demodulamos la señal para compararla 
        end
        BERmultisinec(i+1) = sum((data~=demomultiData))./Nb;
        BERmulticonec(i+1) = sum((data~=demomultiDataec))./Nb;
        waitbar(progreso, barra, 'Calculando efecto de multitrayecto')
        progreso = progreso + 0.0157;
    end
 %% Doppler con desvanecimiento Rayleigh
 %El canal Rayleigh sigue una distribución Gaussiana tanto en su parte real
 %como en su parte imaginaria, la suma de ambas distribuciones da como resultado 
 %una distribución Rayleigh en amplitud.
  h = (randn(length(modData),1) + 1i.*randn(length(modData),1)) * sqrt(1/2); %Generacion del canal Rayleigh  
  doppler = modData.*h;    %Multiplicamos el canal por la señal modulada.
  for i = vector_SNR
    %Generamos el ruido
    y = awgn(doppler, i);
    yecual = y./h; %Ecualizamos, es otra forma de ecualizar, pero para ver los efectos nos sirve.
    if flag
        demodoppData = demodulate(modem.dpskdemod(mod),y); %Modulaciones DPSK
        demoddopec = demodulate(modem.dpskdemod(mod),yecual); %Modulaciones DPSK
    else
        demodoppData = demodulate(modem.pskdemod(mod),y);
        demoddopec = demodulate(modem.pskdemod(mod),yecual);
    end
    BERdoppsinec(i+1) = sum((data~=demodoppData))./Nb;
    BERdoppconec(i+1) = sum((data~=demoddopec))./Nb;
    waitbar(progreso, barra, 'Calculando efecto de doppler')
    progreso = progreso + 0.0157;
  end
close(barra)
end
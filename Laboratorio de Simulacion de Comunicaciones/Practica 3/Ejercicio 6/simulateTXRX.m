function BER = simulateTXRX(SNR, chann, Nb, mod)
        %Transmisor
        bits = randi([0 1], Nb, 1);
        modData = modulate(mod, bits);
        Energia = mean(abs(modData).^2); %Energía simbolos
        modData = (1/sqrt(Energia)).*modData; %Normalizamos la energia
        
        % Ruido
        snr = 10^(SNR/10);
        noise = (randn(size(modData)) + 1i*randn(size(modData)))/sqrt(2*snr);
        % Canal
        y = modData.*chann + noise;

        % Recepcion
        yRx = y./chann; %Zero Forcing

        % Demodulamos
        demodData = demodulate(modem.qamdemod(mod),yRx);
        demodData = demodData(:);
        BER = mean(abs(demodData-bits));
end
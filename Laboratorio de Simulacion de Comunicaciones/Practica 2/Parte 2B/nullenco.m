function BER = nullenco(bits, Nb, vector_SNR, ordenmod)
    Ax = modem.pskmod('M',ordenmod,'SymbolOrder','gray', 'InputType', 'bit'); % Objeto modulador
    BER = zeros(size(vector_SNR)); %Inicializamos el vector de la BER
    contador = 1;
    for SNR = vector_SNR,
            % Modulaci�n
            x = modulate(Ax, bits);
            % Generaci�n del ruido AWGN
            snr = 10^(SNR/10);
            w = (randn(length(x),1) + 1i.*randn(length(x),1)) * (1/sqrt(2)) * sqrt(1/snr);
            % Introducimos la se�al en el canal.
            y = x + w;
            % Demodulacion
            br = demodulate(modem.pskdemod(Ax),y);
            % C�lculo de la BER
            % Ajustamos la se�al decodificada a la longitud de los bits
            BER(contador) = sum((bits~=br(1:length(bits))))./Nb;
            contador = contador + 1;    
    end
end
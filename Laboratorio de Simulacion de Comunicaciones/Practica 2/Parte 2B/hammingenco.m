function [BER, y, y2] = hammingenco(bits, Nb, vector_SNR, ordenmod, r)
    [H, G, n, k] = hammgen(r); % Generamos la matriz generadora G y los coeficientes (n,k)
    % dado un r. H se utiliza para hallar la tabla de síndromes que no
    % utilizaremos en este caso.
    Ax = modem.pskmod('M',ordenmod,'SymbolOrder','gray', 'InputType', 'bit'); % Objeto modulador
    BER = zeros(size(vector_SNR)); %BER
    contador = 1;
    % Bucle con los valores de SNR de 0 a 10 dB
    for SNR = vector_SNR,
        % Codificacion 
        b_cod = encode(bits,n,k,'hamming/binary');
        % Modulación
        x = modulate(Ax, b_cod);
        % Generación del ruido AWGN
        snr = 10^(SNR/10);
        w = (randn(length(x),1) + 1i.*randn(length(x),1)) * (1/sqrt(2)) * sqrt(1/snr);
        % Introducimos la señal en el canal.
        y = x + w;
        %y2 = 10.^((awgn(x, SNR))/10);
        % Demodulacion
        br = demodulate(modem.pskdemod(Ax),y);
        %Decodificacion
        b_decod = decode(br,n,k,'hamming/binary');
        % Cálculo de la BER
        % Ajustamos la señal decodificada a la longitud de los bits
        BER(contador) = sum((bits~=b_decod(1:length(bits))))./Nb;
        contador = contador + 1;    
    end
end
function BER = linearrepenco(bits, Nb, vector_SNR, ordenmod, r)
    if r == 3
        n = 3; %Veces a repetir por k bits de informacion
        G = [1 1 1]; %Repeticion del mensaje
    elseif r == 5
        n = 5; %Veces a repetir por k bits de informacion
        G = [1 1 1 1 1]; %Repeticion del mensaje
    end
    k = 1; %Queremos que se repita 3 y 5 veces el bit por cada bit de información, es decir (3,1) y (5,1)
    %Obtenemos la modulación
    Ax = modem.pskmod('M',ordenmod,'SymbolOrder','gray', 'InputType', 'bit'); 
    BER = zeros(size(vector_SNR));
    contador = 1;
    % Bucle con los valores de SNR de 0 a 10 dB
    for SNR = vector_SNR,
        % Codificacion 
        b_cod = encode(bits,n,k,'linear/binary', G);
        % Modulación
        x = modulate(Ax, b_cod);
        % Generación del ruido AWGN
        snr = 10^(SNR/10);
        w = (randn(length(x),1) + 1i.*randn(length(x),1)) * (1/sqrt(2)) * sqrt(1/snr);
        % Introducimos la señal en el canal.
        y = x + w;
        % Demodulacion
        br = demodulate(modem.pskdemod(Ax),y);
        %Decodificacion
        b_decod = decode(br,n,k,'linear/binary', G);
        % Cálculo de la BER
        % Ajustamos la señal decodificada a la longitud de los bits
        BER(contador) = sum((bits~=b_decod))./Nb;
        contador = contador + 1;    
    end
end
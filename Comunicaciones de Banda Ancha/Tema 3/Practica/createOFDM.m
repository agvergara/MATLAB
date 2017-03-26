function dataIFFT = createOFDM(Mmod, bits, N, s)
%Transmisor
%Modulador
if (s == 'psk')
    mod = modem.pskmod('M',Mmod,'SymbolOrder','gray', 'InputType', 'bit');
elseif (s == 'qam')
    mod = modem.qammod('M',Mmod,'SymbolOrder','gray', 'InputType', 'bit');
end
modData = modulate(mod, bits) * sqrt(1/2);
%Procesamiento OFDM
%Bloques (conversor S/P)
dataOFDM = reshape(modData, N, ceil(length(modData)/N));
%DFT (inversa)
dataIFFT = sqrt(N) * ifft(dataOFDM,N);
%Bloques (conversor P/S)
dataIFFT = dataIFFT(:);
end
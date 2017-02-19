function [signal, mod] = modular(Mmod, data, rolloff, Fd, Fs)
    %Creamos un objeto de modulación para utilizar posteriormente para
    %dibujar la constelación.
    %Depende de si es 64QAM o PSK, se mira el orden de la modulación y se
    %escoge en cada caso
    if Mmod == 64
            mod = modem.qammod('M', Mmod, 'SymbolOrder','gray', 'InputType', 'bit');
    else
            mod = modem.pskmod('M', Mmod, 'SymbolOrder','gray', 'InputType', 'bit');
    end
    modData = modulate(mod, data);
    % La funcion rcosflt toma como parametros de entrada:
    % señal de entrada modulada (modData)
    % Factor de sobremuestreo (Fd)
    % frecuencia de muestreo (Fs)
    % tipo de filtro (fir)
    % factor de rolloff (0,5)
    % delay (ninguno)
    signal = rcosflt(modData, Fd, Fs, 'fir/normal', rolloff, []);
end
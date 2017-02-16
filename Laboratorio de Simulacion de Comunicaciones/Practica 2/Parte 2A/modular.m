function [signal, span, mod] = modular(Mmod, data, sps, rolloff)
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
    % La funcion rcosdesign toma como parametros de entrada:
    % factor de roll-off
    % longitud del filtro 
    % bits por simbolo requeridos en la modulacion
    span = Mmod/sps; %Según la ayuda de Matlab, el orden del filtro es igual 
    % a la multiplicación de las muestras por símbolo por la longitud del
    % filtro
    h_cos = rcosdesign(rolloff, span, sps);
    % La funcion upfirdn interpola con un factor y luego lo quita, si no se
    % pone nada, lo hace sobre un factor 1/1, es decir, sólo aplica el filtro
    signal = upfirdn(modData, h_cos);
end
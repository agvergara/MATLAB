function [INDEX, Qx] = cuantif(signal, fescala, nivcuant)
    % Para hallar el tamaño de la particion, tendremos que el valor del
    % escalón
    A = 2*fescala/nivcuant;
    % Calculamos cada cuánto tenemos un escalón
    partition = [-fescala+A:A:fescala-A];
    % Calculamos los valores del eje Y para los que habrá una subida/bajada del
    % escalón y, a su vez, quitamos el offset para cuadrarlo en 0
    codebook = [-fescala+(A/2):A:fescala];
    % Y podemos cuantificar la señal
    [INDEX,Qx] = quantiz(signal,partition,codebook);
end
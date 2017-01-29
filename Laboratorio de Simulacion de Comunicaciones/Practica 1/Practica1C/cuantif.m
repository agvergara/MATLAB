function Qx = cuantif(signal, fescala, nivcuant)
    % Para hallar el tamaño de la particion, tendremos que calcular cuanto dura el escalon
    A = 2*fescala/nivcuant;
    % Calculamos cuanto es cada escalon
    partition = [-fescala+A:A:fescala-A];
    % Calculamos los valores del eje X para los que habrá una subida/bajada del
    % escalon
    codebook = [-fescala+(A/2):A:fescala];
    % Y podemos cuantificar la señal
    [~,Qx] = quantiz(signal,partition,codebook);
end
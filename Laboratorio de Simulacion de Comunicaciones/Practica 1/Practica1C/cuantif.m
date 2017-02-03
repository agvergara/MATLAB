function [INDEX, Qx] = cuantif(signal, fescala, nivcuant)
    % Para hallar el tama�o de la particion, tendremos que el valor del
    % escal�n
    A = 2*fescala/nivcuant;
    % Calculamos cada cu�nto tenemos un escal�n
    partition = [-fescala+A:A:fescala-A];
    % Calculamos los valores del eje Y para los que habr� una subida/bajada del
    % escal�n y, a su vez, quitamos el offset para cuadrarlo en 0
    codebook = [-fescala+(A/2):A:fescala];
    % Y podemos cuantificar la se�al
    [INDEX,Qx] = quantiz(signal,partition,codebook);
end
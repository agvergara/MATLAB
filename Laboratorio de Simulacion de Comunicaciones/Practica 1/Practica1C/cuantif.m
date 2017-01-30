function Qx = cuantif(signal, fescala, nivcuant)
<<<<<<< HEAD
    % Para hallar el tamaño de la particion, tendremos que el valor del
    % escalón
    A = 2*fescala/nivcuant;
    % Calculamos cada cuánto tenemos un escalón
    partition = [-fescala+A:A:fescala-A];
    % Calculamos los valores del eje Y para los que habrá una subida/bajada del
    % escalón y, a su vez, quitamos el offset para cuadrarlo en 0
    codebook = [-fescala+(A/2):A:fescala];
=======
    % Para hallar el tamaño de la particion, tendremos que calcular cuanto dura el escalon
    A = 2 * fescala / nivcuant;
    % Calculamos los valores del eje X para los que habrá una subida/bajada del
    % escalon
    partition = [-fescala+A : A : fescala-A];
    % Y con ello podemos calcular el total de muestras, un codebook
    codebook = [-fescala + A/2 : A : fescala];
>>>>>>> origin/master
    % Y podemos cuantificar la señal
    [~,Qx] = quantiz(signal,partition,codebook);
end
function Qx = cuantif(signal, fescala, nivcuant);
    % Para hallar el tama�o de la particion, tendremos que calcular cuanto vale
    % el tama�o del escalon
    A = 2 * fescala / nivcuant;
    % Calculamos los valores del eje X para los que habr� una subida/bajada del
    % escalon
    partition = [-fescala+A : A : fescala-A];
    % Y con ello podemos calcular el total de muestras, un codebook
    codebook = [-fescala + A/2 : A : fescala];
    % Y podemos cuantificar la se�al
    [~,Qx] = quantiz(signal,partition,codebook);
end
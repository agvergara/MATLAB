function Binx = decabin(Qx, FE, b, INDEX)
    aux = 0;
    contador = 1;
    % Utilizando la función "dec2bin" convertimos un numero entero en un
    % número binario, como los índices devueltos por la función "quantiz"
    % van de 0 a 15 por ser 16 niveles de cuantificación, obtendremos que
    % el número 0 está asociado a los bits "0000" y el número 15 está
    % asociado a los bits "1111"
    for i=1:length(Qx)
       aux = dec2bin(INDEX(i), b);
       for k=1:b
           Binx(contador) = str2num(aux(k));
           contador = contador + 1;
       end
    end
end
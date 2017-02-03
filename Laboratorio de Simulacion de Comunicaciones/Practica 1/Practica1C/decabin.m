function Binx = decabin(Qx, FE, b, INDEX)
    aux = 0;
    contador = 1;
    % Utilizando la funci�n "dec2bin" convertimos un numero entero en un
    % n�mero binario, como los �ndices devueltos por la funci�n "quantiz"
    % van de 0 a 15 por ser 16 niveles de cuantificaci�n, obtendremos que
    % el n�mero 0 est� asociado a los bits "0000" y el n�mero 15 est�
    % asociado a los bits "1111"
    for i=1:length(Qx)
       aux = dec2bin(INDEX(i), b);
       for k=1:b
           Binx(contador) = str2num(aux(k));
           contador = contador + 1;
       end
    end
end
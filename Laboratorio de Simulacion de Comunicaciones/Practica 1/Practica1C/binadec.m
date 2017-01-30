function signal = binadec(bsignal, ~, b)
    % El siguiente código va iterando desde 1 hasta la longitud que debe tener
    % la señal que devuelte (signal) y, dentro del bucle, va obteniendo de 4 en 4 bits
    % de la señal de entrada (bsignal) para así calcular el numero decimal que
    % corresponde al numero binario, siendo el primer bit el de signo y los
    % otros 3 de informacion
    counter = 1;
    sign = 1;
    exp = 0;
    %aux = 0;
    %aux2 = [0 0 0 0 0];
    aux3 = [0 0 0 0 0];
    bits = [0 0 0 0];
    len = length(bsignal)/b;
    signal = zeros(1, len);
    for i=1:len
       %Obtenemos de 4 en 4 bits
       for w=1:b
           bits(w) = bsignal(counter);
           counter = counter + 1;
       end
       %Obtenemos el signo del numero
       if bits(1) == 0
           sign = -1;
       end
       %Calculamos el exponente sobre el cual debemos calcular el numero
       %decimal a partir del binario puede haber dos exponentes distintos 2^-1
       %y 2^-2, en función de esto se añadirán 1 ó 2 ceros a la derecha
       aux = bits(2) - log2(b);
       if aux == -1
           aux2 = [0 1 bits(3) bits(4) 0];
       else
           aux2 = [0 0 1 bits(3) bits(4)];
       end
       % Calculamos cuánto vale cada posición de los bits obtenidos
       % anteriormente
       for k=1:length(aux2);
           aux3(k) = ((2^exp)* aux2(k));
           exp = exp - 1;
       end
       %Obtenemos el número final
       signal(i) = sum(aux3) * sign;
       exp = 0;
       sign = 1;
    end
end
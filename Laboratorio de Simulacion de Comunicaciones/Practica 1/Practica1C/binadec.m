function signal = binadec(chsignal, FE, b, NE);
    A = 2*FE/NE; % Tamaño del escalon
    max = FE - (A/2); % Máximo de la señal
    min = -1 * max; % Por ende, el minimo será el contrario
    % Diccionario: Key son valores codificados con NE escalones y value el
    % valor que le corresponde
    key = [0:1:NE-1];
    value = [min:A:max];
    % Argumentos adicionales
    aux = 0;
    bits = [0 0 0 0];
    counter = 1;
    len = length(chsignal)/b; %Longitud de la señal de salida
    signal = zeros(1, len); % Señal de salida
    for i=1:len
        %Obtenemos de 4 en 4 bits
       for w=1:b
           bits(w) = chsignal(counter);
           counter = counter + 1;
       end
       % Convertimos otra vez a decimal, esto nos devolverá un valor de 0 a
       % 15, es decir, los índices usados para cuantificar (16 niveles)
       aux = bin2dec(num2str(bits));
       % Usando el diccionario, obtenemos que para una key dada (por
       % ejemplo 0 que sería el valor más bajo de la señal) obtenemos un
       % value asociado a 0, es decir, el mínimo de la señal
       for k = 1:length(key)
           if aux == key(k)
               aux = value(k);
           end
       end
       signal(i) = aux; 
end
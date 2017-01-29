function [Biny, cherror] = canaldig(Binx, BER)
    %Numero de bits a modificar
    Nbe = round(BER * length(Binx));
    % El siguiente codigo genera un vector de 0 y, posteriormente dentro del
    % bucle se van generando numeros aleatorios, cuando al redondear es 1 se
    % pone un 1 en la posicion i del vector de error, mientras que si es 0 no
    % se hace nada. El bucle sigue iterando hasta que tengamos Nbe bits
    % erroneos, si se llega al final del vector de error y no se ha conseguido
    % Nbe bits erroneos, se vuelve a empezar desde el principio del vector de
    % error con la salvedad de que si un bit esta cambiado (puesto a 1) se
    % mantiene y sigue buscando una posicion a 0 para cambiar el bit.
    i = 1;
    contador = 1;
    cherror = zeros(1, length(Binx));
    while contador <= Nbe
       rnd = rand(1);
       if round(rnd)
           if cherror(i) == 0
               cherror(i) = 1;
               contador = contador + 1;
           end
       end
       i = i + 1;
       if i > length(cherror)
           i = 1;
       end
    end
        % La funcion bitor hace el OR entre la señal de entrada Binx y 
        % el error que genera el canal.
    for i=1:length(Binx)
        Biny(i) = bitxor(Binx(i), cherror(i));
    end
end
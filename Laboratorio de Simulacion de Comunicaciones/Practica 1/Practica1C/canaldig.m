function [Biny, cherror] = canaldig(Binx, BER)
    rng('default');
    %Numero de bits a modificar
    Nbe = round(BER * length(Binx));
        % El siguiente código genera un vector de 0 y, dentro del
        % bucle se van generando numeros aleatorios, cuando al redondear es 1 se
        % pone un 1 en la posicion i del vector de error, mientras que si es 0 no
        % se hace nada. El bucle sigue iterando hasta que tengamos Nbe bits
        % erróneos, si un bit esta cambiado (puesto a 1) se
        % mantiene y sigue buscando una posicion a 0 para cambiar el bit.
        % NOTA: No es conveniente poner una BER > 0.9 ya que entonces el
        % programa tardará unos 2-3 minutos intentando encontrar posiciones
        % disponibles para poner errores
   contador = 1;
   cherror = zeros(1, length(Binx));
   %Igualamos la señal de salida a la de la entrada ya que sería lo ideal
   Biny = Binx;
   while contador <= Nbe
        rng('shuffle');
        random = rand(1);
        pos = randi([1,length(Binx)], 1);
        if round(random)
           if cherror(pos) == 0
               cherror(pos) = 1;
               contador = contador + 1;
           end
        end
    end
        % La funcion bitor hace el OR entre la señal de entrada Binx y 
        % el error que genera el canal.
    for i=1:length(Binx)
        Biny(i) = bitxor(Binx(i), cherror(i));
    end
end
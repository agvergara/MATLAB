function Binx = decabin(Qx, FE, b);
    j = 1;
    aux = [0 0 0 0];
    % Esta parte de la funcion nos devuelve:
    % 1 bit de signo (el primero)
    % 3 bits de informacion calculados en la funcion 'bin' explicada mas
    % abajo
    for i = 1:length(Qx)
        aux2 = Qx(i);
        % Obtenemos el signo del n�mero y llamamos a la funci�n 'bin'
        if Qx(i) > 0
            aux(1) = 1;
            aux = bin(aux, b, aux2);
        else
           aux2 = aux2*(-1);
           aux = bin(aux, b, aux2);
        end
        for w = 1:length(aux)
            Binx(j) = aux(w);
            j = length(Binx) + 1;
        end
        aux = [0 0 0 0];
    end
    % Funci�n que calcula el n�mero binario de un numero decimal
    % La funci�n va obteniendo desde 2 hasta b bits (ya que el primer bit
    % es de signo) el bit asignado a cada valor. Para calcularlo se
    % multiplica el n�mero por 2 y se observa si es mayor que uno y se le
    % asigna el bit 1 y se le resta 1 o si por el contrario es menor que 1
    % y se le asigna el bit 0 y se vuelve a iterar hasta obtener b bits.
    % En caso de que el n�mero sea exacto igual a 1 se le asigna 1 y el
    % bucle se detiene.
    function aux = bin(aux, b,aux2)
         for k=2:b 
            aux2 = aux2 * 2;
            if aux2 == 1
                aux(k) = 1;
                break
            elseif aux2 > 1
                aux(k) = 1;
                aux2 = aux2 - 1;
            elseif aux2 < 1
                aux(k) = 0;
            end
         end
    end
end
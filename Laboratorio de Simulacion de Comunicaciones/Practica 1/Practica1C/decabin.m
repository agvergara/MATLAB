function Binx = decabin(Qx, FE, b);
    contador = 1;
    j = 1;
    aux = [0 0 0 0];
    % Esta parte de la funcion nos devuelve:
    % 1 bit de signo (el primero)
    % 3 bits de informacion calculados en la funcion 'bin' explicada mas
    % abajo
    for i = 1:length(Qx)
        aux2 = Qx(i);
        if Qx(i) > 0
            aux = bin(aux, b, contador, i, aux2);
        else
           aux(1) = 1;
           aux2 = aux2*(-1);
           aux = bin(aux, b, contador, i, aux2);
        end
        for w = 1:length(aux)
            Binx(j) = aux(w);
            j = length(Binx) + 1;
        end
        contador = 1;
    end
    
    % Funcion que calcula el numero binario de un numero decimal
    function aux = bin(aux, b, contador, i, aux2);
         while (contador+1) <= b
                aux2 = aux2 * 2;
                if aux2 == 1
                    aux(contador) = 1;
                elseif aux2 > 1
                    aux(contador) = 1;
                    aux2 = aux2 - 1;
                else
                    aux(contador) = 0;
                end
                contador = contador + 1;
            end
    end
end
function Binx = decabin(Qx, ~, b)
    j = 1;
    aux = [0 0 0 0];
    % Esta parte de la funcion nos devuelve:
    % 1 bit de signo (el primero)
    % 3 bits de informacion calculados en la funcion 'bin' explicada mas
    % abajo
    for i = 1:length(Qx)
        aux2 = Qx(i);
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
    
    % Funcion que calcula el numero binario de un numero decimal
    function aux = bin(aux, b,aux2)
         for k=2:b 
            aux2 = aux2 * 2;
            if aux2 == 1
                aux(k) = 1;
            elseif aux2 > 1
                aux(k) = 1;
                aux2 = aux2 - 1;
            elseif aux2 <= 0
                aux(k) = 0;
            end
         end
    end
end
function [val_1, val_2] = confianza(estimador, k)
        % Los intervalos irán desde el intervalo k hasta el final del estimador - k
        % Los valores a utilizar seran: El primero del estimador ML y el
        % último, asi obtenemos el intervalo de confianza de W0 y Vy
       ML = estimador(k+1:end-k);
       val_1 = ML(1);
       val_2 = ML(end);
end
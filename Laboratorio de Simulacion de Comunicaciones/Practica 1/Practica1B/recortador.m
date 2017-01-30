function xl = recortador(x, L)
%Funcion que, dado un umbral 'L', reduce la parte positiva de la señal en L
%unidades y la negativa la pone a 0
    l = length(x);
    for i = 1:l
         if x(i) >= L
             xl(i) = x(i) - L;
         else
             xl(i) = 0;
         end
    end
end
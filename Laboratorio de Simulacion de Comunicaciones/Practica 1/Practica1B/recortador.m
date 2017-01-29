function xl = recortador(x, L)
    l = length(x);
    for i = 1:l
         if x(i) >= L
             xl(i) = x(i) - L;
         else
             xl(i) = 0;
         end
    end
end
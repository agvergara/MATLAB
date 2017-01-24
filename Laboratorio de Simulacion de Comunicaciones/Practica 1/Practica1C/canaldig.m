function Biny = canaldig(Binx, BER)
%Numero de bits a modificar
Nbe = round(BER * length(Binx));
% Generamos una secuencia aleatoria mediante una distribución uniforme
% entre 0 y 1
rnd = rand(1, Nbe);
% Las siguientes lineas de codigo generan un numero aleatorio segun una
% distribucion uniforme [0,1] y, mientras que al redondear ese numero
% aleatorio sea 1, se modifica dicho bit, si no sigue. Es decir, modifica
% aleatoriamente bits con un numero aleatorio. Si llega al final del
% vector y no se han modificado Nbe bits, vuelve a empezar.
i = 1;
contador = 1;
% Igualamos para que la señal de salida sea igual a la de la entrada, que
% seria lo ideal, pero en el bucle la modificamos.
Biny = Binx;
while contador <= Nbe
   rnd = rand(1);
   if round(rnd)
       Biny(i) = Biny(i) * rnd;
       contador = contador + 1;
   end
   i = i + 1;
   if i > length(Biny)
       i = 1;
   end
end
end
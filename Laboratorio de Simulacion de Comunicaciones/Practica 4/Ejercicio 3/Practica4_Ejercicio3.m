% **********************************************
% Practia 4, ejercicio 3: Bootstrap
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%% Ejercicio 3.1
% Para realizar el método bootstrap, lo primero de todo es hacer un
% remuestreo aleatorio, es decir, coger N muestras de un vector de muestras
% y colocarlas aleatoriamente
load('Muestras_Hito3.mat'); %Nuestro vector de muestras
Nm_Bootstrap = 1000; %Muestras bootstrap
confianza = [0.1, 0.05, 0.01]; %Intervalos de confianza (90%, 95%, 99%)

n = 1;
for k = 1:Nm_Bootstrap
    bootstrap = datasample(X, length(X)); %Esto remuestreara y aleatorizara las muestras
    media_bootstrap(k) = mean(bootstrap);
    var_bootrstrap(k) = var(bootstrap);
end

boots_sorted_mean = sort(media_bootstrap);
boots_sorted_var = sort(var_bootrstrap);
n = 1;
for k = confianza
       %Hallamos los intervalos de confianza
       val_1 = (k * Nm_Bootstrap * 0.5); 
       val_2 = Nm_Bootstrap - val_1;
       first_val_mean(n, :) = boots_sorted_mean(val_1);
       last_val_mean(n, :) = boots_sorted_mean(val_2);
       first_val_var(n, :) = boots_sorted_var(val_1);
       last_val_var(n, :) = boots_sorted_var(val_2);
       n = n + 1;
end
disp('Tabla con intervalos de confianza de la media: ');
disp(' ');
tabla_conf_media = table(first_val_mean, last_val_mean, 'RowNames', {'90%', '95%', '99%'}, 'VariableNames', {'Primer_valor', 'Segundo_valor'});
disp(tabla_conf_media)
disp('Tabla con intervalos de confianza de la varianza: ');
disp(' ');
tabla_conf_var = table(first_val_var, last_val_var, 'RowNames', {'90%', '95%', '99%'}, 'VariableNames', {'Primer_valor', 'Segundo_valor'});
disp(tabla_conf_var)

%% Histograma media y varianza bootstrap
figure
subplot(2,1,1)
histogram(media_bootstrap, 100)
title('Histograma media Bootstrap')
subplot(2,1,2)
histogram(var_bootrstrap, 100)
title('Histograma varianza Bootstrap')

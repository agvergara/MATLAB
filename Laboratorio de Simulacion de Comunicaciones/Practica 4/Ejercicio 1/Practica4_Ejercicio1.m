% **********************************************
% Practia 4, ejercicio 1: Parametros de calidad de un estimador
% Antonio Gomez Vergara - GIST
% **********************************************
%% Ejercicio 1.2
clc
clear all
close all
%%
load Muestras_Hito1.mat
W0 = 25;
Vy = 200;
k = [10, 100, 1000];
%% Parte A
%% 1.- k = 10
%Primer caso, cuando k = 10.
%Cargamos x e y del primer caso (Observaciones1)
x1 = Observaciones1(:,1,:);
y1 = Observaciones1(:,2,:);
% Calculamos los estimadores:
[est_W0_1, sesgo_W0_1,var_W0_1,est_Vy_1,sesgo_Vy_1,var_Vy_1] = estimacion(y1, x1, k(1), W0, Vy);

%% 2.- k = 100
%Segundo caso, cuando k = 100.
%Cargamos x e y del primer caso (Observaciones2)
x2 = Observaciones2(:,1,:);
y2 = Observaciones2(:,2,:);
% Calculamos los estimadores:
[est_W0_2, sesgo_W0_2,var_W0_2,est_Vy_2,sesgo_Vy_2,var_Vy_2] = estimacion(y2, x2, k(2), W0, Vy);
%% 3.- k = 1000
%Tercer caso, cuando k = 1000.
%Cargamos x e y del primer caso (Observaciones2)
x3 = Observaciones3(:,1,:);
y3 = Observaciones3(:,2,:);
% Calculamos los estimadores:
[est_W0_3, sesgo_W0_3,var_W0_3,est_Vy_3,sesgo_Vy_3,var_Vy_3] = estimacion(y3, x3, k(3), W0, Vy);
%% Soluciones:
% Sesgo
sesgo_W0 = [sesgo_W0_1; sesgo_W0_2; sesgo_W0_3];
sesgo_Vy = [sesgo_Vy_1; sesgo_Vy_2; sesgo_Vy_3];
disp('Tabla de sesgo: ');
disp(' ')
tabla_sesgo = table(num2str(sesgo_W0), num2str(sesgo_Vy), 'RowNames', {'k = 10', 'k = 100', 'k = 1000'}, 'VariableNames', {'Sesgo_W0' , 'Sesgo_Vy'});
disp(tabla_sesgo)

% Consistente en varianza
var_W0 = [var_W0_1; var_W0_2; var_W0_3];
var_Vy = [var_Vy_1; var_Vy_2; var_Vy_3];
disp('Tabla de consistencia en varianza: ')
disp(' ')
tabla_var = table(num2str(var_W0), num2str(var_Vy), 'RowNames', {'k = 10', 'k = 100', 'k = 1000'}, 'VariableNames', {'Varianza_W0' , 'Varianza_Vy'});
disp(tabla_var)

%% Parte B
%Lo primero de todo, ordenamos W0 y Vy de menor a mayor:
est_W0 = squeeze([sort(est_W0_1); sort(est_W0_2); sort(est_W0_3)]); %Hacemos un squeeze para librarnos de lo que tiene
% dimension unitaria (de 3 dimensiones pasamos a 2)
est_Vy = [sort(est_Vy_1); sort(est_Vy_2); sort(est_Vy_3)];
interv_conf_W0 = zeros(9,2);
interv_conf_Vy = zeros(9,2);

%Intervalos de confianza:
% Los intervalos irán desde el intervalo k hasta el final del estimador - k
% Los valores a utilizar seran: El primero del estimador ML y el
% último, asi obtenemos el intervalo de confianza de W0 y Vy
interv = [50,25,5];
n = 1;
for w = 1:3
    for l = interv
        [interv_conf_W0(n, 1), interv_conf_W0(n, 2)] = confianza(est_W0(w, :), l);
        [interv_conf_Vy(n, 1), interv_conf_Vy(n, 2)] = confianza(est_Vy(w, :), l);
        n = n + 1;
    end
end
disp('Tabla de intervalos de confianza: ');
disp(' ')
tabla_conf = table(interv_conf_W0, interv_conf_Vy);
tabla_conf.Properties.RowNames = {'k = 10, 90%', 'k = 10, 95%','k = 10, 99%', 'k = 100, 90%', 'k = 100, 95%', 'k = 100, 99%', 'k = 1000, 90%','k = 1000, 95%', 'k = 1000, 99%'};
tabla_conf.Properties.VariableNames = {'Intervalo_confianza_W0' , 'Intervalo_confianza_Vy'};
disp(tabla_conf)

%% Parte C
% Para calcular la funcion tiempo-fiabilidad, unicamente multiplicamos las
% muestras (k) por la varianza del estimador
TF_W0 = zeros(3, 1);
TF_Vy = zeros(3, 1);

n = 1;
for muestras = k
    TF_W0(n, 1) = muestras.*var_W0(n, :);
    TF_Vy(n, 1) = muestras.*var_Vy(n, :);
    n = n + 1;
end
disp('Tabla Tiempo - Fiabilidad: ')
disp(' ')
tabla_TF = table(num2str(TF_W0), num2str(TF_Vy), 'VariableNames', {'Tiempo_Fiabilidad_W0', 'Tiempo_Fiabilidad_Vy'}, 'RowNames', {'k = 10', 'k = 100', 'k = 1000'});
disp(tabla_TF)


%% Graficas adicionales:

figure
subplot(321)
histogram(est_W0(1,:),100)
title('W0 estimado para k = 10')
axis([10 40 0 40])
subplot(323)
histogram(est_W0(2,:),100)
title('W0 estimado para k = 100')
axis([10 40 0 40])
subplot(325)
histogram(est_W0(3,:),100)
title('W0 estimado para k = 1000')
axis([10 40 0 40])

subplot(322)
histogram(est_Vy(1,:),100)
title('Vy estimado para k = 10')
axis([0 700 0 40])
subplot(324)
histogram(est_Vy(2,:),100)
title('Vy estimado para k = 100')
axis([0 700 0 40])
subplot(326)
hist(est_Vy(3,:),100)
title('Vy estimado para k = 1000')
axis([0 700 0 40])
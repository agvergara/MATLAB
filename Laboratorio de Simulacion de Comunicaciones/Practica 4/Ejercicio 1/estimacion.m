function [est_W0,sesgo_W0,var_W0,est_Vy,sesgo_Vy,var_Vy] = estimacion(y, x, k, W0, Vy)
%% Estimador W0:
est_W0 = sum(y-5 .* x)/k; %Segun los calculos teoricos del hito 1.1
sesgo_W0 = mean(est_W0) - W0;
var_W0 = var(est_W0);
%% Estimador Vy:
est_W0_elim = squeeze(est_W0); %Se hace un squeeze ya que los estimadores de W0 tienen 3 dimensiones
%Se dan 1000 vueltas al bucle ya que esos son los valores que tiene el
%estimador W0 y como el estimador Vy contiene al estimador W0 hay que
%hacerlo sobre cada valor
for n = 1:1000
    est_Vy(n) = sum((y(:,1,n)- est_W0_elim(n)-5.*x(:,1,n)).^2)/k; %Segun los calculos teoricos del hito 1.1
end
sesgo_Vy = mean(est_Vy) - Vy; 
var_Vy = var(est_Vy);
end
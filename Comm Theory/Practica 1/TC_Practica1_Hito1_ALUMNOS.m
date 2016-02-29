%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                   TEORÍA DE LA COMUNICACIÓN
%
%                PRÁCTICA 1. Procesos Estocásticos
%
%       HITO 1. ESTACIONARIEDAD Y ERGODICIDAD DE LOS PROCESOS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Estacionariedad y ergodicidad del proceso X:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defino un proceso estocásticos consistente en realizar Nm medidas sobre
% un circuito eléctrico, en el que encontramos una tensión continua de Vc
% voltios más un ruido de media cero y varianza Pn.
% Genero una matriz, cuyas filas serán realizaciones del proceso (una fila,
% una realización). Genero Nr realizaciones.

Nm = 1000;
Nr = 1000;
Vc = 5;
Pn = 1;
% Distribucion Normal de media Vc y varianza sqrt(Pn)
X = Vc + sqrt(Pn)*randn(Nr,Nm);
% randn son valores pseudoaleatorios de una distribucion normal 
% Calcular la media de las Nm variables aleatorias que componen el proceso
% (cada v.a. es el resultado de medir la tensión en un momento dado).

medias = zeros(1, Nm);

medias = mean(X);
media_t = zeros(1,Nr);
media_e = zeros (1,Nm);
%Media temporal X(t)
for n = 1:Nr
    media_t(n) = mean(X(n,:));
end;
%Media estadistica X(t)
for m = 1:Nm
    media_e(m) = mean(X(:,m));
end;
% Dibujo la media de las Nm variables aleatorias que componen mi proceso
% estocástico:
figure
subplot(211)
plot(medias);
axis([1 Nm 1 7]);
grid on;
xlabel('n');
ylabel('Media de X[n]');
title('Evolución de la media del proceso estocástico.');


% Figura para comparar media temporal (arriba) con media estadistica (abajo)

figure
subplot (211)
plot(media_t);
title('Media temporal de X');
grid on;
axis([1 Nr 4 6]);
subplot (212)
plot(media_e);
title('Media estadistica de X');
grid on;
axis([1 Nm 4 6]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ergodicidad Proceso X:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cambio las dimnsiones de la matriz para que el resultado sea
% más ilustrativo:
 Nm = 1000;
 Nr = 500;
 X = Vc + sqrt(Pn)*randn(Nr,Nm); % Vuelvo a generar el proceso como más arriba 

% ¿Cómo son las medias para cada realización?
media_realizaciones = zeros(1, Nr);
    media_realizaciones = mean(X,2);

% Dibujo la media de Nr realizaciones de mi proceso estocástico:
figure
subplot(211);
plot(1:Nm, medias);
title('Media del proceso estocastico X');
grid on;
axis([1 Nm 1 7]);
subplot(212);
plot(1:Nr, media_realizaciones);
title('Media de las realizaciones');
grid on;
axis([1 Nr 1 7]);

%1 y 2.- El proceso X  es un proceso ergódico ya que la media temporal y la
%estadística se parecen. Al ser ergódico respecto a la media, conlleva que
%también es un proceso estacionario.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Estacionariedad Proceso Y:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defino un proceso similar, pero ahora en el instante Nm/2, la tensión continua
% pasa de 5 V a 0 V.
 Nr = 500
 Nm = 500 % Conviene que Nm sea par para evitar problemas luego.
 Y = zeros(Nr,Nm); % Inicializo Y con ceros.
 Y(:,1:Nm/2) = Vc + sqrt(1)*randn(Nr,Nm/2);
 Y(:,Nm/2+1:end) = 0 + sqrt(1)*randn(Nr,Nm/2);

% Repito los cálculos anteriores:
media_y_t = zeros(1,Nr);
media_y_e = zeros (1,Nm);
%Media temporal X(t)
for n = 1:Nr
    media_y_t(n) = mean(Y(n,:));
end;
%Media estadistica X(t)
for m = 1:Nm
    media_y_e(m) = mean(Y(:,m));
end;
figure
subplot (211)
plot(media_y_t);
title('Media temporal de Y');
grid on;
subplot (212)
plot(media_y_e);
title('Media estadistica de Y');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ergodicidad Proceso Y:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Repito los cálculos anteriores
media_realizaciones_Y = zeros(1, Nr);
media_realizaciones_Y = mean(Y, 2);

figure
subplot(211);
plot(1:Nm, mean(Y));
title('Media del proceso estocastico Y');
grid on;
axis([1 Nm 1 7]);
subplot(212);
plot(1:Nr, media_realizaciones_Y);
title('Media de las realizaciones');
grid on;
axis([1 Nr 1 7]);

%3 y 4.- Estacionariedad -> Media estadistica
%Ergodicidad -> Comparacion media temp con la estadistica
%El proceso Y no es estacionario ni ergodico ya que la media temporal no
%tiene nada que ver con la estadistica.
%El parametro a calcular es la autocorrelacion y la condicion que debe
%cumplir es que dependa de tau, es decir una diferencia de tiempo de t2-t1
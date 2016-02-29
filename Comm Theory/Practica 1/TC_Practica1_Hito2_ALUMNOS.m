%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                   TEOR�A DE LA COMUNICACI�N
%
%                PR�CTICA 1. Procesos Estoc�sticos
%
%           HITO 2. PROCESOS ESTOC�STICOS CON SE�ALES REALES
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Cargamos la frase
load newyork.mat

% Escuchamos la frase
sound(x, Fs);

% A partir de Fs generamos el vector de tiempos
 Ts = 1/Fs;
% Dibumos la se�al en el tiempo (con el eje de tiempos en segundos)
figure;
subplot (311)
plot(x)

% Ponemos etiquetas en los ejes, t�tulo, etc...
xlabel('t');
ylabel('X(t)');
title('Se�al newyork.mat');

% Calculamos la autocorrelaci�n del proceso y lo dibujamos (con el eje de
% tiempos en segundos)
 [Rx, t] = xcorr(x);
 subplot(312);
 plot(t,Rx);
 xlabel('t');
 ylabel('Rx(t)');
 title('Autocorrelacion de la se�al newyork.mat');

% Calculamos la DEE del proceso estoc�stico
h = spectrum.welch;
Hpsd = psd(h,x,'Fs',Fs);
f = Hpsd.Frequencies;
dee = Hpsd.Data;

% Dibuamos la DEE con el vector de frecuencias en Hz.
subplot(313)
plot(f, dee);
xlabel('f');
ylabel('Gx(f)');
title('DEE de la se�al newyork.mat');

% 3.- La autocorrelacion calculada es como promedio temporal, para que
% coincidan el proceso debe ser estacionario ya que al depender de una
% diferencia de tiempo de t2-t1 la autocorrelacion en ese mismo instante
% tau es igual la autocorrelacion como promedio estadistico (?)

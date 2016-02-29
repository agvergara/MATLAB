%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                   TEORÍA DE LA COMUNICACIÓN
%
%                PRÁCTICA 1. Procesos Estocásticos
%
%           HITO 2. PROCESOS ESTOCÁSTICOS CON SEÑALES REALES
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Cargamos la frase
load newyork.mat

% Escuchamos la frase
sound(x, Fs);

% A partir de Fs generamos el vector de tiempos
 Ts = 1/Fs;
% Dibumos la señal en el tiempo (con el eje de tiempos en segundos)
figure;
subplot (311)
plot(x)

% Ponemos etiquetas en los ejes, título, etc...
xlabel('t');
ylabel('X(t)');
title('Señal newyork.mat');

% Calculamos la autocorrelación del proceso y lo dibujamos (con el eje de
% tiempos en segundos)
 [Rx, t] = xcorr(x);
 subplot(312);
 plot(t,Rx);
 xlabel('t');
 ylabel('Rx(t)');
 title('Autocorrelacion de la señal newyork.mat');

% Calculamos la DEE del proceso estocástico
h = spectrum.welch;
Hpsd = psd(h,x,'Fs',Fs);
f = Hpsd.Frequencies;
dee = Hpsd.Data;

% Dibuamos la DEE con el vector de frecuencias en Hz.
subplot(313)
plot(f, dee);
xlabel('f');
ylabel('Gx(f)');
title('DEE de la señal newyork.mat');

% 3.- La autocorrelacion calculada es como promedio temporal, para que
% coincidan el proceso debe ser estacionario ya que al depender de una
% diferencia de tiempo de t2-t1 la autocorrelacion en ese mismo instante
% tau es igual la autocorrelacion como promedio estadistico (?)

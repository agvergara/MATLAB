%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                   TEORÍA DE LA COMUNICACIÓN
%
%   PRÁCTICA 2. Procesos Estocásticos y Sistemas de Telecomunicación
%
%               HITO 2. Señal de voz filtrada.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cargamos la frase
load 'frase2.mat';

%Escuchamos la frase:
%sound(x, Fs, BITS);
%% DEFINICIÓN Y DIBUJO DEL FILTRO
%% HITO 2.1
fcorte = 400; % Frecuencia de corte del filtro.
[b,a] = cheby1(8, 0.1, fcorte/(Fs/2));
% RESPUESTA AL IMPULSO Y FUNCIÓN DE TRANSFERENCIA
h = filter(b,a,[1 zeros(1,length(x)-1)]); %¿Qué hace esto? Lo de la delta, eso de filtrar y tal
H = abs(fftshift(fft(h)));
f_filtro = linspace(-(Fs/2)-1, (Fs/2), length(x)); % Vector de frecuencias para la gráfica.

figure; % Dibujar h y H, con el eje de tiempos bien puesto.
subplot(211);
% Dibujar
plot(f_filtro, h);
title('h');
subplot(212);
% Dibujar
plot(f_filtro, H);
title('H');
%% FILTRAMOS LA SEÑAL
xfilt = filter(b,a,x);

%% DIBUJO LAS SEÑALES EN EL TIEMPO
figure;
subplot(311);
% Dibujo
plot(x);
title('x');
subplot(312);
% Dibujo
plot(h);
title('h');
subplot(313);
% Dibujo
plot(H);
title('H');

%% CÁLCULO Y DIBUJO DE LAS DEP
estimador = spectrum.periodogram;
Hpsd = psd(estimador,x,'Fs',Fs, 'SpectrumType','twosided');
dep_x = fftshift(Hpsd.Data);
f = linspace(-Fs/2, Fs/2, length(dep_x));

estimador2 = spectrum.periodogram;
Hpsd_filt = psd(estimador2,xfilt,'Fs',Fs, 'SpectrumType','twosided');
dep_filt = fftshift(Hpsd_filt.Data);
f_filt = linspace(-Fs/2,Fs/2,length(dep_filt));
estimador3 = spectrum.periodogram;
Hpsd_h = psd (estimador3, h, 'Fs', Fs, 'Spectrumtype', 'twosided');
dep_h = fftshift(Hpsd_h.Data);
h_filt = linspace(-Fs/2,Fs/2,length(dep_h));
figure % Nueva figura con 3 subplots para las DEPs.
subplot(311); % DEP original
plot(h_filt, dep_x);
title('DEP X');
% Dibujar
ejes = axis;
 axis([-4000 4000 ejes(3) ejes(4)]); % Mismo eje horizontal en las 3 gráficas.
subplot(312); % Módulo al cuadrado de la función de transferencia del filtro
plot(h_filt, dep_h);
title('DEP h');
% Dibujar
ejes = axis;
axis([-4000 4000 ejes(3) ejes(4)]); % Mismo eje horizontal en las 3 gráficas.
subplot(313); % DEP de la señal filtrada
plot(h_filt, dep_filt);
title('DEP señal filtrada');
% Dibujar
ejes = axis;
 axis([-4000 4000 ejes(3) ejes(4)]); % Mismo eje horizontal en las 3 gráficas.
%% CÁLCULO Y DIBUJO DE LAS AUTOCORRELACIONES
 [Rx, tx] = xcorr(x);
 [Rh, th] = xcorr(h);
 Rxfilt = filter(b, a, Rx);
Ts = 1 / Fs;
tmax = length(x)*Ts;
% tR = linspace(-Fs/2, Fs/2, length(tmax)); % Eje de tiempos de la autocorrelación (aprox.).
% Ni idea del linspace
figure;
subplot(311); 
plot(tx, Rx);
title('Rx');
ejes = axis;
 axis([-10000 10000 ejes(3) ejes(4)]);
subplot(312); 
plot(th, Rh);
title('Rh');
ejes = axis;
 axis([-10000 10000 ejes(3) ejes(4)]);
subplot(313); 
plot(tx, Rxfilt);
title('Rxfilt');
ejes = axis;
 axis([-10000 10000 ejes(3) ejes(4)]);
% Reporduzco la señal filtrada
    % Hago que la señal fitlrada tenga la misma potencia que la original
xf = xfilt ./ mean(abs(xfilt).^2) * mean(abs(x).^2);
 sound(xf,Fs)



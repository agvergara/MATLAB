%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                   TEOR�A DE LA COMUNICACI�N
%
%   PR�CTICA 2. Procesos Estoc�sticos y Sistemas de Telecomunicaci�n
%
%               HITO 2. Se�al de voz filtrada.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cargamos la frase
load 'frase2.mat';

%Escuchamos la frase:
%sound(x, Fs, BITS);
%% DEFINICI�N Y DIBUJO DEL FILTRO
%% HITO 2.1
fcorte = 400; % Frecuencia de corte del filtro.
[b,a] = cheby1(8, 0.1, fcorte/(Fs/2));
% RESPUESTA AL IMPULSO Y FUNCI�N DE TRANSFERENCIA
h = filter(b,a,[1 zeros(1,length(x)-1)]); %�Qu� hace esto? Lo de la delta, eso de filtrar y tal
H = abs(fftshift(fft(h)));
f_filtro = linspace(-(Fs/2)-1, (Fs/2), length(x)); % Vector de frecuencias para la gr�fica.

figure; % Dibujar h y H, con el eje de tiempos bien puesto.
subplot(211);
% Dibujar
plot(f_filtro, h);
title('h');
subplot(212);
% Dibujar
plot(f_filtro, H);
title('H');
%% FILTRAMOS LA SE�AL
xfilt = filter(b,a,x);

%% DIBUJO LAS SE�ALES EN EL TIEMPO
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

%% C�LCULO Y DIBUJO DE LAS DEP
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
 axis([-4000 4000 ejes(3) ejes(4)]); % Mismo eje horizontal en las 3 gr�ficas.
subplot(312); % M�dulo al cuadrado de la funci�n de transferencia del filtro
plot(h_filt, dep_h);
title('DEP h');
% Dibujar
ejes = axis;
axis([-4000 4000 ejes(3) ejes(4)]); % Mismo eje horizontal en las 3 gr�ficas.
subplot(313); % DEP de la se�al filtrada
plot(h_filt, dep_filt);
title('DEP se�al filtrada');
% Dibujar
ejes = axis;
 axis([-4000 4000 ejes(3) ejes(4)]); % Mismo eje horizontal en las 3 gr�ficas.
%% C�LCULO Y DIBUJO DE LAS AUTOCORRELACIONES
 [Rx, tx] = xcorr(x);
 [Rh, th] = xcorr(h);
 Rxfilt = filter(b, a, Rx);
Ts = 1 / Fs;
tmax = length(x)*Ts;
% tR = linspace(-Fs/2, Fs/2, length(tmax)); % Eje de tiempos de la autocorrelaci�n (aprox.).
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
% Reporduzco la se�al filtrada
    % Hago que la se�al fitlrada tenga la misma potencia que la original
xf = xfilt ./ mean(abs(xfilt).^2) * mean(abs(x).^2);
 sound(xf,Fs)



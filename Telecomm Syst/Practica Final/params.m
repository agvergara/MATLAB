function [sradiovanocasv, sradiovanocash, sradiovanotermv, sradiovanotermh] = params(stabla, d)
r001 = 25; %Elegimos 25 mm/h de lluvia, usando REC-UIT-P.837
indispcascada = 0.001;
indispterminal = 0.005;
menunciado = 5;
%Frecuencia de referencia para calcular las frecuencias de los portadoras
%en la recomendacion UIT.R F.595-10 y k y alpha en polarizacion horizontal 
% y vertical que aparece en UIT.R - 838.3 para la banda de 18GHz.
fr = 18.700; 
kv = 0.07708;
kh = 0.07078;
ah = 1.0818;
av = 1.0025;

%Hallamos gammav001 y gammah001 (en dB/Km)
gammah001 = kh.*r001.^ah;
gammav001 = kv.*r001.^av;

d0 = 35.*exp(-0.015.*r001);
Lef = d .* (1+(d./d0));
desvan001h = gammah001 .* Lef;
desvan001v = gammav001 .* Lef;

%Al ser la latitud superior a 30º Norte, los datos del desvanecimiento
%cambia

desvancascadav = desvan001v.*0.07.*(indispcascada.^-(0.855+0.139.*log(indispcascada)));
desvancascadah = desvan001h.*0.07.*(indispcascada.^-(0.855+0.139.*log(indispcascada)));

desvantermv = desvan001v.*0.07.*(indispterminal.^-(0.855+0.139.*log(indispterminal)));
desvantermh = desvan001h.*0.07.*(indispterminal.^-(0.855+0.139.*log(indispterminal)));

%El margen por lluvia sera M = desvan001 depende si es horizontal o
%vertical la polarizacion
sradiovanocasv = stabla + menunciado + desvancascadav;
sradiovanocash = stabla + menunciado + desvancascadah;

sradiovanotermv = stabla + menunciado + desvantermv;
sradiovanotermh = stabla + menunciado + desvantermh;

%Calulamos las frecuencias de los enlaces Fn y Fn' siendo n el numero de
%frecuencia del canal.
%Para 27.5 son 35 canales y para 55 son 17 canales
%if canal >= 55
%    F = fr - 1000 + 55.*n;
%    Fprima = fr + 10 + 55.*n;
%elseif canal >= 27.5
%    F = fr - 1000 + 27.5.*n;
%    Fprima = fr + 10 + 27.5.*n;
%elseif canal >= 13.75
%    if n == 1
%        F = 18593.75; %MHz
%        Fprima = 19603.75; %MHz
%    elseif n == 2
%        F = 18607.5; %MHz
%        Fprima = 19617.5 %MHz
%    end;
%elseif canal >= 7.5
%    if n == 1
%        F = 18645.5;
%        Fprima = 19655.5;
%    elseif n == 2
%        F = 18652.5;
%        Fprima = 19662.5;
%    end;
%end;
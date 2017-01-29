%*********************spectrum.m**************************
% TITULO: FUNCION PARA REPRESENTAR EL ESPECTRO DE UNA SEÑAL
% ASIGNATURA: LABORATORIO DE SIMULACION DE COMUNICACIONES
% GRADO EN INGENIERIA EN SISTEMAS DE TELECOMUNICACION
%*********************************************************
% y=spectrum(x,T,Z,s,lin_log)
% x: señal a analizar (real)
% T: período de muestreo
% Z: impedancia (ohmios)
% s: título que se quiere aparezca en el espectro
% lin_log: representación lineal (lin) o logarítmica (log)
%*********************************************************
function y=spectrum(x,T,Z,s,lin_log)
a=length(x);
aa=log(a)/log(2);
l=ceil(aa);
x1=fft(x,2^l);
y=x1.*conj(x1);
l=2^l; % l=length(y);
y=y/(l^2);
y=[y(1) 2*y(2:l/2)]/real(Z);
eje=(1/T)*(0:l/2-1)/l; % eje de abcisas
aux=(lin_log(1:3)=='lin');
if sum(aux)==3
 plot(eje,y*1e3,'g')
 ylabel('mW')
else
 plot(eje, 10*log10(y*1e3+eps),'g') % para no calcular el logaritmo de cero
 ylabel('dBm')
end
grid, title(s),xlabel('hertzios')
end
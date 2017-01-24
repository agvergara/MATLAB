%*********************polozero.m**************************
% TITULO: FUNCION PARA REPRESENTAR EL DIAGRAMA DE POLOS Y CEROS
% AUTOR: OSCAR JIMENEZ
% ASIGNATURA: LABORATORIO DE SIMULACION DE COMUNICACIONES
% GRADO EN INGENIERIA EN SISTEMAS DE TELECOMUNICACION
%*********************************************************
% Esta función nos representa el diagrama de polos y ceros
% de un filtro digital IIR, definidos los vectores de entrada
% de acuerdo con la nomenclatura MATLAB, es decir:
% B: vector no recursivo, numerador de H(z)
% A: vector de realimentación, denominador de H(z)
%*********************************************************
function polozero(B,A)
theta=0:0.01:2*pi;
rho=ones(size(theta));
[Z,P]=tf2zp(B,A);
if max(abs(Z))>max(abs(P))
 polar(angle(Z),abs(Z),'ro')
 title('DIAGRAMA DE POLOS (*) Y CEROS (o) DEL FILTRO IIR')
 hold on
 polar(angle(P),abs(P),'g*')
 polar(theta,rho,'c')
else
 polar(angle(P),abs(P),'g*')
 title('DIAGRAMA DE POLOS (*) Y CEROS (o) DEL FILTRO IIR')
 hold on
 polar(angle(Z),abs(Z),'yo')
 polar(theta,rho,'c')
end
hold off
end
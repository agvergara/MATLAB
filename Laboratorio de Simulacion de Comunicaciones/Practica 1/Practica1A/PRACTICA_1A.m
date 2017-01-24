%*********************PRACTICA_1A.m**************************








% ------------------
% NOTA: COMENTAR TODO EL CODIGO. Mirar en PDS el punto 8, calculo de
% adjuntos
% ------------------











% TITULO: CALCULO MATRICIAL
% ASIGNATURA: LABORATORIO DE SIMULACION DE COMUNICACIONES
% GRADO EN INGENIERIA EN SISTEMAS DE TELECOMUNICACION
close all % Cierra todas las pantallas que hubiera anteriormente
clear % Borra todas las variables
clc % Borra pantalla
n = input('MATRIZ CUADRADA DE ORDEN: ');
randn('state',0) % Para que todos obtengamos las mismas matrices
 % randn -->distribución gaussiana
A = fix(10*randn(n)) % Para que las matrices sean de números enteros
 % fix(x) nos da el número entero de x.
a = det(A) % Para determinar que la matriz obtenida no es singular
B = fix(10*randn(n))
b = det(B)
%% 1.- La transpuesta de la suma de dos matrices es la suma de las traspuestas, esto es: (A+B)’ = A’ + B’
C = (A+B)';
D = A'+B';
disp('1.- La transpuesta de la suma de dos matrices es la suma de las traspuestas, esto es: (A+B)’ = A’ + B’: ')
if C == D
    disp('True')
else
    disp('False')
end
%% 2.- La transpuesta del producto de dos matrices es el producto de las transpuestas en orden inverso, esto es: (A*B)’ = B’*A’
C = (A*B)';
D = B'*A';
disp('2.- La transpuesta del producto de dos matrices es el producto de las transpuestas en orden inverso, esto es: (A*B)’ = B’*A’: ')
if C == D
    disp('True')
else
    disp('False')
end
%% 3.- El determinante del producto de dos matrices cuadradas es el producto de los determinantes de cada una de ellas, y además cumple la propiedad conmutativa, esto es: |A*B| = |A|*|B| = |B*A|
C = det(A*B);
D = det(B*A);
E = a*b;
disp('3.- El determinante del producto de dos matrices cuadradas es el producto de los determinantes de cada una de ellas, y además cumple la propiedad conmutativa, esto es: |A*B| = |A|*|B| = |B*A|: ')
if C == D && C == E && D == E
    disp('True')
else
    disp('False')
end
%% 4.- Si A y B son dos matrices no singulares (matriz singular es una matriz cuadrada cuyo determinante es cero), el producto de A por B es una matriz no singular y se cumple: inv(A*B) = inv(B)*inv(A)
C = inv(A*B);
D = inv(B)*inv(A);
disp('4.- Si A y B son dos matrices no singulares (matriz singular es una matriz cuadrada cuyo determinante es cero), el producto de A por B es una matriz no singular y se cumple: inv(A*B) = inv(B)*inv(A): ')
if C == D
    disp('True')
else
    disp('False')
end
%% 5.- Si A es una matriz no singular, se cumple: inv(A’) = (inv(A))’
C = inv(A');
D = (inv(A))';
disp('5.- Si A es una matriz no singular, se cumple: inv(A’) = (inv(A))’: ')
if C == D
    disp('True')
else
    disp('False')
end
%% 6.- Si k es escalar (tomar k = 5) y A es una matriz cuadrada no singular, entonces se cumple: inv(k*A) = (1/k)*inv(A)
k = 5;
C = inv(k*A);
D = (1/k)*inv(A)';
disp('6.- Si k es escalar (tomar k = 5) y A es una matriz cuadrada no singular, entonces se cumple: inv(k*A) = (1/k)*inv(A)’: ')
if C == D
    disp('True')
else
    disp('False')
end
%% 7.- El determinante de la inversa de una matriz es igual a la inversa el determinante de la matriz, esto es: |inv(A)| = 1/|A|
C = det(inv(A));
D = inv(det(A));
disp('7.- El determinante de la inversa de una matriz es igual a la inversa el determinante de la matriz, esto es: |inv(A)| = 1/|A|: ')
if C == D
    disp('True')
else
    disp('False')
end
%% 8.- Si A es una matriz cuadrada con determinante distinto de cero su inversa se puede calcular como: inv(A) = (1/|A|)*[adjuntos]'
C = inv(A);
E = adjoint(sym(A));
D = (1/a)*E;
disp('8.- Si A es una matriz cuadrada con determinante distinto de cero su inversa se puede calcular como: inv(A) = (1/|A|)*[adjuntos]: ')
if C == D
    disp('True')
else
    disp('False')
end
% NOTA: Para matrices de mas de orden 5 no se cumple
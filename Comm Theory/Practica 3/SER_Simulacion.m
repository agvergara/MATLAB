clear all
close all

L = ; % N�mero de s�mbolos en la simulaci�n
M = 8; % Constelacion PAM de M simbolos
k = log2(M); % N�mero de bits por s�mbolo

Eb = ; % Valor de Eb en unidades naturales (calculado de forma te�rica en el Hito3.1.)
Eb_dB = 10*log10(Eb); % Valor de Eb en dB

Eb_No_dB = 0:1:17; % Valores de Eb/No en dB
for count = 1:length(Eb_No_dB)
    indices_simbolos_Tx = randi() % Generamos L s�mbolos aleatorios (con valores de 1 a 8)
    simbolos_Tx = pammod(); % Generamos los L s�mbolos aleatorios (valores [-7, -5, -3, -1, 1, 3, 5, 7])
    No_dB = Eb_dB - Eb_No_dB(count); % Valor de No en dB
    No = 10^(No_dB/10); % Valor de No en unidades naturales
    ruido = ; % Generamos L muestras de ruido gaussiano de varianza No/2
    simbolos_Rx = simbolos_Tx + ruido; % Sumamos el ruido aditivo
    decision = ; % S�mbolos despu�s del decisor (dise�ado en el Hito3.2.)
    SER_experimental(count) = sum((decision ~= simbolos_Tx))/L; % Calculamos la SER experimental
end

% Representamos los resultados.
figure;
clf;
semilogy(Eb_No_dB,SER_experimental);
grid on;
xlabel('Eb/No (dB)');
ylabel('SER');

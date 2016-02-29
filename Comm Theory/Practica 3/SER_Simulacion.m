clear all
close all
L = 10000; % Número de símbolos en la simulación
M = 8; % Constelacion PAM de M simbolos
k = log2(M); % Número de bits por símbolo

Eb = 7; % Valor de Eb en unidades naturales (calculado de forma teórica en el Hito3.1.)
Eb_dB = 10*log10(Eb); % Valor de Eb en dB

Eb_No_dB = 0:1:17; % Valores de Eb/No en dB
for count = 1:length(Eb_No_dB)
    indices_simbolos_Tx = randint(L, 1, M) % Generamos L símbolos aleatorios (con valores de 1 a 8)
    simbolos_Tx = pammod(indices_simbolos_Tx, M); % Generamos los L símbolos aleatorios (valores [-7, -5, -3, -1, 1, 3, 5, 7])
    No_dB = Eb_dB - Eb_No_dB(count); % Valor de No en dB
    No = 10^(No_dB/10); % Valor de No en unidades naturales
    ruido = (sqrt(No/2))*rand(L,1); % Generamos L muestras de ruido gaussiano de varianza No/2
    simbolos_Rx = simbolos_Tx + ruido; % Sumamos el ruido aditivo
    decision = zeros(L, 1); % Símbolos después del decisor (diseñado en el Hito3.2.)
    for j = 1:L
        if simbolos_Rx(j) < -6
            decision(j) = -7;
        elseif -6 < simbolos_Rx(j) <= -4
            decision(j) = -5;
        elseif -4 < simbolos_Rx(j) <= -2
            decision(j) = -3;
        elseif -2 < simbolos_Rx(j) <= 0
            decision(j) = -1;
        elseif 0 < simbolos_Rx(j) <= 2
            decision(j) = 1;
        elseif 2 < simbolos_Rx(j) <= 4
            deicision(j) = 3;
        elseif 4 < simbolos_Rx(j) <= 6
            decision(j) = 5;
        elseif simbolos_Rx(j) > 6
            decision(j) = 7;
        end
    end
    SER_experimental(count) = sum((decision ~= simbolos_Tx))/L; % Calculamos la SER experimental
    SER_teorica(count) = ((2*(M-1))/M)*qfunc(sqrt((6*k*Eb)/(((M^2)-1)*No)));
    BER_experimental(count) = (sum((decision ~= simbolos_Tx))/L) / k; %Codificacion GRAY
    BER_teorica(count) = (((2*(M-1))/M)*qfunc(sqrt((6*k*Eb)/(((M^2)-1)*No)))) / k; %Codificacion GRAY
end
% Para representar la BER es igual que la SER (no la pondré).
% Representamos los resultados.
figure;
clf;
subplot(211);
semilogy(Eb_No_dB,SER_experimental);
grid on;
xlabel('Eb/No (dB)');
ylabel('SER experimental');
subplot(212);
semilogy(Eb_No_dB,SER_teorica);
grid on;
xlabel('Eb/No (dB)');
ylabel('SER teorica');


figure;
subplot(211);
semilogy(Eb_No_dB,BER_experimental);
grid on;
xlabel('Eb/No (dB)');
ylabel('BER experimental');
subplot(212);
semilogy(Eb_No_dB,BER_teorica);
grid on;
xlabel('Eb/No (dB)');
ylabel('BER teorica');


scatterplot(simbolos_Rx);


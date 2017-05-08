% **********************************************
% Practia 4, ejercicio 2: Muestreo enfatizado
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%% Ejercicio 2.1
vector_SNR = 0:13; %En dB
n = 1;
for SNR = vector_SNR
    snr = 10^(SNR/10); %Convertimos a valores naturales
    BER(n) = qfunc(sqrt(2*snr)); %Hallamos la BER teórica para las muestras
	n = n + 1;
end
N = 100./BER;
disp('Comparación BER con extremos de SNR: ');
disp(['Para una BER de: ', num2str(BER(1)), ', necesitamos: ', num2str(N(1)), ' muestras']);
disp(['Para una BER de: ', num2str(BER(end)), ', necesitamos: ', num2str(N(end)), ' muestras']);
disp('Es lógico pensar que cuando tenemos una BER menor, podemos enviar más muestras que con una BER mayor');
disp(['Por tanto, nos quedamos con el mejor caso: ' num2str(N(end)), ' muestras son necesarias']);


%% Ejercicio 2.2
%Usamos el vector de SNR anterior
error = 10; % 10% de error relativo
muestras = 1e6; %No podemos utilizar tantas muestras como hemos obtenido ya que no tenemos tanta memoria
bits = randi([0 1], 1, muestras);
n = 1;
Mmod = 2; %BPSK
for SNR = vector_SNR
    modData = pskmod(bits, Mmod); %Utilizo pskmod en vez de modem.pskmod ya que, computacionalmente hablando, 
    % es más eficiente y es exactamente lo mismo
    snr = 10^(SNR/10);
    noise = sqrt(error/snr).*randn(1, muestras);
    % Creamos las distribuciones del ruido, realizandolas con su media y
    % varianza (que es el error) y otra centrado en cero con varianza
    % 1/2*snr
    noise_error = normpdf(noise,mean(noise),sqrt(error));
    noise_normal = normpdf(noise, 0, sqrt(1/(2*snr)));
    comp = noise_normal./noise_error; %Comparamos ambos
    y = modData + noise; %Añadimos el ruido
    dataRX = pskdemod(y, Mmod); %Demodulamos
    BER_CIS(n) = mean((bits ~= dataRX).*comp); %Hallamos la BER con el error del 10%
	n = n + 1;
end
%% Hito 2.3
%Usamos el vector SNR de siempre y el mismo numero de muestras del apartado
%anterior, aunque generamos nuevos bits por ser aleatorios
% El metodo de Monte Carlo consiste en iterar sobre el vector que tengamos
% (SNR en este caso) e ir calculando la BER en cada instante. Siempre hemos
% seguido este método aunque no nos diésemos cuenta
bits = randi([0 1], 1, muestras);
n = 1;
for SNR = vector_SNR
    modData = pskmod(bits, Mmod); %Utilizo pskmod en vez de modem.pskmod ya que, computacionalmente hablando, 
    % es más eficiente y es exactamente lo mismo
	snr = 10^(SNR/10);
	noise = sqrt(1/(2*snr)).*randn(1, muestras);
	y = modData + noise;
    dataRX = pskdemod(y, Mmod); %Demodulamos
	BER_MC(n) = mean(bits ~= dataRX); %Realizamos la simulacion con el metodo de Monte Carlo
	n = n + 1;
end

%% Solucion

figure
semilogy(vector_SNR, BER, 'b-')
hold on
semilogy(vector_SNR, BER_CIS, 'ro')
semilogy(vector_SNR, BER_MC, 'g*')
grid on
xlabel('SNR')
ylabel('BER')
legend('BER Teórica', 'BER CIS', 'BER Monte Carlo')
hold off

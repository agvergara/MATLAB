% **********************************************
% Practia 3, ejercicio 3: Estimacion de canal
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%% Ejercicio 3.1
ts = 1e-3; %Tiempo de simbolo
Mmod = 8; %8PSK
snr = 20; %En dB
t = 1:100; %ms
instantes = 1:5:100; %Cada 5 instantes parece ser buen interpolador
signal = ones(1, length(t)); %Señal a transmitir, un pulso
fd_vector = [10 20 50]; %Frecuencia doppler, en Hz
for n = 1:length(fd_vector)
    channel = rayleighchan(ts, fd_vector(n));%Creamos el canal rayleigh con la funcion rayleighchan
    % que toma como parámetros el tiempo de símbolo y el efecto doppler
    channel.StorePathGains = 1; % Decimos que nos guarde las ganancias
    h = filter(channel, signal); %Pasamos la señal por el canal
    h_eq = h(1:5:end);
    %Interpolador causal de orden 0
    channel0 = interp1(instantes,h_eq,t,'nearest','extrap');
    %Interpolador no causal de orden 1
    channel1 = interp1(instantes,h_eq,t,'linear','extrap');
    representar(n, h, channel0, channel1, fd_vector)
end

%% Ejercicio 3.2
SNRs = [2 6 10 16 24]; %Vector de SNRs, en dB
Mmod = 8; %8PSK
ts = 1e-3; %Igual que en el apartado 3.1
fd_vector = [10 20 50]; %Igual que en el apartado 3.1
Nb = log2(Mmod) * 10000; %Bits a transmitir

bits = randi([0 1], Nb, 1); %bits a Tx
mod = modem.pskmod('M',Mmod,'SymbolOrder','gray', 'InputType', 'bit');
modData = modulate(mod, bits);

m = 1;
for fd = fd_vector
    channel = rayleighchan(ts, fd);%Creamos el canal rayleigh con la funcion rayleighchan
    % que toma como parámetros el tiempo de símbolo y el efecto doppler
    channel.StorePathGains = 1; % Decimos que nos guarde las ganancias
    n = 1;
    for SNR = SNRs
        snr = 10.^(SNR/10); %Naturales 
        noise = sqrt(1/(2*snr)) * (randn(size(modData)) + 1i * randn(size(modData)));
		y = filter(channel,modData) + noise;
		h = channel.PathGains;
        dataRX = y./h; %Zero Forcing
		bitsRX = demodulate(modem.pskdemod(mod), dataRX);
		BER(m,n)=mean(abs(bitsRX - bits));
        
        % Estimación del canal: Interpolador orden 0
		h_eq = h(1:5:end);
		instantes = 1:5:length(h);
		t = 1:length(h);
		channel0 = interp1(instantes, h_eq, t, 'nearnest', 'extrap');
        % Demodulamos
        dataRX0 = y./channel0.'; %Zero Forcing
		bitsRX0 = demodulate(modem.pskdemod(mod), dataRX0);
        % BER
		BER(m+1,n)=mean(abs(bitsRX0 - bits));
        
        % Estimación del canal: Interpolador orden 1
		channel1 = interp1(instantes, h_eq, t, 'linear', 'extrap');
        % Demodulamos
        dataRX1 = y./channel1.'; %Zero Forcing
		bitsRX1 = demodulate(modem.pskdemod(mod), dataRX1);
        % BER
		BER(m+2,n)=mean(abs(bitsRX1 - bits));
		n = n + 1;
    end
    m = m + 3;
end
%%
disp('BER para canal original con SNR = [2 6 10 16 24]: ');
disp(['---> FD = 10Hz: ', num2str(BER(1, :))]);
disp(['---> FD = 20Hz: ', num2str(BER(4, :))]);
disp(['---> FD = 50Hz: ', num2str(BER(7, :))]);
disp(' ');
disp('BER para interpolador de orden 0 con SNR = [2 6 10 16 24]: ');
disp(['---> FD = 10Hz: ', num2str(BER(2, :))]);
disp(['---> FD = 20Hz: ', num2str(BER(5, :))]);
disp(['---> FD = 50Hz: ', num2str(BER(8, :))]);
disp(' ');
disp('BER para interpolador de orden 1 con SNR = [2 6 10 16 24]: ');
disp(['---> FD = 10Hz: ', num2str(BER(3, :))]);
disp(['---> FD = 20Hz: ', num2str(BER(6, :))]);
disp(['---> FD = 50Hz: ', num2str(BER(9, :))]);
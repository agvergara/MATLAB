% **********************************************
% Practia 2, parte C: Efectos del canal
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
%close all
clc
simb = 10^6;
vector_SNR = (0:1:20);
%% Parte2C.1 Modulacion QPSK para atravesar distintos canales
Mmod = 4; %Orden de modulacion: QPSK
Nb = simb*log2(Mmod); %Numero de bits totales
data= randi([0 1], Nb, 1); %Generacion de bits
%Modulamos
mod = modem.pskmod('M', Mmod, 'SymbolOrder','gray', 'InputType', 'bit');
modData = modulate(mod, data);
ecualizador = lineareq(10, lms(0.03));
%%
% Ahora simulamos los canales, en la funcion "efectocanal.m" está explicado
% el método utilizado
[BERawgn, BERmultisinec, BERdoppsinec, BERmulticonec, BERdoppconec] = efectocanal(vector_SNR, modData, data, mod, Nb, simb, ecualizador, 0);
%% Representaciones para QPSK
figure
semilogy(vector_SNR, BERawgn, '-r')
hold on
semilogy(vector_SNR, BERmultisinec, '-b')
hold on
semilogy(vector_SNR, BERdoppsinec, '-g')
hold on
semilogy(vector_SNR, BERmulticonec, '-m')
hold on
semilogy(vector_SNR, BERdoppconec, '-k')
legend ('AWGN', 'Multipath no ecualiz', 'Doppler no ecualiz', 'Multipath ecualizado', 'Doppler ecualizado');
title('Efectos del canal: QPSK')
xlabel('SNR(dB)');
ylabel('BER');
hold off
%% Parte 2C.2: SNR de 0 a 20dB usando modulaciones BPSK y DBPSK
Mmod = 2;
modbpsk = modem.pskmod('M', 2, 'SymbolOrder','gray', 'InputType', 'bit');
moddbpsk = modem.dpskmod('M', 2, 'SymbolOrder','gray', 'InputType', 'bit');
Nb = simb*log2(Mmod); %Numero de bits totales
data= randi([0 1], Nb, 1); %Generacion de bits
modDatabpsk = modulate(modbpsk, data);
modDatadbpsk = modulate(moddbpsk, data);
ecualizador = lineareq(10, lms(0.03));
%% Calculo de diversas BER para BPSK
[BERawgnbpsk, BERmultisinecbpsk, BERdoppsinecbpsk, BERmulticonecbpsk, BERdoppconecbpsk] = efectocanal(vector_SNR, modDatabpsk, data, modbpsk, Nb, simb, ecualizador, 0);
%% Representaciones para BPSK
figure
semilogy(vector_SNR, BERawgnbpsk, '-r')
hold on
semilogy(vector_SNR, BERmultisinecbpsk, '-b')
hold on
semilogy(vector_SNR, BERdoppsinecbpsk, '-g')
hold on
semilogy(vector_SNR, BERmulticonecbpsk, '-m')
hold on
semilogy(vector_SNR, BERdoppconecbpsk, '-k')
legend ('AWGN', 'Multipath no ecualiz', 'Doppler no ecualiz', 'Multipath ecualizado', 'Doppler ecualizado');
title('Efectos del canal: BPSK')
xlabel('SNR(dB)');
ylabel('BER');
hold off
%% Calculo de diversas BER para DBPSK
[BERawgndbpsk, BERmultisinecdbpsk, BERdoppsinecdbpsk, BERmulticonecdbpsk, BERdoppconecdbpsk] = efectocanal(vector_SNR, modDatadbpsk, data, moddbpsk, Nb, simb, ecualizador, 1);
%% Representaciones para DBPSK
figure
semilogy(vector_SNR, BERawgndbpsk, '-r')
hold on
semilogy(vector_SNR, BERmultisinecdbpsk, '-b')
hold on
semilogy(vector_SNR, BERdoppsinecdbpsk, '-g')
hold on
semilogy(vector_SNR, BERmulticonecdbpsk, '-m')
hold on
semilogy(vector_SNR, BERdoppconecdbpsk, '-k')
legend ('AWGN', 'Multipath no ecualiz', 'Doppler no ecualiz', 'Multipath ecualizado', 'Doppler ecualizado');
title('Efectos del canal: DBPSK')
xlabel('SNR(dB)');
ylabel('BER');
hold off
%% Gráficas adicionales
figure
semilogy(vector_SNR, BERawgn, '-r')
hold on
semilogy(vector_SNR, BERawgnbpsk, '-b')
hold on
semilogy(vector_SNR, BERawgndbpsk, '-m')
legend('QPSK', 'BPSK', 'DBPSK')
title('Comparacion modulaciones en canal AWGN')
xlabel('SNR(dB)')
ylabel('BER')
grid on
hold off
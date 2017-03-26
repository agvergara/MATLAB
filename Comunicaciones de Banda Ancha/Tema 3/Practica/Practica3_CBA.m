%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Practica 3: Banda ancha
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%
%Subportadoras
N1 = 32;
N2 = 256;
%Orden modulacion
Mmod1 = 4; %QPSK
Mmod2 = 64; %64-QAM

simb = 10000; %100000 simbolos OFDM
PAR1 = zeros(1, simb);
PAR2 = zeros(1, simb);
PAR3 = zeros(1, simb);
PAR4 = zeros(1, simb);
progreso = 1/(4*simb);
barra = waitbar(0, '1', 'Name', 'QPSK, 32subp');

%% 
% QPSK y 32 subportadoras
Nb = log2(Mmod1)*N1*simb;
for i = 1:simb
    bits = randi([0 1], Nb, 1);
    simbOFDM1 = createOFDM(Mmod1, bits, N1, 'psk');
    Pmean1 = mean(abs(simbOFDM1).^2);
    Pmax1 = max(abs(simbOFDM1).^2);
    PAR1(i) = (Pmax1/Pmean1);
    waitbar(progreso, barra, sprintf('%1i',i),'Name', 'QPSK, 32subp')
    progreso = progreso + (1/(4*simb));
end
% QPSK y 256 subportadoras
Nb = log2(Mmod1)*N2*simb;
barra = waitbar(progreso, '1', 'Name', 'QPSK, 256subp');
for i = 1:simb
    bits = randi([0 1], Nb, 1);
    simbOFDM2 = createOFDM(Mmod1, bits, N2, 'psk');
    Pmean2 = mean(abs(simbOFDM2).^2);
    Pmax2 = max(abs(simbOFDM2).^2);
    PAR2(i) = (Pmax2/Pmean2);
    waitbar(progreso, barra, sprintf('%1i',i), 'Name', 'QPSK, 256subp')
    progreso = progreso + (1/(4*simb));

end

% 64-QAM y 32 subportadoras
Nb = log2(Mmod2)*N1*simb;
barra = waitbar(progreso, '1', 'Name', '64-QAM, 32subp');
for i = 1:simb
    bits = randi([0 1], Nb, 1);
    simbOFDM3 = createOFDM(Mmod2, bits, N1, 'qam');
    Pmean3 = mean(abs(simbOFDM3).^2);
    Pmax3 = max(abs(simbOFDM3).^2);
    PAR3(i) = (Pmax3/Pmean3);
    waitbar(progreso, barra, sprintf('%1i',i),'Name', '64-QAM, 32subp')
    progreso = progreso + (1/(4*simb));
end

% 64-QAM y 256 subportadoras
Nb = log2(Mmod2)*N2*simb;
barra = waitbar(progreso, '1', 'Name', '64-QAM, 256subp');
for i = 1:simb
    bits = randi([0 1], Nb, 1);
    simbOFDM4 = createOFDM(Mmod2, bits, N2, 'qam');
    Pmean4 = mean(abs(simbOFDM4).^2);
    Pmax4 = max(abs(simbOFDM4).^2);
    PAR4(i) = (Pmax4/Pmean4);
    waitbar(progreso, barra, sprintf('%1i',i),'Name', '64-QAM, 256subp')
    progreso = progreso + (1/(4*simb));
end
delete(barra)
%% simbOFDM 1
PARmax1 = max(PAR1);
PARmean1 = mean(PAR1);
PAR1sort = sort(PAR1, 'descend');
99PAR1 = prctile(PAR1sort, 1);
figure
subplot(211)
hist(abs(simbOFDM1), 100);
title('32 subportadoras, QPSK');

subplot(212);
hist(PAR1, 100);
title('PAR QPSK y 32 subportadoras');
%% simbOFDM2
PARmax2 = max(PAR2);
PARmean2 = mean(PAR2);
PAR2sort = sort(PAR2, 'descend');
99PAR2 = prctile(PAR2sort, 1);

figure
subplot(211);
hist(abs(simbOFDM2), 100);
title('256 subportadoras, QPSK');
subplot(212);
hist(PAR2, 100);
title('PAR QPSK y 256 subportadoras');
%% simbOFDM3
PARmax3 = max(PAR3);
PARmean3 = mean(PAR3);
PAR3sort = sort(PAR3, 'descend');
99PAR3 = prctile(PAR3sort, 1);

figure
subplot(211);
hist(abs(simbOFDM3), 100);
title('32 subportadoras, 64-QAM');
subplot(212);
hist(PAR3, 100);
title('PAR 64-QAM y 32 subportadoras');
%% simbOFDM4
PARmax4 = max(PAR4);
PARmean4 = mean(PAR4);
PAR4sort = sort(PAR4, 'descend');
99PAR4 = prctile(PAR4sort, 1);

figure
subplot(211)
hist(abs(simbOFDM4), 100);
title('256 subportadoras, 64-QAM');
subplot(212);
hist(PAR4, 100);
title('PAR 64-QAM y 256 subportadoras');
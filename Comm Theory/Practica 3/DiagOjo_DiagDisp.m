clear all
close all

N = 16; Fd = 1; Fs = N * Fd; Delay = 3; Pd = 100; offset=0; M = 2;

msg_d = randint(Pd,1,M);
msg_tx = pammod(msg_d,M);
[y, t] = rcosflt(msg_tx, Fd, Fs);

yy = y(1+Delay*N:end-2*Delay*(N+2));

SNR = 15;
sig_rx = awgn(msg_tx,SNR,'measured',1234,'dB');
[fsig_rx, t2] = rcosflt(sig_rx, Fd, Fs);
tfsig_rx = fsig_rx(1+Delay*N:end-Delay*(N+1),:);
figure
plot(t, y,'b-', t2, real(fsig_rx),'r-');
title('Señal Modulada:');
legend('Señal Modulada','Con Ruido, SNR = 15dB');

h(1) = eyediagram(yy, N,1);
h(2) = eyediagram(tfsig_rx, N,1,0,'r-');

h(3) = scatterplot(yy, N, 0, 'b.');
h(4) = scatterplot(tfsig_rx, N, 0, 'r.');

real_tfsig_rx = real(tfsig_rx);
h(5) = scatterplot(real_tfsig_rx, N, 0, 'r.');

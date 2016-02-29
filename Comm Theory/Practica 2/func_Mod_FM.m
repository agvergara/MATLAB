function [] = func_Mod_FM(Fs,A1,f1,A2,f2,Fc,SNR)

t = [0:2*Fs+1]'/Fs;

x = A1 * sin(2*pi*f1*t) - A2 * sin(2*pi*f2*t);

phasedev = 10;
y = fmmod(x,Fc,Fs,phasedev);

y_n = awgn(y,SNR,'measured',103);

z = fmdemod(y_n,Fc,Fs,phasedev);

figure;
plot(t,x,'k-',t,z,'g-');
legend('Se�al Original','Se�al Demodulada FM');

figure;
subplot(4,1,1); plot(t,x);
title('Se�al Original')
subplot(4,1,2); plot(t,y);
title('Se�al Modulada FM')
subplot(4,1,3); plot(t,y_n);
title('Se�al Modulada FM + Ruido')
subplot(4,1,4); plot(t,z);
title('Se�al Demodulada FM')


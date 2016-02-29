function [] = func_Mod_AM(Fs,A1,f1,A2,f2,Fc,SNR)

t = [0:2*Fs+1]'/Fs;

x = A1 * sin(2*pi*f1*t) - A2 * sin(2*pi*f2*t);

phasedev = pi/2;
y = ammod(x,Fc,Fs,phasedev);

y_n = awgn(y,SNR,'measured',103);

z = amdemod(y_n,Fc,Fs,phasedev);

figure;
plot(t,x,'k-',t,z,'g-');
legend('Señal Original','Señal Demodulada AM');

figure;
subplot(4,1,1); plot(t,x);
title('Señal Original')
subplot(4,1,2); plot(t,y);
title('Señal Modulada AM')
subplot(4,1,3); plot(t,y_n);
title('Señal Modulada AM + Ruido')
subplot(4,1,4); plot(t,z);
title('Señal Demodulada AM')


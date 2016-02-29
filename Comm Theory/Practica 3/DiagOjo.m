clear all
close all

M = 2; Fd = 1; Fs = 10;
Pd = 100;
msg_d = randint(Pd,1,M);

msg_a = pammod(msg_d,M);

delay = 3;
rcv = rcosflt(msg_a,Fd,Fs,'fir/normal',0.5,delay);

N = Fs/Fd;
propdelay = delay .* N + 1;
rcv1 = rcv(propdelay:end-2*(propdelay-1),:);

h1 =  eyediagram(rcv1,N,1/Fd);
set(h1,'Name','Diagrama de Ojo');

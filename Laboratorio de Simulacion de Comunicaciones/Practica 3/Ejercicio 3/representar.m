function representar(n, h, channel0, channel1, fd)
    % Módulo Interpolador orden 0 (channel0)
    figure(1)
    subplot(2,3,n)
    stem(abs(h))
    hold on
    subplot(2,3,n)
    stem(abs(channel0),'r')
    legend('Canal original','Interp Orden 0')
    title('Módulo')
    title(['Módulo, Fd = ' num2str(fd(n))])
    
    % Fase Interpolador orden 0 (channel0)
    subplot(2,3,n+3)
    stem(angle(h))
    hold on
    subplot(2,3,n+3)
    stem(angle(channel0),'r')
    legend('Canal original','Interp Orden 0')
    title(['Fase, Fd = ' num2str(fd(n))])
    
    % Modulo Interpolador orden 1 (channel1)
    figure(2)
    subplot(2,3,n)
    stem(abs(h))
    hold on
    subplot(2,3,n)
    stem(abs(channel1),'r')
    legend('Canal original','Interp Orden 1')
    title('Módulo')
    title(['Módulo, Fd = ' num2str(fd(n))])
    
    % Fase Interpolador orden 1 (channel1)
    subplot(2,3,n+3)
    stem(angle(h))
    hold on
    subplot(2,3,n+3)
    stem(angle(channel1),'r')
    legend('Canal original','Interp Orden 1')
    title(['Fase, Fd = ' num2str(fd(n))])  
end
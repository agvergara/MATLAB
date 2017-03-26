function [channelRaygh, ganancias] = createRaychan(ts, fd, simbOFDM, snr_media, pot_chan)
channel = rayleighchan(ts, fd, (0:3)*ts, pot_chan); %Creamos el canal rayleigh con la funcion rayleighchan
% que toma como parámetros el tiempo de símbolo y el efecto doppler
channel.StorePathGains = 1; % Decimos que nos guarde las ganancias
h = filter(channel, simbOFDM);   
ganancias = channel.PathGains;   % Guardamos las ganancias de los rayos. Deberían salir iguales para todas las portadoras
% al estar dentro del BW de coherencia, pero realmente varian (poco, pero
% varian), para arreglar esto, se coge un valor que represente al canal
% (como la media). El valor escogido esta en la funcion "processOFDM"

noise = sqrt(1/(2*snr_media)) * (randn(size(h)) + 1i * randn(size(h))); %Creamos el ruido
channelRaygh = h + noise; %Canal Rayleigh
end
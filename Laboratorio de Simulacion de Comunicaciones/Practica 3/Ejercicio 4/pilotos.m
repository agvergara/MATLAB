function [est_chan, ECM] = pilotos(portadoras, instantes, N, h, BW)
    h_pilotos = h(1:portadoras:N, 1:instantes:BW); %Introducimos pilotos en cada uno de estos valores
    [X, Y] = meshgrid((1:portadoras:N),(1:instantes:BW));
    %Interpolamos
    X = X.';
    Y = Y.';
    vector_inst = (1:BW); %Vector de todos los instantes
    vector_port = (1:N); %Vector de todas las portadoras
    %Interpolacion
    est_chan = interp2(Y, X, h_pilotos, vector_inst, vector_port.');
    start_port = N-portadoras; %Empezamos en N - portadoras
    start_inst = BW-instantes; %Empezamos en el instante BW - instantes
    %Introducimos pilotos cada:
    
    %Portadoras
    for n = 1:portadoras
        est_chan(start_port+n,:) = est_chan(start_port, :);
    end
    
    %Instantes
    for m = 1:instantes
        est_chan(:, start_inst+m) = est_chan(:, start_inst);
    end
    %Error cuadratico medio:
    ECM = abs(mean(mean((h - est_chan).^2)));
end
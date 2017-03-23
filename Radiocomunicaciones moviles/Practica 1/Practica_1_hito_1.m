% -------------------------------------------------------------------------
%                          PR?CTICA 1. HITO 1.
%
%           Receptores con diversidad: Combinador Selectivo y 
%                        Maximum Ratio Combining.
% -------------------------------------------------------------------------
%clear all
%clc
% Par?metros simulaci?n
    %BER = input('Introduce la BER deseada');
   % N = 10/BER;  % Numero de s?mbolos.
    N = 10^6;
    Px = 1;   % Potencia de la se?al transmitida: normalizada
    sigm_h = 1; % Varianza del canl: normalizado.
    vector_SNR = (0:1:20); % Relaciones se?al a ruido
    s1 = 1; % S?mbolos BPSK
    s2 = -1;

%% Simulaci?n

    % Inicializaci?n vectores
    h = zeros(1,N);
    n = zeros(1,N);
    y = zeros(1,N);
    y_filt = zeros(1,N);
    ber = zeros(size(vector_SNR));
    
%% Bucle sobre SNR.
    k = 1;
    for SNR = vector_SNR,
    
        % Generaci?n de se?al (BPSK, Potencia Unidad)
        x = ((round(rand(1,N))* 2) - 1) * sqrt(Px);

        % Generaci?n de los coeficientes del canal Rayleigh
        h1 = (randn(1,N) + 1i.*randn(1,N)) * sqrt(1/2);
        h2 = (randn(1,N) + 1i.*randn(1,N)) * sqrt(1/2);
        h3 = (randn(1,N) + 1i.*randn(1,N)) * sqrt(1/2);

        % Generaci?n del ruido
        snr = 10^(SNR/10);
        n1 = (randn(length(x),1) + 1i.*randn(length(x),1)) * (1/sqrt(Px)) * sqrt(1/snr);
        n2 = (randn(length(x),1) + 1i.*randn(length(x),1)) * (1/sqrt(Px)) * sqrt(1/snr);
        n3 = (randn(length(x),1) + 1i.*randn(length(x),1)) * (1/sqrt(Px)) * sqrt(1/snr);

        % Introducimos la se?al en el canal (es un canal plano)
        y1 = x.*h1+n1';
        y2 = x.*h2+n2';
        y3 = x.*h3+n3';

        %% DESCOMENTAR UNO DE LOS DOS COMBINADORES:
        
%% COMBINADOR MRC:
%             % Filtro (multiplicaci?n por el conjugado del canal, en cada rama)
%             y1_filt = y1 .* conj(h1);
%             y2_filt = y2 .* conj(h2);
% 
%             % Suma de las se?alas recibidas filtradas.
%             y_MRC = y1_filt + y2_filt; 
%         
%             % Canal equivalente MRC
%             h_COMBINADOR = ;
%         
%% COMBINADOR SC:
%             idx1 = find(abs(h1)>abs(h2)); % Instantes en los que el canal h1 es mejor que el h2.
%             idx2 = find(abs(h2)>abs(h1)); % Instantes en los que el canal h2 es mejor que el h1.
%             
%             h_COMBINADOR(idx1) = h1(idx1); % Cuando es mejor h1: h_COMBINADOR = h1
%             h_COMBINADOR(idx2) = h2(idx2); % Cuando es mejor h2: h_COMBINADOR = h2
%              
%              y_SC(idx1) = y1;     % Cuando es mejor h1: el receptor se queda con y1.
%              y_SC(idx2) = y2;     % Cuando es mejor h2: el receptor se queda con y2.       
%             
% %% DETECTOR ML:
%         arg1 = abs(y_MRC - h_COMBINADOR.*s1);
%         arg2 = abs(y_MRC - h_COMBINADOR.*s2);
%         x_MRC = ((arg1<arg2)*2)-1; % Un poco tricky, pero vale.
% 
% %% C?lculo de la BER
%         %berMRC(k) = mean((x_MRC~=x));
%         berSC(k) = mean((x_SC~=x));
%         berRX(k) = mean((xRX~=x));
    berRX1(k) = combinadores('none', x, y1, 0, 0, h1, 0, 0, k, s1, s2);
    berSC2(k) = combinadores('SC', x, y1, y2, 0, h1, h2, 0, k, s1, s2);
    berMRC2(k) = combinadores('MRC', x, y1, y2, 0, h1, h2, 0, k, s1, s2);
    berSC3(k) = combinadores('SC', x, y1, y2, y3, h1, h2, h3, k, s1, s2);
    berMRC3(k) = combinadores('MRC', x, y1, y2, y3, h1, h2, h3, k, s1, s2);
    k=k+1;    
    end
    semilogy(vector_SNR, berRX1, '-b');
    hold on
    semilogy(vector_SNR, berSC2, '-r');
    hold on
    semilogy(vector_SNR, berMRC2, '-g');
    hold on
    semilogy(vector_SNR, berSC3, '-k');
    hold on
    semilogy(vector_SNR, berMRC3, '-m');
    legend ('1 Antena', '2 Antenas + SC', '2 Antenas + MRC', '3 Antenas + SC', '3 Antenas + MRC');
    xlabel('SNR(dB)');
    ylabel('BER');
    title('BER/SNR');
    grid on
    hold off

    
    
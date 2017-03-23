% -------------------------------------------------------------------------
%                          PR?CTICA 1. HITO 2.
%
%                Sistema con codificaci?n de canal BCH.
% -------------------------------------------------------------------------

% clear all;

% Par?metros simulaci?n
    n = 15; % Long. palabra del c?digo BCH.
    k = 5; % Long. palabra de entrada para el c?digo.
    L = 1e4;
    N = k*L; % N?mero de bits totales.
    
    Px = 1;   % Potencia de la se?al transmitida: normalizada
    sigm_h = 1; % Varianza del canl: normalizado.
    vector_SNR = (0:1:20); % Relaciones se?al a ruido
    s1 = 1; % S?mbolos BPSK
    s2 = -1;


    ber = zeros(size(vector_SNR));
    m = 1;
    for SNR = vector_SNR,
    m
        % Generaci?n de los bits
        b = randi([0 1], L, k); % Generamos una matriz de L filas y k columnas de bits.
        
        % Codificaci?n BCH
        msg = gf(b);
        c = bchenc(msg,n,k);
        bits_cod = double(c.x);
        
        % Modulaci?n
        x = ((bits_cod-0.5).*2) * sqrt(Px); % Modulador muy sencillo BPSK. Obs?rvense las dimensiones de x.
        
        % Generaci?n de los coeficientes del canal.
        %h = (randn(size(x)) + 1i.*randn(size(x))) * sqrt(sigm_h/2); % h es Rayleigh y tiene las dimensiones de x.

        % CANAL PARA EL HITO 2.3
        % Ahora asumimos que h se mantiene constante durante un bloque de
        % codificaci?n de 7 bits, es decir, en cada fila es siempre igual,
        % por lo que generamos 1 muestra de canal para cada bloque de
        % codificaci?n (cada fila) y luego repetimos esa muestra n veces.
         h = ( randn(length(x),1 ) + j.*randn(length(x),1 ) ) * sqrt(sigm_h/2); % Vector columna
         h = repmat(h, 1, n); % Matriz L*n
        
        % Generaci?n del ruido
        snr = 10^(SNR/10);
        w =  (randn(size(x)) + 1i.*randn(size(x))) * (1/sqrt(2)) * sqrt(1/snr); % el ruido tiene las mismas dimensiones que x;

        % Introducimos la se?al en el canal.
        y = x.*h + w; % La se?al recibida tendr? dimensiones L*n

        % Recepci?n ML (x_ML = argmin{|y-hx|^2}
        arg1 = abs(y - h.*s1);
        arg2 = abs(y - h.*s2);
        x_ML = ((arg1<arg2)*2)-1;
        bits_recibidos = (x_ML - s2) / ( s1 - s2 ); %Normalizamos
        
        % Decodificaci?n BCH (MIRAR ENUNCIADO DE LA PR?CTICA)
        c_dec = bchdec(gf(bits_recibidos),n,k);
        br_dec = double(c_dec.x);
        
        % C?lculo de la BER
        %berbch(m) = mean((br_dec(:)~=b(:)));
        ber(m) = mean((br_dec(:)~=b(:)));
    m=m+1;
    end
%%
figure;    
semilogy(vector_SNR, berRX1, '-m');
hold on
semilogy(vector_SNR, berbch, '-r');
semilogy(vector_SNR, berMRC2, '-b');
semilogy(vector_SNR, berSC2, '-g');
semilogy(vector_SNR, ber, '-k');
legend ('Sin codif.', 'Codif. BCH', '2 Antenas + MRC', '2 Antenas + SC', 'Nuevo canal');
xlabel('SNR(dB)');
ylabel('BER');
title('BER/SNR');
grid on
hold off


% PUEDE A?ADIR AQU? EL C?DIGO DEL OTRO HITO PARA LA SIMULACI?N DEL SISTEMA SOBRE 
% CANAL RAYLEIGH SIN CODIFICACI?N.
function BER = combinadores(s, x, y1, y2, y3, h1, h2, h3, k, s1, s2)
if strcmp(s,'MRC')
% COMBINADOR MRC:
            % Filtro (multiplicaci?n por el conjugado del canal, en cada rama)
            y1_filt = y1 .* conj(h1);
            y2_filt = y2 .* conj(h2);
            if h3 ~= 0 & y3 ~= 0
                y3_filt = y3 .* conj(h3);
            end
            % Suma de las se?alas recibidas filtradas.
            % Canal equivalente MRC

            if h3 ~= 0 & y3 ~= 0 
                y_RX = y1_filt + y2_filt + y3_filt; 
                h_COMBINADOR = abs(h1).^2 + abs(h2).^2 + abs(h3).^2;
            else
                y_RX = y1_filt + y2_filt;
                h_COMBINADOR = abs(h1).^2 + abs(h2).^2;
            end
elseif strcmp(s,'SC')     
% COMBINADOR SC:

             if h3 ~= 0 & y3 ~= 0
                 idx1 = find(abs(h1)>abs(h2)& abs(h1)>abs(h3)); % Instantes en los que el canal h1 es mejor que el h2 y h3.
                 idx2 = find(abs(h2)>abs(h1)& abs(h2)>abs(h3)); % Instantes en los que el canal h2 es mejor que el h1 y h3.
                 idx3 = find(abs(h3)>abs(h1)& abs(h3)>abs(h2)); % Instantes en los que el canal h3 es mejor que el h1 y h2.
             else
                 idx1 = find(abs(h1)>abs(h2));% && abs(h1)>abs(h3)); % Instantes en los que el canal h1 es mejor que el h2.
                 idx2 = find(abs(h2)>abs(h1));% && abs(h2)>abs(h3)); % Instantes en los que el canal h2 es mejor que el h1.
             end
             
             h_COMBINADOR(idx1) = h1(idx1); % Cuando es mejor h1: h_COMBINADOR = h1
             h_COMBINADOR(idx2) = h2(idx2); % Cuando es mejor h2: h_COMBINADOR = h2
             if h3 ~= 0 & y3 ~= 0
                 h_COMBINADOR(idx3) = h3(idx3); % Cuando es mejor h3: h_COMBINADOR = h3
             end
             
             y_RX(idx1) = y1(idx1);     % Cuando es mejor h1: el receptor se queda con y1.
             y_RX(idx2) = y2(idx2);     % Cuando es mejor h2: el receptor se queda con y2.
             if h3 ~= 0 & y3 ~= 0
                y_RX(idx3) = y3(idx3);     % Cuando es mejor h2: el receptor se queda con y2. 
             end
else
    y_RX = y1;
    h_COMBINADOR = h1;
end           
% DETECTOR ML:
        arg1 = abs(y_RX - h_COMBINADOR.*s1);
        arg2 = abs(y_RX - h_COMBINADOR.*s2);
        x_RX = ((arg1<arg2)*2)-1; % Un poco tricky, pero vale.

% C?lculo de la BER
        BER = mean((x_RX~=x));
end
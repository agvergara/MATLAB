function [txData, modData, mod, dataPar] = createOFDM(Mmod, bits, N, PC)
%Función que crea un simbolo OFDM a partir de los bits a transmitir, la
%modulacion a utilizar, numero de portadoras y de prefijo cíclico.
%Bloques:

%% Modulacion de los datos:
mod =  modem.pskmod('M',Mmod,'SymbolOrder','gray', 'InputType', 'bit'); 
modData = modulate(mod, bits);

%%  Conversor serie/paralelo
dataPar = reshape(modData, N, ceil(length(modData)/N)); %Crea una matriz de MxN a partir de los datos modulados
% para convertir los simbolos a paralelo ya que tenemos una ifft de 64
% puntos (64 patas) para que entren todos los símbolos

%% IFFT:
dataIFFT = sqrt(N) * ifft(dataPar, N); %Realizamos la IFFT de los datos de N puntos

%% Ponemos el prefijo cíclico:
dataPC = [dataIFFT((N-(PC-1)):N,:); dataIFFT]; % Añadimos el PC, para todas las filas, copiamos las 8 últimas posiciones
% al principio -> dataIFFT((N-(PC-1)):N, :), durante todos los datos de
% dataIFFT

%% Conversor paralelo/serie:
txData = dataPC(:); %Convertimos a serie otra vez para transmitir
end
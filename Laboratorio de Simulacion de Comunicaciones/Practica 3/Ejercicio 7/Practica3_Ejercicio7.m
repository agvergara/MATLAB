% **********************************************
% Practia 3, ejercicio 7: TDMA
% Antonio Gomez Vergara - GIST
% **********************************************
clear all
close all
clc
%% Ejercicio 7.1
BW = 10000; %Ancho de banda, en Hz
snr_media = 10^(15/10); %En dB
Mmod1 = 64; %64QAM
Mmod2 = 16; %16QAM
Mmod3 = 4; %4QAM
BER_Umbral = 1e-3;
M = 6; %6 users

users = zeros(1, BW); %Registro de usuarios, al ser RR, irán en orden 1-6 todo el rato. Para ver quien transmite en 
% que instante
Nb_users = zeros(M, 1); %Cantidad de bits a transmitir por cada usuario

%Canal:
channel = sqrt(1/2)*(randn(M,BW)+1i*randn(M,BW));

%Vectores booleanos para ver que porcentaje del tiempo se transmite en 4,
%16, 64QAM o no se transmite
bool_4QAM = zeros(BW, 1);
bool_16QAM = zeros(BW, 1);
bool_64QAM = zeros(BW, 1);
bool_noTX = zeros(BW, 1);

for i = 1:BW
    %Vemos que user accede al canal
    user = mod(i-1, M) + 1; %Round Robin
    users(i) = user;
    
    %Calculamos las BER para las 3 modulaciones:
    BER4(i) = .2*exp(-snr_media*abs(channel(user,i))^2/(Mmod3-1));
    BER16(i) = .2*exp(-snr_media*abs(channel(user,i))^2/(Mmod2-1));
    BER64(i) = .2*exp(-snr_media*abs(channel(user,i))^2/(Mmod1-1));
    
    %Vemos que BER supera el umbral:
    if BER64(i) < BER_Umbral
        Nb_users(user) = Nb_users(user) + log2(Mmod1); %Bits transmitidos
        bool_64QAM(i) = 1; %Se TX con 64QAM -> True
    elseif BER16(i) < BER_Umbral
        Nb_users(user) = Nb_users(user) + log2(Mmod2); %Bits transmitidos
        bool_16QAM(i) = 1; %Se TX con 16QAM -> True
    elseif BER4(i) < BER_Umbral
        Nb_users(user) = Nb_users(user) + log2(Mmod3); %Bits transmitidos
        bool_4QAM(i) = 1; %Se TX con 4QAM -> True
    else
        Nb_users(user) = Nb_users(user); %Bits transmitidos
        bool_noTX(i) = 1; %No se transmite -> True
    end
end

%%
prob_noTX = sum(bool_noTX)/100; %Probabilidad no transmitir
prob_4QAM = sum(bool_4QAM)/100; %Probabilidad transmitir con 4QAM
prob_16QAM = sum(bool_16QAM)/100; %Probabilidad transmitir con 16QAM
prob_64QAM = sum(bool_64QAM)/100; %Probabilidad transmitir con 64QAM
disp('Ejercicio 7.1');
for user = 1:M
    disp(['Tasa media user ', num2str(user), ': ', num2str(Nb_users(user)/BW)]);
end
disp(' ');
disp(['Probabilidad de no transmitir: ', num2str(prob_noTX)]);
disp(['Probabilidad de transmitir en 4QAM: ', num2str(prob_4QAM)]);
disp(['Probabilidad de transmitir en 16QAM: ', num2str(prob_16QAM)]);
disp(['Probabilidad de transmitir en 64QAM: ', num2str(prob_64QAM)]);

%% Ejercicio 7.2
%Re-inicializamos los vectores, el resto de variables es igual al del ejercicio 7.1:
users = zeros(1, BW); %Registro de usuarios, al ser RR, irán en orden 1-6 todo el rato. Para ver quien transmite en 
% que instante
Nb_users = zeros(M, 1); %Cantidad de bits a transmitir por cada usuario

%Canal:
channel = sqrt(1/2)*(randn(M,BW)+1i*randn(M,BW));

%Vectores booleanos para ver que porcentaje del tiempo se transmite en 4,
%16, 64QAM o no se transmite
bool_4QAM = zeros(BW, 1);
bool_16QAM = zeros(BW, 1);
bool_64QAM = zeros(BW, 1);
bool_noTX = zeros(BW, 1);

tiempo_user = zeros(M, 1); %Cuanto tiempo lleva sin transmitir un user

modulaciones = [64 16 4]; %Para ver que modulacion transmite
%Es parecido al apartado anterior
for i = 1:BW
   %Ahora el usuario que transmite es el que mayor modulacion tenga:
   for user = 1:M
        for mod = 1:length(modulaciones)
            BER(user,mod) = .2*exp(-snr_media*abs(channel(user,i))^2/(modulaciones(mod)-1)); %Elegimos la modulacion
        end
   end
   choose = BER < BER_Umbral;
   if sum(choose(:,1)) == 1
        % Transmite con 64QAM
            [optimo] = find(choose(:,1) == 1);
            modulacion = 1; %Posicion en array
   elseif sum(choose(:,1)) >= 2
        % Se elige a uno para transmitir con 64QAM
            [user] = find(choose(:,1) == 1);
            modulacion = 1;%Posicion en array
            [max,pos] = max(tiempo_user(user));
            optimo = user(pos);
   elseif sum(choose(:,2)) == 1
        % Transmite con 16
            [optimo] = find(choose(:,2) == 1);
            modulacion = 2;%Posicion en array
   elseif sum(choose(:,2)) >= 2
        % Se elige a uno para transmitir con 16QAM
            [user] = find(choose(:,2) == 1);
            modulacion = 2;%Posicion en array
            [max,pos] = max(tiempo_user(user));
            optimo = user(pos);
   elseif sum(choose(:,3)) == 1
        % Se transmite con 4QAM
            [optimo] = find(choose(:,3) == 1);
            modulacion = 3;%Posicion en array
   elseif sum(choose(:,3)) >= 2
        % Se elige a uno para transmitir con 4QAM
            [user] = find(choose(:,3) == 1);
            modulacion = 3;%Posicion en array
            [max,pos] = max(tiempo_user(user));
            optimo = user(pos);
   else
        modulacion = 0;%Posicion en array (no hay)
        optimo = 0;
   end
   
    % Se actualiza el timer
    if optimo == 0
        optimo = 1;
        users(i) = optimo;
    else
        tiempo_user = tiempo_user +1;
        tiempo_user(optimo) = 1;
        reg_usuarios(i) = optimo;
        Nb = Nb_users(optimo);       
    end
    
    clearvars user max pos %Limpiamos estas variables o casca
    
    %Se calcula la tasa
    if modulacion == 1
        Nb_users(optimo) = Nb_users(optimo) + log2(modulaciones(1));
        bool_64QAM(i) = 1;
    elseif modulacion == 2
        Nb_users(optimo) = Nb_users(optimo) + log2(modulaciones(2));
        bool_16QAM(i) = 1;
    elseif modulacion == 3 
        Nb_users(optimo) = Nb_users(optimo) + log2(modulaciones(3));
        bool_4QAM(i) = 1;
    else
        Nb_users(optimo) = Nb_users(optimo);
        bool_noTX(i) = 1;
    end
    clearvars optimo
end
%%
prob_noTX = sum(bool_noTX)/100; %Probabilidad no transmitir
prob_4QAM = sum(bool_4QAM)/100; %Probabilidad transmitir con 4QAM
prob_16QAM = sum(bool_16QAM)/100; %Probabilidad transmitir con 16QAM
prob_64QAM = sum(bool_64QAM)/100; %Probabilidad transmitir con 64QAM
disp(' ');
disp('Ejercicio 7.2');
for user = 1:M
    disp(['Tasa media user ', num2str(user), ': ', num2str(Nb_users(user)/BW)]);
end
disp(' ');
disp(['Probabilidad de no transmitir: ', num2str(prob_noTX)]);
disp(['Probabilidad de transmitir en 4QAM: ', num2str(prob_4QAM)]);
disp(['Probabilidad de transmitir en 16QAM: ', num2str(prob_16QAM)]);
disp(['Probabilidad de transmitir en 64QAM: ', num2str(prob_64QAM)]);

function [] = gamma1()
clc
clear

%Parametros del sistema: 
disp("Parametros de la grafica: k1 = 1, a1=4, k2 = 1, a2 = 8")
k1 = 1; a1=4;k2 = 1; a2=8;
k3 = 1; a3=6;k4 = 1; a4=10; 
disp("...........")

disp("Intervalo de las graficas = [4, 10]")

disp("...........")
disp("1 - Disyuncion estandar")
disp("2 - Suma algebraica")
disp("3 - Suma acotada")
disp("4 - Drástica")
disp(".....")

%Union: 
union = input("Union: ",'s'); 

%Valor de X: 
x_t = input("Valor de x: ", 's');
x_t = str2num(x_t);

%Init vector: 
ts = vector_tiempo(0.001, 0, x_t);

[rows, cols] = size(ts);
u_gamma1 = zeros(rows, cols); 
u_gamma1_inv = zeros(rows, cols); 
u_disyuncion_gamma1 = zeros(rows, cols);
u_gamma2 = zeros(rows, cols); 
u_gamma2_inv = zeros(rows, cols); 
u_disyuncion_gamma2 = zeros(rows, cols);

u_union = zeros(rows, cols); 
%% Grafica 1: 
%Generacion de senales: 
for i=1:cols
    if ts(:,i) <= a1
        u_gamma1(:,i) = 0; 
    else
        u_gamma1(:,i) = 1 - exp(-k1 * (ts(:,i) - a1)^2);
    end
end

%Invirtiendo la grafica: 
for i=1:cols
    if ts(:,i) >= a2
        u_gamma1_inv(:,i) = 0; 
    else
        u_gamma1_inv(:,i) = 1 - exp(-k2 * (ts(:,i) - a2)^2);
    end
end

%% Grafica 2: 
%Generacion de senales: 
for i=1:cols
    if ts(:,i) <= a3
        u_gamma2(:,i) = 0; 
    else
        u_gamma2(:,i) = 1 - exp(-k3 * (ts(:,i) - a3)^2);
    end
end

%Invirtiendo la grafica: 
for i=1:cols
    if ts(:,i) >= a4
        u_gamma2_inv(:,i) = 0; 
    else
        u_gamma2_inv(:,i) = 1 - exp(-k4 * (ts(:,i) - a4)^2);
    end
end


%% %% Disyuncion: 
%Union de gama1 y gamma inv:
u_disyuncion_gamma1 = min(u_gamma1,u_gamma1_inv);
u_disyuncion_gamma2 = min(u_gamma2, u_gamma2_inv);

%% Switch section: 
switch union
    case "1"
        u_union = max(u_disyuncion_gamma1, u_disyuncion_gamma2);        
    case "2"
        u_union = u_disyuncion_gamma1 + u_disyuncion_gamma2 - u_disyuncion_gamma1.*u_disyuncion_gamma2;
       
    case "3"
        u_union = min(1, u_disyuncion_gamma1 + u_disyuncion_gamma2); 
        
    case "4"
        for i = 1:cols
            if u_disyuncion_gamma2(:,i) == 0
                u_union(:,i) = u_disyuncion_gamma1(:,i);
            elseif u_disyuncion_gamma1(:,i) == 0 
                u_union(:,i) = u_disyuncion_gamma2(:,i); 
            else
                u_union(:,i) = 1;
            end
        end   
end

%% Graficas: 
%Grafica 1: 
tiledlayout(3,1)
nexttile
disp("u_A(x) = " + u_disyuncion_gamma1(:,cols));
disp("u_B(x) = " + u_disyuncion_gamma2(:,cols));
disp("u_A(x) U u_B(x) = " + u_union(:,cols));
plot(ts, u_union);
title("Union")

nexttile
plot(ts, u_disyuncion_gamma1);
title("Grafica A")

nexttile
plot(ts,u_disyuncion_gamma2)
title("Grafica B")

end
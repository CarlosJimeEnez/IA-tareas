clc
clear all

ts = vector_tiempo(0.001, 0, 10); 
%Parametros de A: 
disp('(Gaussiana) Parmateros de A:  k1 = 1, m1 = 5')
k1 = 1; m1 = 5; 
%disp('Intervalo de la grafica = [2.5, 8]')

%Paramtetros de B:
disp('(Pseudo exponencial)Parametros de B: k1 = 1, m1 = 5')
k2 = 1; m2 = 5; 
%disp('Intervalo de la grafica: [2.5, 10]')

%Paramtetros de A':
disp('(Pseudo exponencial)Parametros de B: k1 = 3, m1 = 5')
k3 = 2; m3 = 5; 
%disp('Intervalo de la grafica: [2.5, 10]')


% Tamaño de los vectores: 
[rows, cols] = size(ts);
a_gaussiana = zeros(rows, cols); 
b_pseudo = zeros(rows, cols); 
a_dif_pseudo= zeros(rows, cols); 
b_dif_pseudo = zeros(rows, cols); 

%%

% Generacion de la grafica A: 
for j = 1:cols
    a_gaussiana(:,j) = exp(-k1*(ts(:,j)-m1)^2);
end

%Generacion de la grafica B: 
for j = 1:cols
    b_pseudo(:,j) = 1/(1+k2*(ts(:,j) - m2)^2);
end


%Generacion de la grafica A': 
for j = 1:cols
    a_dif_pseudo(:,j) = 1/(1+k3*(ts(:,j) - m3)^2);
end

%% R(x,y)

fun_r = zeros(rows, cols); 
% fun_r guarda los valores de la funcion R() = min(1, 1 - A + B)

% y guarda los valores de la forma: 
% %Salida y(i,j):
%     y1        y2             y++
% x1  1.0000    0.9000         0         0
% x2  1.0000    0.4000         0         0
y = zeros(cols, cols); 

%Donde i es el recorrido por A y j por B
for i = 1:cols
    for j = 1:cols
        fun_r(:,j) = min(1, 1 - a_gaussiana(:,i) + b_pseudo(:,j));
        y(i,j) = fun_r(:,j);
    end 
end


%% Bprima: 
% Buscamos el valor minimo de la forma: min(A', R(x', y))
b_min = zeros(cols, cols); 


for i = 1:cols
    for j = 1:cols
        b_min(i, j) = min(a_dif_pseudo(:,j), y(j,i));
    end
end

% b_min guarda los valores del modo: 
%b_min   = [minimos de B(y1), 
%          minimos de B(y2), 
%           ...]

for j = 1:cols
    b_dif_pseudo(:,j) = max( b_min(j,:));
end


%% Display graficas: 
%
tiledlayout(4,1)
nexttile
plot(ts, a_gaussiana)
title("Grafica A")

nexttile
plot(ts, b_pseudo)
title("Grafica B")

nexttile
plot(ts, a_dif_pseudo)
title("Grafica A'")

nexttile
plot(ts, b_dif_pseudo)
title("Grafica B'")



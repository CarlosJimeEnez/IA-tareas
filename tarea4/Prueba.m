%% Prueba: 
clc
clear

A = [0.5, 1, 0.6]; 
B = [1 , 0.4]; 
A_prima = [0.6 , 0.9, 0.7]; 

fun_r = [0,0,0,0,0,0]; 
y = [0,0,0,0]; 
b_min = [0,0];

%R: 
%Donde i es el recorrido por A y j por B
for i = 1:3
    for j = 1:2
        fun_r(:,j) = min(1, 1 - A(:,i) + B(:,j));
        y(i,j) = fun_r(:,j); 
    end
end

%Salida y(i,j):
%    y1        y2        
% x1 1.0000    0.9000         0         0
% x2 1.0000    0.4000         0         0

disp('y: ')
disp(y)

%B: 
for i = 1:3
    for j = 1:2
        b_min(i,j) = min(A_prima(:,j), y(j,i));     
    end
end

%Minimos 
disp(b_min)
%     0.6000    0.9000
%     0.6000    0.4000
            
%b_min   = [minimos de y1, 
%          minimos de y2, ...]
















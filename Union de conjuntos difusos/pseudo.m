function [] = pseudo()
clc
clear

disp("Parametros de la grafica: k1 = 1, m1 = 5, k2 = 1, m2 = 6")
%Parametros del sistema: 
k1 = 1; m1=5; 
k2 = 1; m2=6; 
disp("...........")

disp("Intervalo de las graficas = [2.5, 10]")

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
u_psd_gaussiana1 = zeros(rows, cols); 
u_psd_gaussiana2 = zeros(rows, cols); 
u_union = zeros(rows, cols);

%Generacion de senales: 
for i=1:cols
    u_psd_gaussiana1(:,i) = 1/(1+k1*(ts(:,i) - m1)^2);
end

for i=1:cols
    u_psd_gaussiana2(:,i) = 1/(1+k2*(ts(:,i) - m2)^2);
end


%Union:  
switch union
    case "1"
        u_union = max(u_psd_gaussiana1, u_psd_gaussiana2);        
    case "2"
        u_union = u_psd_gaussiana1 + u_psd_gaussiana2 - u_psd_gaussiana1.*u_psd_gaussiana2;
       
    case "3"
        u_union = min(1, u_psd_gaussiana1 + u_psd_gaussiana2); 
        
    case "4"
        for i = 1:cols
            if u_psd_gaussiana2(:,i) == 0
                u_union(:,i) = u_psd_gaussiana1(:,i);
            elseif u_psd_gaussiana1(:,i) == 0 
                u_union(:,i) = u_psd_gaussiana2(:,i); 
            else
                u_union(:,i) = 1;
            end
        end   
end

 tiledlayout(3,1)
 nexttile
 disp("u_A(x) = " + u_psd_gaussiana1(:,cols));
 disp("u_B(x) = " + u_psd_gaussiana2(:,cols));
 disp("u_A(x) U u_B(x) = " + u_union(:,cols));
 plot(ts, u_union);
 title("Union")

 nexttile
 plot(ts,u_psd_gaussiana1)
 title("Grafica A")

 nexttile
 plot(ts, u_psd_gaussiana2)
 title("Grafica B")
end
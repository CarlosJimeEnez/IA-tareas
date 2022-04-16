function [] = Trapezoidal()
clc
clear

disp("Parametros del triagulo 1: a1=3, b1=9, m1=6")
disp("Parametros del triagulo 2: a2=6, b2=12, m2=9")
disp("...........")
disp("Intervalo = [3, 13]")
disp("...........")
disp("1 - Disyuncion estandar")
disp("2 - Suma algebraica")
disp("3 - Suma acotada")
disp("4 - Drástica")
disp(".....")
%Union: 
union = input("Union: ",'s'); 
%Parametros del sistema: 
a1 = 3; b1=5; c1=8; d1=10;
a2 = 6; b2=8; c2=11 ; d2=13; 


%Valor de X: 
x_t = input("Valor de x: ", 's');
x_t =  str2num(x_t);

%Init vector: 
ts = vector_tiempo(0.001, 0, x_t);

[rows, cols] = size(ts);
u_trap1 = zeros(rows, cols); 
u_trap2 = zeros(rows, cols); 
u_union = zeros(rows, cols);

%Generacion de triangulos: 
u_trap1 = generate_trap(rows, cols, a1, b1, c1, d1, ts); 
u_trap2 = generate_trap(rows, cols, a2, b2, c2, d2, ts); 

%Union: 
 
switch union
    case "1"
        u_union = max(u_trap1, u_trap2);        
    case "2"
        u_union = u_trap1 + u_trap2 - u_trap1.*u_trap2;
       
    case "3"
        u_union = min(1, u_trap1 + u_trap2); 
        
    case "4"
        for i = 1:cols
            if u_trap2(:,i) == 0
                u_union(:,i) = u_trap1(:,i);
            elseif u_trap1(:,i) == 0 
                u_union(:,i) = u_trap2(:,i); 
            else
                u_union(:,i) = 1;
            end
        end   
end

 tiledlayout(3,1)
 nexttile
 disp("u_A(x) = " + u_trap1(:,cols));
 disp("u_B(x) = " + u_trap2(:,cols));
 disp("u_A(x) U u_B(x) = " + u_union(:,cols));
 plot(ts, u_union);
 title("Union")

 nexttile
 plot(ts,u_trap1)
 title("Grafica A")

 nexttile
 plot(ts, u_trap2)
 title("Grafica B")
end
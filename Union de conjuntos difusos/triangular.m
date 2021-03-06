function[] =  triangular()
    clc
    clear
    
    disp("Parametros del triagulo 1: a1=3, b1=9, m1=6")
    disp("Parametros del triagulo 2: a2=6, b2=12, m2=9")
    disp("...........")
    disp("Intervalo = [3, 12]")
    disp("...........")
    disp("1 - Disyuncion estandar")
    disp("2 - Suma algebraica")
    disp("3 - Suma acotada")
    disp("4 - Drástica")
    disp(".....")
    %Union: 
    union = input("Union: ",'s'); 
    %Parametros del sistema: 
    a1 = 3; b1=9; m1=6;
    a2 = 6; b2=12; m2=9; 


    %Valor de X: 
    x_t = input("Valor de x: ", 's');
    x_t =  str2num(x_t);

    %Init vector: 
    ts = vector_tiempo(0.001, 0, x_t);
    
    [rows, cols] = size(ts);
    u_trian1 = zeros(rows, cols); 
    u_trian2 = zeros(rows, cols); 
    u_union = zeros(rows, cols);
    
    %Generacion de triangulos: 
    u_trian1 = generate_trian(rows, cols, a1, b1, m1, ts); 
    u_trian2 = generate_trian(rows, cols, a2, b2, m2, ts); 
    
    %Union: 
     
    switch union
        case "1"
            u_union = max(u_trian1, u_trian2);        
        case "2"
            u_union = u_trian1 + u_trian2 - u_trian1.*u_trian2;
           
        case "3"
            u_union = min(1, u_trian1 + u_trian2); 
            
        case "4"
            for i = 1:cols
                if u_trian2(:,i) == 0
                    u_union(:,i) = u_trian1(:,i);
                elseif u_trian1(:,i) == 0 
                    u_union(:,i) = u_trian2(:,i); 
                else
                    u_union(:,i) = 1;
                end
            end   
    end

     tiledlayout(3,1)
     nexttile
     disp("u_A(x) = " + u_trian1(:,cols));
     disp("u_B(x) = " + u_trian2(:,cols));
     disp("u_A(x) U u_B(x) = " + u_union(:,cols));
     plot(ts, u_union);
     title("Union")

     nexttile
     plot(ts,u_trian1)
     title("Grafica A")

     nexttile
     plot(ts, u_trian2)
     title("Grafica B")
end
















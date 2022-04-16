% La variable values devuelve en un array los valores de las funciones de 
%membresía de la forma: 
% rows: index de las funciones de membr. 
% cols: func de membresía. 
clc
clear
format short
finalizado = 'N'; 
%% Input 1 
m1 = 0.001; 
k1 = 1;

m2 = 3; 
k2 = 0.4;

m3 = 6; 
k3 = 3.5; 

m4 = 7.5; 
k4 = 2;

m5 = 10; 
k5 = 0.9; 
 

ts = vector_tiempo(0.001, 0, 10); 
func_memb= struct('exp1', {m1, k1}, 'exp2', {m2, k2}, 'exp3', {m3, k3},...
    'exp4', {m4, k4},'exp5', {m5, k5} ); 


input1 = Inputs( ...
    "nombre","Humedad","rango",ts, ...
    "tipo",["exp", "exp", "exp","exp", "exp"], ...
    "func_memb", func_memb ...
    );

values1 = input1.build_functions(); 

%% Input 2
m4 = 0.001; 
k4 = 0.1; 

m5 = 6; 
k5 = 1.5;

m6 = 10; 
k6 = 0.3; 

ts = vector_tiempo(0.001, 0, 10); 
func_memb = struct('exp4', {m4, k4}, 'exp5', {m5, k5}, 'exp6',{m6, k6}); 

input2 = Inputs( ...
    "nombre", "Probabilidad de lluvia", ...
    "rango",ts, ...
    "tipo",["exp","exp","exp"], ...
    'func_memb',func_memb ...
    ); 

values2 = input2.build_functions() ; 
 
%% Salida: 
%c
m7 = 0.001; 
k7 = 0.5; 
%Mc
m8 = 2.5; 
k8 = 0.6;
%Mitad
m9 = 5; 
k9 = 1; 
%Mab
m10 = 7.5; 
k10 = 0.6; 
%ab
m11 = 10; 
k11 = 1; 

ts = vector_tiempo(0.001, 0, 10); 
func_memb = struct('exp1', {m7, k7}, 'exp2', {m8, k8}, 'exp3',{m9, k9}, ...
    'exp4',{m10, k10}, 'exp5',{m11, k11}); 

input3 = Inputs( ...
    "nombre", "Salida", ...
    "rango",ts, ...
    "tipo",["exp","exp","exp","exp","exp"], ...
    'func_memb',func_memb ...
    ); 

salida = input3.build_functions(); 

% Mostrar variables: 
tiledlayout(3,1)
nexttile
input1.display_fun(values1)
nexttile
input2.display_fun(values2)
nexttile
input3.display_fun(salida)
%% Calculo de las kj 
while (finalizado ~='S')
    inp1 = input("Valor de la humedad: " );
    inp2 = input("Valor de la prob de lluvia: "); 
    
    % Entrega un vector row de 3x1 donde cada row es el valor de pertenencia 
    % a cada func de pertenencia comenzando desde la izq. 
    fuzzified_out1 = input1.fuze_input(inp1);
    fuzzified_out2 = input2.fuze_input(inp2); 
    
    fuzzified_out1 = transpose(fuzzified_out1); 
    fuzzified_out2 = transpose(fuzzified_out2);
    %humedad real -> H, Probabilidad de humedad -> PrH, Humificador -> V
    Reglas_array = [
    "H es MB and PrH es B -> V es ab", m11; 
    "H es MB and PrH es Md -> V es ab", m11;
    "H es MB and PrH es A -> V es ab", m11;

    "H es B and PrH es B -> V es ab", m11; 
    "H es B and PrH es Md -> V es Mab", m10;
    "H es B and PrH es A -> V es Mab", m10;

    "H es Op and PrH es B -> V es Md", m9;
    "H es Op and PrH es Md -> V es Md", m9;
    "H es Op and PrH es A -> V es Mc", m8;

    "H es MA and PrH es B -> V es Mc", m8;
    "H es MA and PrH es Md -> V es Mc", m8;
    "H es MA and PrH es A -> V es Mc", m8; 

    "H es A and PrH es B -> V es C", m7;
    "H es A and PrH es Md -> V es C", m7;
    "H es A and PrH es A -> V es C", m7;
    ];
    Reglas_centroides = [
        m11, m11, m11, m11, m10, m10, m9, m9, m8, m8, m8, m8, ...
        m7, m7, m7
    ]; 
    
    %% 
    [func_memb_rows,func_memb_cols] = size(fuzzified_out1); 
    [func_memb_rows2,func_memb_cols2] = size(fuzzified_out2); 
    [rows_reglas, cols_reglas] = size(Reglas_array); 
    mink = zeros(1, rows_reglas);
    kj_c = zeros(1, rows_reglas);
    
    disp(func_memb_cols)
    disp("Valores de pertenencia: ")
    disp(fuzzified_out1)
    disp(fuzzified_out2)
    
    total_reglas = 0; 
    for i = 1:func_memb_cols
        for j = 1:func_memb_cols2
            total_reglas = total_reglas + 1;
            mink(1,total_reglas) = min(fuzzified_out1(1,i), fuzzified_out2(1,j));
        end
    end
    
    %Sumatoria de todas la k: 
    kj = round(sum(mink), 10); 
    
    
    %Multiplicacion por los centroides: 
%     for i = 1:rows_reglas
%        kj_c(:,i) = mink(:,i) * Reglas_centroides(:,i);  
%     end
    
    kj_c = round(mink .* Reglas_centroides, 10);
 
    saco = sum(kj_c); 
    resultado = saco./kj; 
    
    disp("RESULTADO")
    disp(resultado)
    

finalizado = input("Finalizar S/N", 's'); 
   
end








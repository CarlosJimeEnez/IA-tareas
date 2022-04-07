% La variable values devuelve en un array los valores de las funciones de 
%membresía de la forma: 
% rows: index de las funciones de membr. 
% cols: func de membresía. 
format long
finalizado = 'N'; 
%% Input 1 
m1 = 0; 
k1 = 0.2; 
m2 = 6; 
k2 = 3.5;
m3 = 10; 
k3 = 0.3; 
ts = vector_tiempo(0.001, 0, 10); 
func_memb= struct('exp1', {m1, k1}, 'exp2', {m2, k2}, 'exp3', {m3, k3}); 


input1 = Inputs( ...
    "nombre","Input1","rango",ts, ...
    "tipo",["exp", "exp", "exp"], ...
    "func_memb", func_memb ...
    );

values1 = input1.build_functions(); 

%% Input 2
m4 = 0; 
k4 = 0.1; 
m5 = 6; 
k5 = 1.5;
m6 = 10; 
k6 = 0.3; 
ts = vector_tiempo(0.001, 0, 10); 
func_memb = struct('exp4', {m4, k4}, 'exp5', {m5, k5}, 'exp6',{m6, k6}); 

input2 = Inputs( ...
    "nombre", "Input2", ...
    "rango",ts, ...
    "tipo",["exp","exp","exp"], ...
    'func_memb',func_memb ...
    ); 

values2 = input2.build_functions() ; 
 
%% Salida: 
m7 = 0; 
k7 = 0.5; 
m8 = 5; 
k8 = 1;
m9 = 10; 
k9 = 1; 
ts = vector_tiempo(0.001, 0, 10); 
func_memb = struct('exp1', {m7, k7}, 'exp2', {m8, k8}, 'exp3',{m9, k9}); 

input3 = Inputs( ...
    "nombre", "Salida", ...
    "rango",ts, ...
    "tipo",["exp","exp","exp"], ...
    'func_memb',func_memb ...
    ); 

salida = input3.build_functions(); 

%% Calculo de las kj 
while (finalizado ~= 'S')
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
    "H es B and PrH es B -> V es A", m9; 
    "H es B and PrH es Md -> V es A", m9;
    "H es B and PrH es A -> V es Md", m8;
    "H es Md and PrH es B -> V es Md", m8;
    "H es Md and PrH es Md -> V es Md", m8;
    "H es Md and PrH es A -> V es B", m7;
    "H es A and PrH es B -> V es B", m7;
    "H es A and PrH es Md -> V es B", m7;
    "H es A and PrH es A -> V es B", m7; 
    ];
    Reglas_centroides = [
        m9, m9, m8, m8, m8, m7, m7, m7, m7, 
    ]; 
    
    %% 
    [func_memb_rows,func_memb_cols] = size(fuzzified_out1); 
    [rows_reglas, cols_reglas] = size(Reglas_array); 
    mink = zeros(1, rows_reglas);
    kj_c = zeros(1, rows_reglas);
    
    disp(func_memb_cols)
    disp("Valores de pertenencia: ")
    disp(fuzzified_out1)
    disp(fuzzified_out2)
    
    total_reglas = 0; 
    for i = 1:func_memb_cols
        for j = 1:func_memb_cols
            total_reglas = total_reglas + 1;
            mink(1,total_reglas) = min(fuzzified_out1(1,i), fuzzified_out2(:,j));
        end
    end
    
    disp('min de los valores')
    disp(mink)
    
    %Sumatoria de todas la k: 
    kj = sum(mink); 
    disp("Suma de todas los valores min:")
    disp(kj)
    
    
    %Multiplicacion por los centroides: 
    for i = 1:rows_reglas
       kj_c(:,i) = round(mink(:,i) * Reglas_centroides(:,i), 7);  
    end
    
    saco = 0;
    for i = 1:rows_reglas
        saco = saco + kj_c(:,i); 
    end
    
    resultado = saco/kj; 
    
    disp("RESULTADO")
    disp(resultado)
    
    %% Mostrar variables: 
    tiledlayout(3,1)
    nexttile
    input1.display_fun(values1)
    nexttile
    input2.display_fun(values2)
    nexttile
    input3.display_fun(salida)
    
    finalizado = input("Finalizar S/N", 's'); 
end








% La variable values devuelve en un array los valores de las funciones de 
%membresía de la forma: 
% rows: index de las funciones de membr. 
% cols: func de membresía. 

%% Input 1 
m1 = 0; 
k1 = 1; 
m2 = 5; 
k2 = 1;
m3 = 8; 
k3 = 1; 
ts = vector_tiempo(0.001, 0, 10); 
func_memb= struct('exp1', {m1, k1}, 'exp2', {m2, k2}, 'exp3', {m3, k3}); 

input1 = Inputs( ...
    "nombre","Input1","rango",ts, ...
    "tipo",["exp", "exp", "exp"], ...
    "func_memb", func_memb ...
    );

values = input1.build_functions(); 

%% Input 2
m4 = 0; 
k4 = 0.5; 
m5 = 5; 
k5 = 1;
m6 = 8; 
k6 = 1; 
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
m9 = 8; 
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

%% 
%% Mostrar variables: 
tiledlayout(3,1)
nexttile
input1.display_fun(values)
nexttile
input2.display_fun(values2)
nexttile
input3.display_fun(salida)

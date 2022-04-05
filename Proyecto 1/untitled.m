rango1 = [0:20];
rango2 = [20:30]; 
m1 = 1; 
k1 = 0; 
m2 = 5; 
k2 = 0; 
func_memb= struct('exp1', {m1, rango1, k1}, 'exp2', {m2, rango2, k2}); 

input1 = Inputs( ...
    "nombre","Input1","rango",[0:100], ...
    "tipo",['exp', "exp"], ...
    "func_memb", func_memb ...
    );

input1.mostrar_valores
input1.build_functions()
input1.display_graf()

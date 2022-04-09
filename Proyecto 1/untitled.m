m1 = 1; 
k1 = 1; 
m2 = 5; 
k2 = 1; 
ts = vector_tiempo(0.001, 0, 10); 

func_memb= struct('func1', {m1, k1, ""}, 'func2', { m2, k2, ""}); 

input1 = Inputs(...
    "nombre","Input1","rango",ts, ...
    "tipo",['exp', "exp"], ...
    "func_memb", func_memb ...
    );

input1.mostrar_valores
input1.build_functions()


clc
clear 

finalizado = "n"; 
while finalizado ~= "S" 
    disp("Conjuntos: ")
    disp("Triangular")
    disp("Trapezoidal")
    disp("Gaussiana")
    disp("pseudo-exponencial")
    disp("Gamma1")
    disp("Gamma2")
    
    input("Conjunto: ") %#ok<*NOPTS> 
    finalizado = input("Acabar S/n: ", "s"); 
end
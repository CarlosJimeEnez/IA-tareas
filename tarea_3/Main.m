clc
clear 

finalizado = "n"; 
while finalizado ~= "S" 
    input("Conjunto: ") %#ok<*NOPTS> 
    finalizado = input("Acabar S/n: ", "s"); 
end
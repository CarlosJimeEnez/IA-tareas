classdef Inputs
    
    properties
        nombre
        rango_total
        tipo
        func_membr
        graficas = {0,0,0} 
        
    end

    methods
        %% Constructor
        function obj = Inputs(options)
            arguments
                options.nombre
                options.rango (1,:)         
                options.tipo (1,:)
                options.func_memb 
                options.graficas_const
            end
            obj.nombre = options.nombre;
            obj.rango_total = options.rango; 
            obj.tipo = options.tipo;
            obj.func_membr = options.func_memb;
            
            
        end

        %% Funciones: 
        function outputArg = mostrar_valores(obj)
            disp(obj.nombre)
            disp(obj.tipo)    
            disp(obj.func_membr)
        end

        function output = build_functions(obj)
            key = fieldnames(obj.func_membr); 
            disp(key)
                        
            i = 1; 
            for fun = obj.tipo
                if fun == "exp"
                   rango = getfield(obj.func_membr(2),key{i,1});
                   m = getfield(obj.func_membr(1),key{i,1});
                   k = getfield(obj.func_membr(3),key{i,1});    
                   disp(k)
                   disp(m)
                   %Generacion de graf exp: 
                   for j = 1:rango
                       obj.graficas{i} = 1/(1+k*(rango(:,j) - m)^2);
                   end
                end

                i = i + 1;  
            end
        end

        %Muestra la grafica: 
        function output = display_graf(obj)
            tiledlayout(1,1)
            nexttile
            plot(ts, obj.graficas{1})
            title("Grafica A")
        end

    end
end









classdef Inputs
    
    properties
        nombre
        rango_total
        tipo
        func_membr
        graficas 
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
            %Devuelve las key del dic (obj.func_memb)
            key = fieldnames(obj.func_membr); 
            
            [rows, cols] = size(obj.rango_total); 
            obj.graficas = zeros(length(obj.tipo), cols);
            fun_memb = zeros(rows, cols);
            
            i = 1; 
            for fun = obj.tipo
                
                if fun == "exp"
                   %Generacion de las fun de membr
                   m = getfield(obj.func_membr(1),key{i,1});
                   
                   k = getfield(obj.func_membr(2),key{i,1});
                   for j = 1:cols
                        fun_memb(:,j) = exp(-k*(obj.rango_total(:,j)-m)^2);
                   end
                   %Guardar en un arreglo todas las fun de memb
                   obj.graficas(i,:) = fun_memb;
                   %disp(size(obj.graficas))
                end

                i = i + 1;  
            end
            output = obj.graficas; 
        end
       
        %Muestra las graficas: 
        function out = display_fun(obj, value)
            [rows, cols] = size(value); 
            title(obj.nombre)
            hold on
            for i = 1:rows
                plot(obj.rango_total, value(i,:))
            end
            hold off
        end
        
        %Fuzifica la entrada: 
        function out = fuze_input(obj,val)
            key = fieldnames(obj.func_membr); 
            rango = vector_tiempo(0.001, 0, val); 
            [rows, cols] = size(rango); 
            fuzzy_values = zeros(length(obj.tipo), cols);
            fun_memb = zeros(rows, cols);
        
            i = 1; 
            for fun = obj.tipo           
                if fun == "exp"
                   %Generacion de las fun de membr
                   m = getfield(obj.func_membr(1),key{i,1});                   
                   k = getfield(obj.func_membr(2),key{i,1});

                   for j = 1:cols
                        fun_memb(:,j) = exp(-k*(rango(:,j)-m)^2);
                   end
                   %Guardar en un arreglo todas las fun de memb
                   fuzzy_values(i,:) = fun_memb;
                   %disp(size(obj.graficas))
                end
                i = i + 1;  
            end

            [rows, cols] = size(fuzzy_values);
            out = zeros(rows, 1); 
            for i = 1:rows
                out(i,:) = fuzzy_values(i, cols);
            end
        end

        %% Get and set:
        function output = set_graficas_memb_values(obj, value)
            obj.graficas = value; 
            output = obj.graficas; 
        end
    end
end









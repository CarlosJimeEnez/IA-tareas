function [u] = generate_trian(rows, cols, a, b, m, ts)    
   
    u = zeros(rows, cols);
    for i = 1:cols
        if ts(:,i) < a
            u(:,i) = 0 ;
        elseif (a <= ts(:,i)) && (ts(:,i) < m )
            u(:, i) = (ts(:,i)-a)/(m-a); 
        elseif (m <= ts(:,i)) && (ts(:,i) < b)
            u(:,i) = (b-ts(:,i))/(b-m); 
        else 
            u(:,i) = 0; 
        end
    end
    
end
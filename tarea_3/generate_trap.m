function [u] = generate_trap(rows, cols,a,b,c,d,ts)

u = zeros(rows, cols);
    for i = 1:cols
        if ts(:,i) < a
            u(:,i) = 0 ;
        elseif (a <= ts(:,i)) && (ts(:,i) < b )
            u(:, i) = (ts(:,i)-a)/(b-a); 
        elseif (b <= ts(:,i)) && (ts(:,i) < c)
            u(:,i) = 1;
        elseif (c <= ts(:,i)) && (ts(:,i) < d)
            u(:,i) = (d-ts(:,i))/(d-c); 
        else 
            u(:,i) = 0; 
        end
    end

end
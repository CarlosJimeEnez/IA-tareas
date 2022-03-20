function [ts] = vector_tiempo(h, ti, tf)

ti = ti;
t_final = tf; 
h = h; 
ts = ti:h:t_final;

end
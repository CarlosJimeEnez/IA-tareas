## Caso 1: 
2 variables de entrada : x1 y x2   
2 variables de salida: y1 y y2  
Sin hecho

## Como regla general para este caso tenemos que
Regla j : Si $X_1$ ess $A_j$ y $X_2$ ess $B_j$ entonces $Y_1$ ess $D_j$ y $Y_2$ ess $E_j$

- Primero calculamos el antecedente para la regla j: 
$$ k_j = min(A_j(x_1), B_j(x_2))$$
El min que representa la conjuncion difusa estandar. 

- tenemos $k_j$ donde j = 1,...,m cantidad de reglas. 

Donde: c_1j los centros de los intervalos donde se definen $D_j$.

Donde: c_2j los centros de los intervalos donde se definen $E_j$

- Defusificacion: 
$$y_1 = \frac{\sum k_j c_1j}{\sum k_j} $$
$$y_2 = \frac{\sum k_j c_2j}{\sum k_j} $$

## Caso 2 
1 variable de entrada $x \epsilon[0,60]$  
1 var de salida y  
Consideramos el hecho (A")  
Referencia $k$ (k = 27)

- Creamos 1 variable de entrada: $x" = k - x$ calculamos el intervalo para $x"$: 
$$x" = 27 - 0 = 27$$
$$x" = 27 - 60 = 27$$
Con esto obtenemos el intervalo [-33, 27] el cual representa un conjunto de error posible. 

- Primer conjunto x: [0  60]
- Segundo conjunto $x"$ [-33 27]
- Conjunto de referencia A" [0 27]

## Reglas: 
Las Reglas se obtienen de la forma: 
Regla j: Si $X$ es $A_j$ y $X"$ es Neg entonces $Y$ es $Bj$
$Kj = min(A_j(x), Neg(x"))$
- Calculamos el grado de consistencia: 
$$r_j = min(k_j, A"(x)) = \alpha _j$$ 

- Defusificacion: 
$$y = \frac{\sum \alpha _j c_j}{\sum \alpha _j }$$

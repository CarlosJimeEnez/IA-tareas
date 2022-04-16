import numpy as np
import matplotlib.pyplot as plt
from Fis_mamdami import Fis

rango = np.arange(start=0, stop=10, step=0.001)
func_memb = [
    {'nombre': 'Baja', 'tipo': 'exp', 'm': 0.001, 'k': 1},
    {'nombre': 'Media', 'tipo': 'exp', 'm': 3, 'k': 0.4}, 
    {'nombre': 'Optima', 'tipo': 'exp', 'm': 6, 'k': 3.5},
    {'nombre': 'MediaAlta', 'tipo': 'exp', 'm': 7.5, 'k': 2},
    {'nombre': 'Alta', 'tipo': 'exp', 'm': 10, 'k': 0.9},
]
object = Fis(name = "Input 1", rango = rango, func_membr = func_memb)
humedad_functions = object.build_function()


# --- Input 2
funciones_memb2 = [
    {'nombre': 'Baja', 'tipo': 'exp', 'm': 0.001, 'k': 0.1}, 
    {'nombre': 'Media', 'tipo': 'exp', 'm': 6, 'k': 1.5},
    {'nombre': 'Alta', 'tipo': 'exp', 'm': 10, 'k': 0.3}, 
]
probabilidad_lluvia = Fis(name = 'Prob_lluvia', rango=rango, func_membr = funciones_memb2)
prob_lluvia_functions = probabilidad_lluvia.build_function()


# -- Salida: 
output_funciones_membr = [ 
    {'nombre': 'Cerrada', 'tipo': 'exp', 'm': 0.001, 'k': 0.5}, 
    {'nombre': 'MediaCerrada', 'tipo': 'exp', 'm': 2.5, 'k': 0.6},
    {'nombre': 'Media', 'tipo': 'exp', 'm': 5, 'k': 1},
    {'nombre': 'MediaAbierta', 'tipo': 'exp', 'm': 7.5, 'k': 0.6}, 
    {'nombre': 'Abierta', 'tipo': 'exp', 'm': 10, 'k': 1},
]
Apertura_valvula = Fis(name='Apertura_valvula', rango=rango, func_membr = output_funciones_membr)
apertura_valvula_func = Apertura_valvula.build_function()


# -- Inputs: 
humedad = float(input("Valor de la humedad: "))
prob_lluvia = float(input("Valor de la Probabilidad lluvia: "))
#Calculos de los valores de pertenencia: 
humedad_belonging_value = object.belonging_value(humedad)
prob_lluvia_belonging_value = probabilidad_lluvia.belonging_value(prob_lluvia)
print(f'Valores de pertenencia HUMEDAD: {humedad_belonging_value}')
print(f'Valores de pertenencia PROB_LLUVIA: {prob_lluvia_belonging_value}')

# -- REGLAS DE INFERENCIA: 
Reglas_array = [
    "(H es MuyBaja) and ProbLL es Baja -> Val es Abierta", 
    "H es MuyBaja and ProbLL es MediaBaja -> Val es Abierta", 
    "H es MuyBaja and ProbLL es Alta -> Val es Abierta", 

    "H es Baja and ProbLL es Baja -> Val es Abierta",
    "H es Baja and ProbLL es MediaBja -> Val es MedAbierta",
    "H es Baja and ProbLL es Alta -> Val es MedAbierta",
    
    "H es Optima and ProbLL es Baja -> Val es Media", 
    "H es Optima and ProbLL es MedBaja -> Val es Media", 
    "H es Optima and ProbLL es Alta -> Val es MedCerrada",
    
    "H es MedAlta and ProbLL es Baja -> Val es MedCerrada", 
    "H es MedAlta and ProbLL es MedBaja -> Val es MedCerrada", 
    "H es MedAlta and ProbLL es Alta -> Val es MedCerrada",
    
    "H es Alta and ProbLL es Bja -> Val es Cerrada",
    "H es Alta and ProbLL es MedBja -> Val es Cerrada",
    "H es Alta and ProbLL es Alta -> Val es Cerrada",          
]
c1 = [10, 10, 10,  10, 7.5, 7.5,  5, 5, 2.5,  2.5, 2.5, 2.5,  0.001, 0.001, 0.001]
#Calculos de las KJ:
kj = [] 
for x1 in humedad_belonging_value: 
    for x2 in prob_lluvia_belonging_value: 
        kj.append(np.minimum(x1, x2)) 
print(f'Tamano de kj: {len(kj)}')

#Mult de los centroides con las kj:
mult_kj = [] 
for i, j in zip(kj, c1): 
    mult_kj.append(i * j)
print(f'Tamano de mult_kj: {len(mult_kj)}')

#Sumatoria de la multiplicacion de las kj y cj: 
numerador = sum(mult_kj)
#Sumatoriad de las kj: 
sum_kj = sum(kj)

Resultado = numerador/sum_kj
print(f'Resultado: {Resultado}')


# -- Display graph 1: 
figure, axis = plt.subplots(2, 2)
for funciones_memb in func_memb:
    #Grafica una funcion de entrada con todas sus graficas de pertenencia:   
    axis[0, 0].plot(rango, humedad_functions[funciones_memb['nombre']], label=funciones_memb['nombre'])
axis[0, 0].set_title('Input 1')

# -- Display graph 2: 
for funciones_memb in funciones_memb2:
    #Grafica una funcion de entrada con todas sus graficas de pertenencia:   
    axis[1, 0].plot(rango, prob_lluvia_functions[funciones_memb['nombre']], label=funciones_memb['nombre'])
axis[1, 0].set_title('Input 2')

# -- Display Output: 
for funciones_memb in output_funciones_membr:
    #Grafica una funcion de entrada con todas sus graficas de pertenencia:   
    axis[0, 1].plot(rango, apertura_valvula_func[funciones_memb['nombre']], label=funciones_memb['nombre'])
axis[0, 1].set_title('Output')



plt.show()
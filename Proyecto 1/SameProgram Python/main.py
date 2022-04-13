from cProfile import label
from turtle import color
from unicodedata import name
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
    {'nombre': 'Baja', 'tipo': 'exp', 'm': 0.001, 'k': 0.5}, 
    {'nombre': 'MediaBaja', 'tipo': 'exp', 'm': 2.5, 'k': 0.6},
    {'nombre': 'Media', 'tipo': 'exp', 'm': 5, 'k': 1},
    {'nombre': 'MediaAlta', 'tipo': 'exp', 'm': 7.5, 'k': 0.6}, 
    {'nombre': 'Alta', 'tipo': 'exp', 'm': 10, 'k': 1},
]
Apertura_valvula = Fis(name='Apertura_valvula', rango=rango, func_membr = output_funciones_membr)
apertura_valvula_func = Apertura_valvula.build_function()

# -- Inputs: 
humedad = float(input("Valor de la humedad"))
prob_lluvia = float(input("Valor de la humedad"))

# -- Calculos de los valores de pertenencia: 
object.belonging_value(humedad)

# -- Display graph: 
for funciones_memb in func_memb:  
    plt.plot(rango, humedad_functions[funciones_memb['nombre']], label=funciones_memb['nombre'])

plt.xlabel('Rango')
plt.ylabel('Pertenencia')
plt.title('humedad_functions')
plt.legend()

plt.plot(rango, apertura_valvula_func['Baja'])
plt.show()
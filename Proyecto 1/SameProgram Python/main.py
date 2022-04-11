from cProfile import label
from turtle import color
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
input1 = object.build_function()
print(input1)
#Display graph: 

plt.plot(rango, input1['Baja'], label='baja', color='g')
plt.plot(rango, input1['Media'], label='baja', color='g')
plt.plot(rango, input1['Optima'], label='baja', color='g')
plt.plot(rango, input1['MediaAlta'], label='baja', color='g')
plt.plot(rango, input1['Alta'], label='baja', color='g')

#plt.plot(rango, input1['Media'], label="Media")
plt.xlabel('Rango')
plt.ylabel('Pertenencia')
plt.title('Input1')
plt.legend()
plt.show()
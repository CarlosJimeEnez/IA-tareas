from tracemalloc import start
import numpy as np
class Fis: 
    def __init__(self, **kw):
        self.name = kw['name']
        self.rango = kw['rango']
        self.func_memb = kw['func_membr']
        self.func_value = np.zeros(np.size(self.rango))
        self.func_dicc_values = {}
                    
    def build_function(self):
        '''Retorna un diccionario con los valores de cada grafica en distintas keys''' 
        for funcion in self.func_memb: 
            print(f"funcion{funcion}")

            #Gaussiana:
            if (funcion['tipo'] == 'exp'): 
                k = funcion['k']
                m = funcion['m']
                rango = self.rango
                value = self.func_value
                for i in np.arange(start=0, stop=np.size(self.rango)):
                    value[i] = np.exp(-funcion['k']*(rango[i]-funcion['m'])**2)

                value = np.copy(value)
                new_value = {funcion['nombre']:value}
                self.func_dicc_values.update(new_value)
        return self.func_dicc_values
        
                
                
                    
        

                



            



        
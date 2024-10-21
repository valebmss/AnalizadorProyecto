import numpy as np

def dentro_del_cono(jugador_pos, jugador_direccion, oponente_pos):
    # Calcula el ángulo entre la dirección del jugador y la posición del oponente
    dx = oponente_pos[0] - jugador_pos[0]
    dy = oponente_pos[1] - jugador_pos[1]
    angulo = np.arctan2(dy, dx)
    
    # Convierte el ángulo a grados y ajusta a un rango de 0 a 360
    angulo_grados = np.degrees(angulo) % 360
    
    # Calcula los ángulos límite del cono de visión
    angulo_limite_izq = (jugador_direccion - 45) % 360
    angulo_limite_der = (jugador_direccion + 45) % 360
    
    # Verifica si el ángulo del oponente está dentro del cono de visión
    if angulo_limite_izq < angulo_limite_der:
        return angulo_limite_izq <= angulo_grados <= angulo_limite_der
    else:
        return angulo_grados >= angulo_limite_izq or angulo_grados <= angulo_limite_der

def disparar(mapa, jugador_pos, jugador_direccion, oponente_pos):
    if np.array_equal(jugador_pos, oponente_pos):
        return True # Si el oponente está en la misma posición del jugador, impacto seguro
    
    if dentro_del_cono(jugador_pos, jugador_direccion, oponente_pos):
        # Si el oponente está dentro del cono de visión
        # Impacto con 50% de probabilidad
        return np.random.choice([True, False], p=[0.5, 0.5])
    
    return "Fuera de rango" # El oponente está fuera del cono de visión

# Función para imprimir el mapa con la posición del jugador, los oponentes y su dirección
def imprimir_mapa(mapa, jugador_pos, oponentes_pos, jugador_direccion):
    mapa_con_jugador = np.copy(mapa)
    mapa_con_jugador[tuple(jugador_pos)] = 1 # Coloca al jugador en el mapa
    for oponente_pos in oponentes_pos:
        mapa_con_jugador[tuple(oponente_pos)] = 2 # Coloca a los oponentes en el mapa
    print("Mapa:")
    print(mapa_con_jugador)
    print("Dirección del jugador:", jugador_direccion)

# Ejemplo de uso
mapa = np.zeros((10, 10)) # Crear un mapa de 10x10 lleno de 0s
jugador_pos = np.array([5, 5]) # Posición del jugador
jugador_direccion = 0 # Dirección del jugador (en grados) apuntando hacia la derecha
oponentes_pos = [np.array([7, 7]), np.array([3, 4])] # Posiciones de los oponentes

imprimir_mapa(mapa, jugador_pos, oponentes_pos, jugador_direccion) # Imprime el mapa con el jugador y los oponentes
impacto = disparar(mapa, jugador_pos, jugador_direccion, oponentes_pos[0])
if impacto == True:
    print("¡Impacto!")
elif impacto == False:
    print("¡Fallaste!")
else:
    print("¡Fallaste! (Fuera de rango)")

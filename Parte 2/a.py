import numpy as np

# Clase para manejar el estado del juego
class Juego:
    def __init__(self):
        self.turno = 0
        self.jugadores = {}
        self.acciones = {
            "FORWARD": self.mover,
            "RIGHT": self.mover,
            "LEFT": self.mover,
            "REVERSE": self.mover,
            "RUN": self.atacar,
            "DODGE": self.dodging,
            "ROLL_LEFT": self.dodging,
            "ROLL_RIGHT": self.dodging,
            "WEAK_SLASH": self.atacar,
            "MEDIUM_SLASH": self.atacar,
            "STRONG_SLASH": self.atacar,
            "WEAK_KICK": self.atacar,
            "MEDIUM_KICK": self.atacar,
            "STRONG_KICK": self.atacar,
            "CANCEL_DODGE": self.cancelar_dodge
        }

    def agregar_jugador(self, nombre, posicion):
        self.jugadores[nombre] = {"posicion": posicion, "direccion": 0}  # Dirección inicial en 0

    def mover(self, jugador, direccion):
        if direccion == "FORWARD":
            self.jugadores[jugador]["posicion"][1] += 1
        elif direccion == "RIGHT":
            self.jugadores[jugador]["posicion"][0] += 1
        elif direccion == "LEFT":
            self.jugadores[jugador]["posicion"][0] -= 1
        elif direccion == "REVERSE":
            self.jugadores[jugador]["posicion"][1] -= 1

    def atacar(self, jugador, tipo_ataque):
        print(f"{jugador} ataca con {tipo_ataque}")

    def dodging(self, jugador):
        print(f"{jugador} esquiva!")

    def cancelar_dodge(self, jugador):
        print(f"{jugador} cancela el dodge.")

    def ejecutar_turno(self, acciones_turno):
        print(f"\n--- Turno {self.turno} ---")
        for jugador, accion in acciones_turno:
            if jugador in self.jugadores:
                if accion in self.acciones:
                    self.acciones[accion](jugador, accion)
                else:
                    print(f"Acción no reconocida: {accion}")
            else:
                print(f"Jugador no reconocido: {jugador}")
        self.turno += 1

    def cargar_acciones(self, archivo):
        with open(archivo, 'r') as f:
            for linea in f:
                linea = linea.strip()

                # Ignorar líneas que no contengan acciones
                if linea.startswith("Turno:") or linea == "Fin del juego.":
                    continue

                try:
                    nombre, accion = linea.split()
                    self.ejecutar_turno([(nombre, accion)])
                except ValueError:
                    print(f"Formato inválido en la línea: {linea}")

# Ejemplo de uso
juego = Juego()

# Cargar acciones desde el archivo
juego.cargar_acciones('entrada.txt')

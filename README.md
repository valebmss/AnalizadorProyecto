---

# Taller Flex - Twisted Metal

Este repositorio contiene la solución al taller de Flex, junto con el proyecto del scaner del juego Twisted Metal. Twisted Metal es un derby de demolición que permite el uso de proyectiles baláısticos, ametralladoras, minas y otros tipos de armas (hasta un arma satelital y armas nucleares). En su modo de torneo se pueden tener batallas multijugador en diferentes escenarios, en los cuales se encuentras gran variedad de pick ups de armas y mejoras. El objetivo del juego es ser el último automóvil en pie.


## Detalles del taller

### Parte 1

#### Ejemplo 1
Escáner que reemplaza todos los números en un flujo de texto con un signo de interrogación. Podría ser útil, por ejemplo, si fueras un contador particularmente poco escrupuloso.
1. **Comandos para compilar y correr programa**:
    ```bash
    flex digitos.l
    gcc lex.yy.c -o digitos -lfl
    ./digitos 
#### Ejemplo 2
Este ejemplo ilustra un programa que cuenta las palabras, caracteres y líneas de un archivo seleccionado durante la ejecución del archivo compilado. 
1. **Comandos para compilar y correr programa**:
    ```bash
    flex contador.l
    cc lex.yy.c -lfl -o contador
    ./contador < entrada.txt 
### Parte 2
####  Descripción
Analizador sintáctico para un combate de la arena de Twisted Metal. Un combate de la arena debe iniciar
seleccionando el escenario, luego seleccionando 4 jugadores, entonces inicia el combate. En esta aproximación cada jugador hace un movimiento en su turno, además de que un ataque se hace a un solo oponente y será exitoso o no con base en la poscisión del objetivo.
1. **Comandos para compilar y correr programa**:
    ```bash
	flex analizer.l
   	bison -d analizer.y
	gcc lex.yy.c analizer.tab.c -o analizer -lfl -lm
    	./analizer entrada.txt
2. **Selección de Mapa y Personajes**:
	En el documento de juego, los jugadores deben seleccionar un mapa y cuatro personajes para el combate. Esto se realiza mediante comandos específicos en el documento.

- Para seleccionar un mapa, se utiliza el comando `select map <nombre del mapa>`.
- Para seleccionar un personaje, se utiliza el comando `select player <nombre del personaje>`.

	Es importante seguir estas instrucciones correctamente, ya que no realizar la selección de mapa o de alguno de los cuatro jugadores resultará en un error y el no reconocimiento del documento de juego.

	##### Lista de Mapas 

	| Mapas       |
	|-------------|
	| Moscow      |
	| Paris       |
	| Amazonía    |
	| New York    |
	| Antarctica  |
	| Holland     |
	| Hong Kong   |
	
	##### Lista de Personajes 
	| Personajes | Descripción|  Vida    |
	|------------|------------|----------|
	| Axel       | Es un hombre aprisionado en 2 ruedas gigantes por culpa de su padre. Se une al torneo para conseguir el valor de hacerle frente a su padre.| 10 |
	| Grasshopper| Krysta Sparks es la piloto de este buggy. Afirma ser la hija de Calypso y su deseo es asesinarlo.                                                   |   10     |
	| Mr. Grimm  | La parca pilotea esta motocicleta con sidecar. Se une al torneo porque desea facilitar su consumo de almas.                                         |    10    |
	| Hammerhead | Los pilotos de esta Monster Truck son Mike y Stu, dos cabezahuecas que ingresan al torneo para desear poder volar.                                  |   10     |
	| Minion     | El demonio Minion conduce este vehículo APC guerrillero. Solo se une al torneo por el deseo de vengarse de Calypso por haberle robado sus poderes.  |  10      |
	| Outlaw 2   | Jamie Roberts maneja este coche de policía. Es la hermana del Outlaw de la primera entrega y busca a su hermano perdido.                            |     10   |
	| Roadkill   | Piloteado por Marcus Kane, un vagabundo que cree que todo el universo de Twisted Metal es algo imaginario.                                          | 10     |
	| Shadow     | Su piloto es Mortimer y conduce un coche fúnebre. Es el guardián de las almas perdidas que fueron asesinadas.                                       |   10  |
	| Mr. Slam   | Un tractor de pala conducido por Simon Whittlebone, un arquitecto frustrado que desea construir el rascacielos más grande del mundo.                     | 10   |
	| Spectre    | Un Corvette blanco conducido por Ken Masters, un actor cuyo único deseo es la fama absoluta.                                                              |10  |
	| Sweettooth | El camión de helados de la anterior entrega vuelve conducido por Kane Needles, un payaso homicida.                                                        | 10  |
	| Thumper    | Una limusina rosa manejada por Bruce Cochrane, un gangster que desea ser el emperador del mundo.                                                         |10   |
	| Twister    | Este F1 es conducido por Amanda Watts, una piloto de carreras cuyo deseo es viajar a la velocidad de la luz.                                             |10      |
	| Warthog    | El capitán Rogers maneja este blindado de guerra. Se une al torneo para desear ser joven otra vez.                                                 | 10                                                             |
	| Darktooth  | Esta extraña mezcla de Sweettooth con Darkside es el jefe final del juego. No es seleccionable.                                                     |50            |

3. **Acciones y movimientos**:
	##### Controles basicos (movimiento) 
	| Acción                | Comando           |
	|-----------------------|-------------------|
	| Acelerar              | ⇑                 |
	| Cambiar dirección a la derecha | ⇒ |
	| Retroceder            | ⇓                 |
	| Cambiar dirección a la izquierda | ⇐ |
	| Turbo                 | Y                 |
	| Frenar                | B                 |
	| Acelerar              | X                 |
	| Cambiar arma secundaria 1 | L1 |
	| Disparar arma seleccionada | L2          |
	| Cambiar arma secundaria 2 | R1 |
	| Ametralladora         | R2                 |
	##### Ataques de un especiales 
	| Ataque Especial                                 | Comando                        | Daño  |
	|-------------------------------------------------|--------------------------------|-------|
	| Fireball and freeze attack                      | L1, L2, R1, R2, ⇒, ⇐, ⇑       |    10   |
	| Be Invisible                                    | ⇐, ⇐, ⇓, ⇓                    |    0   |
	| Freeze Attack                                   | ⇒, ⇐, ⇑                       |    5   
	| Saltar                                          | ⇑, ⇐, ⇐                       |    0   |
4. **Anatomia de un turno**:
En su turno, cada personaje puede relizar las siguientes acciones:
	Puede desplazarse y disparar la ametralladora, desplazarse y disparar arma seleccionada, o realizar un ataque avanzado. Ademas se supondra que un ataque se hace a un solo oponente y sera exitoso con probabilidad de 1 si se encuentra en linea recta hacia donde mira el jugador, con probabilidad de 0.5 si esta en el cono de vicion del personaje el cual es cun cono delimitado por las diagonales desde su pocicion hasta los bordes de la matriz en la direccion que mira el personaje, es decir la mitad de las veces el ataque de un jugador impactara en otro en ese rango.
	Para que el turno se desarrolle de manera adecuada siempre debe poner los personajes en el mismo orden. 
	La estructura que se debe seguir es:
	-`Turno:`
	-`<nombre del personaje> acciones`
	-`<nombre del personaje> acciones`
	-`<nombre del personaje> acciones`
	-`Temina.`


---


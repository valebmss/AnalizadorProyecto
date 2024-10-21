%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include <string.h> 
#define MAP_SIZE 10
extern FILE *yyin; 
int yylex(void);
int yyerror(char* s);
extern char *yytext; 
char player_name[4][20];
char repeat_player_name[4][20];
int num_players = 0;
int repeat_num_players = 0;
char map_name[20];
int oponente_x = 0;
int oponente_y = 0;
int oponente_index = 0;
int map_selected = 0;
char player_name_check[20];
int map[MAP_SIZE][MAP_SIZE]= {0};
int vidas[4]= {10,10,10,10};
int direccion[4]= {0,90,180,270};
int damage = 0;
typedef struct {
    int x;
    int y;
} Posicion;
Posicion **posiciones;
int num_player_playing = 0;
void check_player_name(char *player_name_check) {
    if(strcmp(player_name_check, player_name[0]) == 0 || 
       strcmp(player_name_check, player_name[1]) == 0 || 
       strcmp(player_name_check, player_name[2]) == 0 || 
       strcmp(player_name_check, player_name[3]) == 0) {
        if((strcmp(player_name_check, repeat_player_name[0]) == 0 || 
            strcmp(player_name_check, repeat_player_name[1]) == 0 || 
            strcmp(player_name_check, repeat_player_name[2]) == 0 || 
            strcmp(player_name_check, repeat_player_name[3]) == 0)) {
            printf("Personaje repetido\n ");
            exit(1); 
        } else {
            strncpy(repeat_player_name[repeat_num_players++], player_name_check, sizeof(repeat_player_name[0]) - 1);
        }
    } else {
        printf("Personaje no seleccionado\n ");
        exit(1);
    }
}
void move_forward(int player_index) {
    int nueva_posicion[2] = {posiciones[player_index]->x, posiciones[player_index]->y}; // Nueva posición del jugador

    // Update the position based on the direction
    if (direccion[player_index] == 0) {
        nueva_posicion[0] -= 1;
    } else if (direccion[player_index] == 90) {
        nueva_posicion[1] += 1;
    } else if (direccion[player_index] == 180) {
        nueva_posicion[0] += 1;
    } else if (direccion[player_index] == 270) {
        nueva_posicion[1] -= 1;
    }

    // Check if the new position is within the map bounds
    if (nueva_posicion[0] >= 0 && nueva_posicion[0] < MAP_SIZE &&
        nueva_posicion[1] >= 0 && nueva_posicion[1] < MAP_SIZE) {
        posiciones[player_index]->x = nueva_posicion[0];
        posiciones[player_index]->y = nueva_posicion[1];
        printf("Personaje %d: x = %d, y = %d\n", player_index, posiciones[player_index]->x, posiciones[player_index]->y);
    } else {
        printf("¡Movimiento inválido! El jugador se encuentra en el borde del mapa.\n");
        exit(1);
    }
}
void move_backward(int player_index) {
    int nueva_posicion[2] = {posiciones[player_index]->x, posiciones[player_index]->y}; // Nueva posición del jugador

    // Update the position based on the direction
    if (direccion[player_index] == 0) {
        nueva_posicion[0] += 1;
    } else if (direccion[player_index] == 90) {
        nueva_posicion[1] -= 1;
    } else if (direccion[player_index] == 180) {
        nueva_posicion[0] -= 1;
    } else if (direccion[player_index] == 270) {
        nueva_posicion[1] += 1;
    }

    // Check if the new position is within the map bounds
    if (nueva_posicion[0] >= 0 && nueva_posicion[0] < MAP_SIZE &&
        nueva_posicion[1] >= 0 && nueva_posicion[1] < MAP_SIZE) {
        posiciones[player_index]->x = nueva_posicion[0];
        posiciones[player_index]->y = nueva_posicion[1];
        printf("Personaje %d: x = %d, y = %d\n", player_index, posiciones[player_index]->x, posiciones[player_index]->y);
    } else {
        printf("¡Movimiento inválido! El jugador se encuentra en el borde del mapa.\n");
        exit(1);
    }
}
void cambiar_direccion(int* jugador_direccion, int nueva_direccion) {
    if (nueva_direccion == 90) {
        *jugador_direccion = (*jugador_direccion + 90) % 360;
    } else if (nueva_direccion == 270) {
        *jugador_direccion = (*jugador_direccion - 90 + 360) % 360;
    } else if (nueva_direccion == 0) {
        *jugador_direccion = 0; // Apuntar hacia arriba
    } else if (nueva_direccion == 180) {
        *jugador_direccion = 180; // Apuntar hacia abajo
    }
}
double calcular_angulo(int jugador_x, int jugador_y, int oponente_x, int oponente_y) {
    double dx = oponente_x - jugador_x;
    double dy = oponente_y - jugador_y;
    return atan2(dy, dx);
}
bool dentro_del_cono(int jugador_x, int jugador_y, int jugador_direccion, int oponente_x, int oponente_y ) {
    double angulo = calcular_angulo(jugador_x, jugador_y, oponente_x, oponente_y) * 180 / M_PI;
    double angulo_grados = fmod(angulo, 360);

    int angulo_limite_izq = (jugador_direccion - 45 + 360) % 360;
    int angulo_limite_der = (jugador_direccion + 45) % 360;

    if (angulo_limite_izq < angulo_limite_der) {
        return (angulo_limite_izq <= angulo_grados && angulo_grados <= angulo_limite_der);
    } else {
        return (angulo_grados >= angulo_limite_izq || angulo_grados <= angulo_limite_der);
    }
}

char* disparar(int mapa[MAP_SIZE][MAP_SIZE], int jugador_x, int jugador_y, int jugador_direccion, int oponente_x, int oponente_y, int* vida_oponente, int damage) {
    // Check if the opponent is at the same position as the player
    if (jugador_x == oponente_x && jugador_y == oponente_y) {
        printf("Impacto seguro"); // If the opponent is in the same position as the player
    }

    // Check if the opponent is within the player's cone of vision
    if (dentro_del_cono(jugador_x, jugador_y, jugador_direccion, oponente_x, oponente_y)) {
        // If the opponent is within the cone of vision, calculate whether the shot hits
        // Impact with 50% probability
        if (rand() % 2 == 0) {
            // Apply damage to the opponent's health
            *vida_oponente -= damage; // Adjust the damage value as needed
            printf("Impacto");
        } else {
            printf( "Fallaste"); // Shot missed
        }
    }

    printf( "Fuera de vision"); // The opponent is out of the player's cone of vision
}

%}
%union {
    char *str;
}
%token SELECT
%token MAP
%token MAPNAME
%token PLAYER
%token <str>PNAME
%token <str>NPNAME
%token FINISH_TURN
%token FINISH_GAME
%token TURN
%token FORWARD
%token RIGHT
%token REVERSE
%token LEFT
%token TURBO
%token BRAKE
%token ACCELERATE
%token SECONDARY_WEAPON_1
%token FIRE_SELECTED_WEAPON
%token SECONDARY_WEAPON_2
%token MACHINE_GUN
%token FIREBALL_FREEZE_ATTACK
%token BE_INVISIBLE
%token CHARGED_UP_MINE
%token FREEZE
%token FREEZE_ATTACK
%token ENERGY_SHIELD
%token MINE
%token FIRE_REAR_WEAPONS
%token JUMP
%%

start : selections turn_structures FINISH_GAME
      ;


selections : selection
           | selections selection
           ;

selection : SELECT MAP MAPNAME { 
                if (map_selected) {
                    printf("Error: Solo se puede seleccionar un mapa.\n");
                    exit(1);
                }
                printf("Mapa seleccionado: %s\n", yytext); 
                strncpy(map_name, yytext, sizeof(map_name) - 1);
                map_selected = 1; 
            }
          | SELECT PLAYER PNAME { 
                printf("Personaje seleccionado\n"); 
                if (num_players < 4) {
                    strncpy(player_name[num_players++], yytext, sizeof(player_name[0]) - 1);
                } else {
                    printf("Limite de jugadores alcanzado. No se pueden agregar más jugadores.\n");
                    exit(1); 
                }
              }
          ;
turn_structures : turn_structure 
                | turn_structure turn_structures
                ;

turn_structure : TURN turn turn turn turn FINISH_TURN {repeat_num_players = 0;
    num_player_playing = 0;
    for (int i = 0; i < 4; i++) {
        memset(repeat_player_name[i], 0, sizeof(repeat_player_name[i])); // Fill each element with null bytes
    };
    }
    ;

turn: PNAME special_attack { check_player_name($1); printf("Vida: %d\n", vidas[num_player_playing]);num_player_playing++;} 
    | PNAME movements shoot { check_player_name($1);printf("Vida: %d\n", vidas[num_player_playing]);num_player_playing++;} 
    | PNAME movements secundary_attacks{ check_player_name($1);printf("Vida: %d\n", vidas[num_player_playing]);num_player_playing++;} 

movements : movement
          | movements movement
          ;

movement : FORWARD {move_forward(num_player_playing); }
         | REVERSE {move_backward(num_player_playing); }
         | RIGHT {cambiar_direccion(&direccion[num_player_playing], 90);}
         | LEFT {cambiar_direccion(&direccion[num_player_playing], 270);}
         | TURBO {move_forward(num_player_playing);}
         | BRAKE { printf("Frenar "); }
         | ACCELERATE { move_forward(num_player_playing); }

shoot: MACHINE_GUN {damage = 2;disparar(map, posiciones[num_player_playing]->x, posiciones[num_player_playing]->y, direccion[num_player_playing], oponente_x, oponente_y, &vidas[oponente_index], damage );
 }
     ;

secundary_attacks : FIRE_SELECTED_WEAPON { printf("Disparo secundario\n"); }
                  | select_secundary_attack secundary_attacks 
                  ; 

select_secundary_attack: SECONDARY_WEAPON_1 { printf("Cambio arma izq\n"); }
     | SECONDARY_WEAPON_2 { printf("Cambio arma der\n"); }
     ;

special_attack: FIREBALL_FREEZE_ATTACK { printf("Disparar bola de fuego congelante\n"); }
     | BE_INVISIBLE { printf("Volverse invisible\n"); }
     | FREEZE_ATTACK { printf("Ataque congelante\n"); }
     | JUMP { printf("Saltar\n"); }
     ;

%%

int main(int argc, char **argv) {
    posiciones = (Posicion **)malloc(4 * sizeof(Posicion *));
    posiciones[0] = (Posicion *)malloc(sizeof(Posicion));
    posiciones[1] = (Posicion *)malloc(sizeof(Posicion));
    posiciones[2] = (Posicion *)malloc(sizeof(Posicion));
    posiciones[3] = (Posicion *)malloc(sizeof(Posicion));

    posiciones[0]->x = 5;
    posiciones[0]->y = 2;
    posiciones[1]->x = 5;
    posiciones[1]->y = 8;
    posiciones[2]->x = 2;
    posiciones[2]->y = 5;
    posiciones[3]->x = 8;
    posiciones[3]->y = 5;

    if (argc != 2) {
        fprintf(stderr, "Uso: %s archivo.txt\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (archivo == NULL) {
        fprintf(stderr, "No se pudo abrir el archivo %s\n", argv[1]);
        return 1;
    }


    yyin = archivo;


    yyparse();


    fclose(archivo);
    printf("Player names:\n");
    for (int i = 0; i < num_players; i++) {
        printf("%d: %s\n", i + 1, player_name[i]);
    }
}

int yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
    return 0;
}

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
int map[MAP_SIZE][MAP_SIZE] = {0};
int vidas[4] = {10, 10, 10, 10};
int direccion[4] = {0, 90, 180, 270};
int damage = 0;

typedef struct {
    int x;
    int y;
} Posicion;

Posicion **posiciones;
int num_player_playing = 0;

void check_player_name(char *player_name_check) {
    // Implementación de la función
}

void move_forward(int player_index) {
    // Implementación de la función
}

void move_backward(int player_index) {
    // Implementación de la función
}

void cambiar_direccion(int* jugador_direccion, int nueva_direccion) {
    // Implementación de la función
}

double calcular_angulo(int jugador_x, int jugador_y, int oponente_x, int oponente_y) {
    // Implementación de la función
}

bool dentro_del_cono(int jugador_x, int jugador_y, int jugador_direccion, int oponente_x, int oponente_y) {
    // Implementación de la función
}

char* disparar(int mapa[MAP_SIZE][MAP_SIZE], int jugador_x, int jugador_y, int jugador_direccion, int oponente_x, int oponente_y, int* vida_oponente, int damage) {
    // Implementación de la función
}

%}

%union {
    char *str;
}

%token RUN
%token RETREAT
%token DODGE
%token ROLL_LEFT
%token ROLL_RIGHT
%token WEAK_SLASH
%token MEDIUM_SLASH
%token STRONG_SLASH
%token WEAK_KICK
%token MEDIUM_KICK
%token STRONG_KICK
%token CANCEL_DODGE
%token RETREAT_RUN
%token RUN_ROLL
%token SELECT
%token MAP
%token <str> MAP_NAME
%token <str> PLAYER_NAME
%token PNAME
%token TURN
%token FORWARD
%token REVERSE
%token RIGHT
%token LEFT
%token TURBO
%token BRAKE
%token ACCELERATE
%token MACHINE_GUN
%token SECONDARY_WEAPON_1
%token SECONDARY_WEAPON_2
%token FIREBALL_FREEZE_ATTACK
%token BE_INVISIBLE
%token FREEZE_ATTACK
%token JUMP
%token FINISH_GAME
%token FINISH_TURN

%% 

start : selections turn_structures FINISH_GAME;

selections : selection
           | selections selection;

selection :
      SELECT MAP MAP_NAME {
          strncpy(map_name, $3, sizeof(map_name) - 1);
          printf("Mapa seleccionado: %s\n", map_name);
          map_selected = 1;
      }
    | SELECT PLAYER_NAME PLAYER_NAME { 
          if (num_players < 4) {
              strncpy(player_name[num_players++], $3, sizeof(player_name[0]) - 1); // Cambiado a $3
              printf("Personaje %d: %s\n", num_players, player_name[num_players - 1]);
          } else {
              printf("Error: Solo se pueden seleccionar 4 personajes.\n");
              exit(1);
          }
      }
    ;
turn_structures : turn_structure
                | turn_structures turn_structure;

turn_structure : RUN | RETREAT | DODGE | ROLL_LEFT | ROLL_RIGHT | WEAK_SLASH | MEDIUM_SLASH | STRONG_SLASH |
                WEAK_KICK | MEDIUM_KICK | STRONG_KICK | CANCEL_DODGE | RETREAT_RUN | RUN_ROLL |
                FORWARD | REVERSE | RIGHT | LEFT | TURBO | BRAKE | ACCELERATE |
                MACHINE_GUN | SECONDARY_WEAPON_1 | SECONDARY_WEAPON_2 |
                FIREBALL_FREEZE_ATTACK | BE_INVISIBLE | FREEZE_ATTACK | JUMP | FINISH_TURN
                ;

%% 

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error opening file");
            return EXIT_FAILURE;
        }
    } else {
        yyin = stdin;
    }

    // Initialize player positions
    posiciones = (Posicion **)malloc(sizeof(Posicion *) * 4);
    for (int i = 0; i < 4; i++) {
        posiciones[i] = (Posicion *)malloc(sizeof(Posicion));
        posiciones[i]->x = 0; // Initialize x position
        posiciones[i]->y = 0; // Initialize y position
    }

    yyparse();
    fclose(yyin);
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

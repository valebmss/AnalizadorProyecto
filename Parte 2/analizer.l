%{
#include "analizer.tab.h"  // Incluye las definiciones de tokens generadas por Bison
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%

"⇑"                                { return FORWARD; }
"⇒"                                { return RIGHT; }
"⇐"                                { return LEFT; }
"⇓"                                { return REVERSE; }
"⇒⇒"                               { return RUN; }
"⇐⇐"                               { return RETREAT; }
"⇓⇓"                               { return DODGE; }
"↙↙"                               { return ROLL_LEFT; }
"↘↘"                               { return ROLL_RIGHT; }
"A"                                 { return WEAK_SLASH; }
"B"                                 { return MEDIUM_SLASH; }
"AB"                                { return STRONG_SLASH; }
"C"                                 { return WEAK_KICK; }
"D"                                 { return MEDIUM_KICK; }
"CD"                                { return STRONG_KICK; }
"AC"                                { return DODGE; }
"BD"                                { return DODGE; }
"BC"                                { return CANCEL_DODGE; }
"⇐⇐⇒"                              { return RETREAT_RUN; }
"⇒⇒↘"                              { return RUN_ROLL; }

[Ss][Ee][Ll][Ee][Cc][Tt]          { return SELECT; }
[Mm][Aa][Pp]                      { return MAP; }
[Pp][Ll][Aa][Yy][Ee][Rr]          { return PLAYER_NAME; }
"Turno:"                           { return TURN; }
"Termina."                         { return FINISH_TURN; }
"Fin del juego."                   { return FINISH_GAME; }

"Haohmaru"                         { yylval.str = strdup(yytext); return PNAME; }
"Nakoruru"                         { yylval.str = strdup(yytext); return PNAME; }
"Ukyo Tachibana"                   { yylval.str = strdup(yytext); return PNAME; }
"Charlotte Christine de Colde"     { yylval.str = strdup(yytext); return PNAME; }
"Galford D. Weller"                { yylval.str = strdup(yytext); return PNAME; }
"Jubei Yagyu"                      { yylval.str = strdup(yytext); return PNAME; }
"Terremoto"                        { yylval.str = strdup(yytext); return PNAME; }
"Hanzo Hattori"                    { yylval.str = strdup(yytext); return PNAME; }
"Kyoshiro Senryo"                  { yylval.str = strdup(yytext); return PNAME; }
"Wan-Fu"                           { yylval.str = strdup(yytext); return PNAME; }
"Genan Shiranui"                   { yylval.str = strdup(yytext); return PNAME; }
"Genjuro Kibagami"                 { yylval.str = strdup(yytext); return PNAME; }
"Cham Cham"                        { yylval.str = strdup(yytext); return PNAME; }
"Neinhalt Sieger"                  { yylval.str = strdup(yytext); return PNAME; }
"Nicotine Caffeine"                { yylval.str = strdup(yytext); return PNAME; }
"Kuroko"                           { yylval.str = strdup(yytext); return PNAME; }
"Mizuki Rashojin"                  { yylval.str = strdup(yytext); return PNAME; }

[ \t\n]+                           { /* Ignorar espacios en blanco */ }

.                                   { printf("Caracter no reconocido: %s\n", yytext); }

%%


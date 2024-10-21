%{
#include "analizer.tab.h"
%}
%option noyywrap
%%
[ Ss ][ Ee ][ Ll ][ Ee ][ Cc ][ Tt ]  {return SELECT; }
[ Mm ][ Aa ][ Pp ]                    {return MAP; }
[ Pp ][ Ll ][ Aa ][ Yy ][ Ee ][ Rr ]  {return PLAYER; }
"Turno:"                              {return TURN; }
"Termina."                            {return FINISH_TURN; }
"Fin del juego."                      {return FINISH_GAME; }
"Moscow"                              {return MAPNAME; }
"Paris"                               {return MAPNAME; }
"Amazonía"                            {return MAPNAME; }
"New York"                            {return MAPNAME; }
"Antarctica"                          {return MAPNAME; }
"Holland"                             {return MAPNAME; }
"Hong Kong"                           {return MAPNAME; }
"Axel"                                { yylval.str = strdup(yytext); return PNAME; }
"Grasshopper"                         { yylval.str = strdup(yytext); return PNAME; }
"Mr. Grimm"                           { yylval.str = strdup(yytext); return PNAME; }
"Hammerhead"                          { yylval.str = strdup(yytext); return PNAME; }
"Minion"                              { yylval.str = strdup(yytext); return PNAME; }
"Outlaw 2"                            { yylval.str = strdup(yytext); return PNAME; }
"Roadkill"                            { yylval.str = strdup(yytext); return PNAME; }
"Shadow"                              { yylval.str = strdup(yytext); return PNAME; }
"Mr. Slam"                            { yylval.str = strdup(yytext); return PNAME; }
"Spectre"                             { yylval.str = strdup(yytext); return PNAME; }
"Sweettooth"                          { yylval.str = strdup(yytext); return PNAME; }
"Thumper"                             { yylval.str = strdup(yytext); return PNAME; }
"Twister"                             { yylval.str = strdup(yytext); return PNAME; }
"Warthog"                             { yylval.str = strdup(yytext); return PNAME; }
"Darktooth"                           { yylval.str = strdup(yytext); return NPNAME; }
"⇑"                                   {return FORWARD; }
"⇒"                                   { return RIGHT; }
"⇓"                                   { return REVERSE; }
"⇐"                                   { return LEFT; }
"Y"                                   { return TURBO; }
"B"                                   { return BRAKE; }
"X"                                   { return ACCELERATE; }
"L1"                                  { return SECONDARY_WEAPON_1; }
"L2"                                  { return FIRE_SELECTED_WEAPON; }
"R1"                                  { return SECONDARY_WEAPON_2; }
"R2"                                  { return MACHINE_GUN; }
"L1L2R1R2⇒⇐⇑"                         { return FIREBALL_FREEZE_ATTACK; }
"⇐⇐⇓⇓"                                { return BE_INVISIBLE; }
"⇒⇐⇑"                                 { return FREEZE_ATTACK; }
"⇑⇐⇐"                                 { return JUMP; }



[ \t\n]+
.           { printf("Caracter no reconocido: %s\n", yytext); }
%%

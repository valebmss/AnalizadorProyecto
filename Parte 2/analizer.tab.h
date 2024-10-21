/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_ANALIZER_TAB_H_INCLUDED
# define YY_YY_ANALIZER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    RUN = 258,                     /* RUN  */
    RETREAT = 259,                 /* RETREAT  */
    DODGE = 260,                   /* DODGE  */
    ROLL_LEFT = 261,               /* ROLL_LEFT  */
    ROLL_RIGHT = 262,              /* ROLL_RIGHT  */
    WEAK_SLASH = 263,              /* WEAK_SLASH  */
    MEDIUM_SLASH = 264,            /* MEDIUM_SLASH  */
    STRONG_SLASH = 265,            /* STRONG_SLASH  */
    WEAK_KICK = 266,               /* WEAK_KICK  */
    MEDIUM_KICK = 267,             /* MEDIUM_KICK  */
    STRONG_KICK = 268,             /* STRONG_KICK  */
    CANCEL_DODGE = 269,            /* CANCEL_DODGE  */
    RETREAT_RUN = 270,             /* RETREAT_RUN  */
    RUN_ROLL = 271,                /* RUN_ROLL  */
    SELECT = 272,                  /* SELECT  */
    MAP = 273,                     /* MAP  */
    MAP_NAME = 274,                /* MAP_NAME  */
    PLAYER_NAME = 275,             /* PLAYER_NAME  */
    PNAME = 276,                   /* PNAME  */
    TURN = 277,                    /* TURN  */
    FORWARD = 278,                 /* FORWARD  */
    REVERSE = 279,                 /* REVERSE  */
    RIGHT = 280,                   /* RIGHT  */
    LEFT = 281,                    /* LEFT  */
    TURBO = 282,                   /* TURBO  */
    BRAKE = 283,                   /* BRAKE  */
    ACCELERATE = 284,              /* ACCELERATE  */
    MACHINE_GUN = 285,             /* MACHINE_GUN  */
    SECONDARY_WEAPON_1 = 286,      /* SECONDARY_WEAPON_1  */
    SECONDARY_WEAPON_2 = 287,      /* SECONDARY_WEAPON_2  */
    FIREBALL_FREEZE_ATTACK = 288,  /* FIREBALL_FREEZE_ATTACK  */
    BE_INVISIBLE = 289,            /* BE_INVISIBLE  */
    FREEZE_ATTACK = 290,           /* FREEZE_ATTACK  */
    JUMP = 291,                    /* JUMP  */
    FINISH_GAME = 292,             /* FINISH_GAME  */
    FINISH_TURN = 293              /* FINISH_TURN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 65 "analizer.y"

    char *str;

#line 106 "analizer.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_ANALIZER_TAB_H_INCLUDED  */

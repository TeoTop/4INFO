/* Choses à faire  :
  Remplir les actions pour chaque regle de grammaire
 */

%{
  open Ast
%}

/* Mots-clefs du langage */
%token SET WALK ROTATE LEFT SET RIGHT CIRCLE WITH DIAMETER POSITION

/* Caractères divers */
%token LP RP COMMA SEMICOLON AFFECT
%token MULT PLUS DIV MINUS EOF

/* Les constantes */
%token <int> INT
%token <string> IDENT

/* Opérateurs avec leurs priorite et associativite */
%left PLUS MINUS
%left MULT DIV

%type <Ast.prog> parse_prog
%start parse_prog

%%

parse_prog:
| linstr      {  }
;

linstr:
| instr                   { }
| instr SEMICOLON linstr  { }
;

instr:
| SET IDENT AFFECT expr              { }
| WALK expr                          { }
| ROTATE dir expr                    { }
| CIRCLE WITH DIAMETER expr          { }
| SET POSITION LP expr COMMA expr RP { }


dir:
| LEFT { }
| RIGHT { }
;

expr:
| IDENT           { }
| INT             { }
| expr PLUS  expr { }
| expr MULT  expr { }
| expr MINUS expr { }
| expr DIV   expr { }
;


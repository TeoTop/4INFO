%{
  open Ast
%}

%token <int> INT
%token <bool> BOOL
%token <string> VAR
%token LET
%token EOF END_OF_EXPRESSION
%token LEFT_PAREN RIGHT_PAREN
%token COMMA
%token EGAL AFFECT
%token REC
%token FUN
%token IF THEN ELSE
%token PLUS MOINS MULT
%token INF
%token FST SND
%token CONS
%token NIL
%start main
%type <Ast.ml_expr> main
%%

main:
 | EOF { Printf.printf "\nbye"; exit 0 }
 | expr END_OF_EXPRESSION { $1 }
 | error {
    let bol = (Parsing.symbol_start_pos ()).Lexing.pos_bol in
    failwith ("parsing: line " ^ 
		 (string_of_int ((Parsing.symbol_start_pos ()).Lexing.pos_lnum)) ^ 
		 " between character " ^
		 (string_of_int (Parsing.symbol_start () - bol)) ^
		 " and " ^
		 (string_of_int ((Parsing.symbol_end ()) + 1 - bol)))
 }

expr:
| simple_expr { $1 }
| application { List.fold_left (fun res a -> Ml_app(res, a)) (List.hd $1) (List.tl $1) }
/* TO DO */

simple_expr:
| INT { Ml_int $1 }
| BOOL { Ml_bool $1 }
| VAR { Ml_var $1 } 
| NIL { Ml_nil }

application:
 | simple_expr_or_parenthesized_expr simple_expr_or_parenthesized_expr application_next { $1 :: $2 :: $3 }

simple_expr_or_parenthesized_expr:
 | simple_expr { $1 }
 | LET VAR EGAL simple_expr { Ml_let($2,$4) }
 | LEFT_PAREN expr COMMA expr RIGHT_PAREN { Ml_pair($2, $4) }
 | LEFT_PAREN expr RIGHT_PAREN { $2 }

application_next:
 | simple_expr_or_parenthesized_expr application_next { $1 :: $2 }
 | { [] }

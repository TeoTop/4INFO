%{
  open Ast
%}

%token <int> INT
%token <string> IDENT
%token TRUE FALSE
%token LET REC IN
%token FUNCTION ARROW ALTERNATIVE 
%token IF THEN ELSE
%token ADD SUB MULT LESS
%token FST SND
%token EQUAL
%token LEFT_PAREN RIGHT_PAREN
%token LEFT_BRACKET RIGHT_BRACKET CONS
%token COMMA
%token END_OF_EXPRESSION
%token EOF
%token COLON
%token TBOOL TINT TLIST

%nonassoc NO_ALTERNATIVE
%nonassoc ALTERNATIVE IN
%left LESS EQUAL
%right CONS
%left ADD SUB
%right ARROW
%left TLIST
%left MULT
%nonassoc FST SND ELSE

%start main
%type <Ast.ml_ast * StrSet.t > main
%%

main:
 | EOF { Printf.printf "\nbye"; exit 0 }
 | LET IDENT EQUAL expr END_OF_EXPRESSION { Ml_definition($2, fst $4), snd $4 }
 | LET REC IDENT type_fonction EQUAL expr END_OF_EXPRESSION { Ml_definitionrec($3, $4, fst $6) , StrSet.remove $3 (snd $6) }
 | expr END_OF_EXPRESSION { Ml_expr (fst $1) , snd $1 }
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
 | LEFT_PAREN expr RIGHT_PAREN { $2 }
 | expr CONS expr { Ml_cons(fst $1, fst $3) , StrSet.union (snd $1) (snd $3) }
 | LEFT_PAREN expr COMMA expr RIGHT_PAREN { Ml_pair(fst $2, fst $4) , StrSet.union (snd $2) (snd $4) }
 | FST expr { Ml_unop(Ml_fst, fst $2) , snd $2 }
 | SND expr { Ml_unop(Ml_snd, fst $2) , snd $2 }
 | expr ADD expr { Ml_binop(Ml_add, fst $1, fst $3) , StrSet.union (snd $1) (snd $3) }
 | expr MULT expr { Ml_binop(Ml_mult, fst $1, fst $3) , StrSet.union (snd $1) (snd $3) }
 | expr SUB expr { Ml_binop(Ml_sub, fst $1, fst $3),  StrSet.union (snd $1) (snd $3) }
 | expr LESS expr { Ml_binop(Ml_less, fst $1, fst $3), StrSet.union (snd $1) (snd $3) }
 | expr EQUAL expr { Ml_binop(Ml_eq, fst $1, fst $3), StrSet.union (snd $1) (snd $3) }
 | IF expr THEN expr ELSE expr { Ml_if(fst $2, fst $4, fst $6), StrSet.union (snd $2) (StrSet.union (snd $4) (snd $6)) }
 | FUNCTION pattern_expr_list { Ml_fun (fst $2) , snd $2 }
 | application { List.fold_left (fun res a -> Ml_app(res, a)) (List.hd (fst $1)) (List.tl (fst $1)) , snd $1}
 | LET IDENT EQUAL expr IN expr { Ml_let($2, fst $4, fst $6) , StrSet.union (StrSet.remove $2 (snd $6)) (snd $4) }
 | LET REC IDENT type_fonction EQUAL expr IN expr { Ml_letrec($3, $4, fst $6, fst $8) ,  StrSet.remove $3 (StrSet.union (snd $6) (snd $8)) }

simple_expr:
 | INT { Ml_int $1, StrSet.empty }
 | bool { Ml_bool $1, StrSet.empty }
 | LEFT_PAREN LEFT_BRACKET RIGHT_BRACKET COLON type_expr RIGHT_PAREN { Ml_nil $5, StrSet.empty }
 | IDENT { Ml_var $1 , StrSet.singleton $1 }

type_fonction:
| type_expr ARROW type_fonction { TFun ($1,$3) }
| type_expr { $1 }

type_expr:
| TINT { Tint }
| TBOOL { Tbool }
| type_expr MULT type_expr { TPair ($1,$3) }
| type_expr TLIST { TList $1 }


bool:
 | FALSE { false }
 | TRUE  { true }

pattern:
 | LEFT_PAREN IDENT COLON type_expr RIGHT_PAREN { Ml_pattern_var ($2,$4) ,StrSet.singleton $2 } 
 | INT   { Ml_pattern_int $1 , StrSet.empty }
 | bool  { Ml_pattern_bool $1 , StrSet.empty }
 | LEFT_PAREN pattern COMMA pattern RIGHT_PAREN 
   {Ml_pattern_pair(fst $2, fst $4), StrSet.union (snd $2) (snd $4)  }
 | LEFT_BRACKET RIGHT_BRACKET COLON type_expr { Ml_pattern_nil $4, StrSet.empty }
 | pattern CONS pattern { Ml_pattern_cons(fst $1, fst $3), StrSet.union (snd $1) (snd $3)}

pattern_expr_list:
 | pattern ARROW expr pattern_expr_list_next { (fst $1, fst $3) :: fst $4 , StrSet.union (StrSet.diff (snd $3) (snd $1)) (snd $4) }

pattern_expr_list_next:
 | ALTERNATIVE pattern ARROW expr pattern_expr_list_next { (fst $2, fst $4) :: fst $5, StrSet.union (StrSet.diff (snd $4) (snd $2)) (snd $5) }
 | %prec NO_ALTERNATIVE { [] , StrSet.empty }

application:
 | simple_expr_or_parenthesized_expr simple_expr_or_parenthesized_expr application_next { fst $1 :: fst $2 :: fst $3, StrSet.union (snd $1) (StrSet.union (snd $2) (snd $3)) }

simple_expr_or_parenthesized_expr:
 | simple_expr { $1 }
 | LEFT_PAREN expr RIGHT_PAREN { $2 }

application_next:
 | simple_expr_or_parenthesized_expr application_next { fst $1 :: fst $2 , StrSet.union (snd $1) (snd $2) }
 | { [] , StrSet.empty }



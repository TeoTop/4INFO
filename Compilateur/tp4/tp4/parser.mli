type token =
  | SET
  | WALK
  | ROTATE
  | LEFT
  | RIGHT
  | CIRCLE
  | WITH
  | DIAMETER
  | POSITION
  | LP
  | RP
  | COMMA
  | SEMICOLON
  | AFFECT
  | MULT
  | PLUS
  | DIV
  | MINUS
  | EOF
  | INT of (int)
  | IDENT of (string)

val parse_prog :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.prog

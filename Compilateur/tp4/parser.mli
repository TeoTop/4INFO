type token =
  | EOL
  | EOF
  | BEGIN
  | END
  | SEMI_COLUMN
  | COMA
  | INT
  | BOOL
  | FLECHE
  | PLUS
  | INF
  | AND
  | PAROUV
  | PARFERM
  | IDENT of (string)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit

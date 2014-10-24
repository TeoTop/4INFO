(*{
  open Ulex (* Ulex contains the type definition of lexical units *)
}*)
{
   open Parser        (* The type token is defined in parser.mli *)
}

rule token = parse (* TODO *)
   | [' ' '\t']     { token lexbuf } (* lexbuf : buffer *)
   | ['\n' ] { Lexing.new_line lexbuf; token lexbuf }
   | eof     { EOF }
   | "begin" { BEGIN }
   | ';'     { SEMI_COLUMN }
   | "end"   { END }
   | ','     { COMA }
   | "int"   { INT }
   | "bool"  { BOOL }
   | "<-"    { FLECHE }
   | '+'     { PLUS }
   | '<'     { INF }
   | "and"   { AND }
   | '('     { PAROUV }
   | ')'     { PARFERM }
   | ['A'-'Z' 'a'-'z' '0'-'9' '_']* as ident {IDENT ident}



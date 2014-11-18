{
  open Parser
  open Lexing

  exception Lex_error of char


(* Pour compter les lignes au fur et a mesure *)

  let newline lexbuf = 
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      {pos with
      pos_bol = pos.pos_cnum;
      pos_lnum = pos.pos_lnum + 1
      }

}

let eol = ['\n']
let space = [' ' '\t' '\r']
let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let integer = '-'? digit+
let ident = (letter| '_') (letter | digit | '_' )*
let chr = "'" _ "'"
 
rule get_token = parse
   | ';'          { SEMICOLON }
   | "set"        { SET }
   | ":="         { AFFECT }
   | "walk"       { WALK }
   | "rotate"     { ROTATE }
   | "left"       { LEFT }
   | "set"        { SET }
   | "right"      { RIGHT }
   | "circle"     { CIRCLE }
   | "position"   { POSITION }
   | "with"       { WITH }
   | "diameter"   { DIAMETER }
   | '('          { LP }
   | ')'          { RP }
   | ','          { COMMA }
   | '*'          { MULT }
   | '+'          { PLUS }
   | '/'          { DIV }
   | '-'          { MINUS }
   | ident as i   { IDENT i }
   | integer as i	{ INT (int_of_string i) }
   | eol	        { newline lexbuf; get_token lexbuf }
   | space        { get_token lexbuf }
   | eof		      { EOF }
   | _ as c       { raise (Lex_error c) }


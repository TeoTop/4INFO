(*{
  open Ulex (* Ulex contains the type definition of lexical units *)
}*)
{
   open Parser        (* The type token is defined in parser.mli *)

   let keyword_table = Hashtbl.create 53
   let _ = List.iter (fun (kwd, tok) -> Hashtbl.add keyword_table kwd tok)
      ["begin", BEGIN;
      "end", END;
      "int", INT;
      "bool", BOOL;
      "and", AND]
}

rule token = parse (* TODO *)
   | [' ' '\t']     { token lexbuf } (* lexbuf : buffer *)
   | ['\n' ] { Lexing.new_line lexbuf; token lexbuf }
   | "/*" ([^'*'] | '*' + [^'/'])* "*/" {token lexbuf} (*commentaires plusieurs lignes*)
   | "//" ([^'\n'])* {token lexbuf} (*commentaires 1 ligne*)
   | eof     { EOF }
   | ';'     { SEMI_COLUMN }
   | ','     { COMA }
   | "<-"    { FLECHE }
   | '+'     { PLUS }
   | '<'     { INF }
   | '('     { PAROUV }
   | ')'     { PARFERM }
   | ['A'-'Z' 'a'-'z' '0'-'9' '_']* as ident {try Hashtbl.find keyword_table ident
                                                with Not_found -> IDENT ident}
            (*permet de vérifier si l ident lu n est pas une unité léxicale*)




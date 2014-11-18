open Parser
open Lexer
open Lexing
open Parsing
open Type

(*On lit dans le fichier test*)
let lexbuf = Lexing.from_channel (open_in "test");;

(*On vérifie si la grammaire du fichier chargé dans lexbuf est respectée*)
let _ = try bloc token lexbuf with
| Parse_error -> failwith (let err = lexeme_start_p lexbuf in
"Erreur dans le fichier "^err.pos_fname
^", a la ligne "^string_of_int(err.pos_lnum)
^", caractere "^string_of_int(err.pos_cnum - err.pos_bol));;

let arbre = bloc token lexbuf;;

(*On affiche les éléments de l arbre abstrait*)
let rec display = function
	| Add (exp1,exp2) -> display exp1;Printf.printf " Plus ";display exp2
	| Inf (exp1,exp2) -> display exp1;Printf.printf " Inf ";display exp2
	| And (exp1,exp2) -> display exp1;Printf.printf " And ";display exp2
	| Id s -> Printf.printf "Ident %s" s
	| Ex exp -> display exp;;

let f = function
	| Inst(s,e) -> Printf.printf "Inst\n";Printf.printf "%s Aff " s;display e;Printf.printf "\n"
	| Inst_Bloc a -> failwith "error";;

let _ = match arbre with
  | Bloc (sdecl,sinst) -> Printf.printf "Sdecl\n";
List.iter 
	(
	fun (t,s) -> match t with
	  | INT -> Printf.printf "Int(%s)\n" s
	  | BOOL -> Printf.printf "Bool(%s)\n" s
	)
sdecl;
List.iter 
	(
	fun inst -> Printf.printf "Sinst\n";
	f inst
	)
sinst;;

Printf.printf "Success !\n";;
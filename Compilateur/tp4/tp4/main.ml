open Ast;;
open Printf;;

(* Fonctions utiles pour convertir float <-> int et degree -> radian *)
let to_rad d  = 3.14159 *. d /. 180.0;;
let to_f = float_of_int ;;
let to_i = int_of_float;;

(* Etat initial de la tortue *)
let init_state = {pos_x = 0; pos_y = 0; angle = 0; env = []};;

let evaluate_program prog (l : Ast.prog) f =
  let file = open_out f in
        (* REMPLIR *)
  fprintf file "stroke showpage\n";
  close_out file;;

(* Now we can use the parser. *)

let evaluate_string s =
  let lexbuf = Lexing.from_string s in
	let prog = Parser.parse_prog Lexer.get_token lexbuf in
  evaluate_program prog;;

let evaluate_file s =
  let f = open_in s in
  let lexbuf = Lexing.from_channel f in
	let prog = Parser.parse_prog Lexer.get_token lexbuf in
  evaluate_program prog;;

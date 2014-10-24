open Parser;;
open Lexer;;
open Lexing;;
open Parsing;;

(* si le fichier "test" contient un code � analyser *)
(*main token (Lexing.from_channel (open_in "test"));;*)

(* pour de tous petits tests *)
main token (Lexing.from_string "begin int a ; a <- 5 + 2 end");;

(* La suite est utile pour tester l'analyseur lexical tout seul. *)
(* Il faut juste d�clarer le type token. Normalement il est d�clar� au d�but du *)
(* fichier parser.ml et provient des %token qui se trouvent dans l'en-t�te de *)
(* parser.mly. *)
let lexbuf = Lexing.from_channel (open_in "test");;
(* ou *)
(*let lexbuf = Lexing.from_string "begin int a ; a <- 5 + 2 end";;*)

token lexbuf;; (* donne la prochaine unit� lexicale *)

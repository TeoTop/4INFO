open Grammar

let output_vt_set o s = 
 Printf.fprintf o "{";
 VTSet.iter (fun vt -> Printf.fprintf o " %a" output_vt vt) s;
 Printf.fprintf o " }"


module type LexerI = 
 sig
  type ulex

  val token : Lexing.lexbuf -> ulex

  val terminal_of_ulex : grammar -> ulex -> vt

  val is_eof : ulex -> bool
  (** [is_eof ul] Return true iff ul is the token representing the end of file.
      Invariant: is_eof ul -> terminal_of_ulex g ul = end_of_stream g *)

  val string_of_token : ulex -> string

 end

module MyLexer : LexerI = 
struct

 open Ulex

 type ulex = Ulex.token

 let token = Lexer.token

 let string_of_token  = function
  | UL_EOF  -> "UL_EOF"
  | UL_PARFERM -> "UL_PARFERM"
  | UL_PAROUV -> "UL_PAROUV"
  | UL_EGAL -> "UL_EGAL"
  | UL_DIFF -> "UL_DIFF"
  | UL_INF -> "UL_INF"
  | UL_SUP -> "UL_SUP"
  | UL_ET -> "UL_ET"
  | UL_OU  -> "UL_OU"
  | UL_IDENT id  -> "UL_IDENT" ^id
  | UL_SI  -> "UL_SI"
  | UL_ALORS  -> "UL_ALORS"
  | UL_SINON  -> "UL_SINON"
  | UL_FSI  -> "UL_FSI"
  | UL_SUPEG  -> "UL_SUPEG"
  | UL_INFEG  -> "UL_INFEG"


 let terminal_of_ulex g = function
  | UL_EOF  -> end_of_stream g
  | UL_PARFERM -> string_to_vt "parferm"
  | UL_PAROUV -> string_to_vt "parouv"
  | UL_EGAL -> string_to_vt "egal"
  | UL_DIFF -> string_to_vt "diff"
  | UL_INF -> string_to_vt "inf"
  | UL_SUP -> string_to_vt "sup"
  | UL_ET -> string_to_vt "et"
  | UL_OU  -> string_to_vt "ou"
  | UL_IDENT _ -> string_to_vt "ident"
  | UL_SI  -> string_to_vt "si"
  | UL_ALORS  -> string_to_vt "alors"
  | UL_SINON  -> string_to_vt "sinon"
  | UL_FSI  -> string_to_vt "fsi"
  | UL_SUPEG  -> string_to_vt "supeg"
  | UL_INFEG  -> string_to_vt "infeg"

   
 let is_eof = function
  | UL_EOF -> true
  | _      -> false

end

let scanner lexbuf =
  
  let rec scanner_rec n l = 
    try 
     let tk = MyLexer.token lexbuf in
     if MyLexer.is_eof tk
     then (tk::l)
     else scanner_rec (n+1) (tk :: l) 
    with x -> 
     begin
      Printf.printf "Warning : exception %s was raised after reading %i tokens\n" 
       (Printexc.to_string x) n;
      l
     end
  in
  List.rev (scanner_rec 0 []);;


let grammar_file = ref "" 

let args = [
 ("-grammar",Arg.Set_string grammar_file,"<file> : Analyse the grammar specification from <file> ");
]

let usage_msg = "usage:"

let check_arg () = 
 match !grammar_file with
 | "" -> Arg.usage args usage_msg ; exit 1
 | _  -> ()

let _ =
 Arg.parse args (fun _ -> ()) usage_msg ; 
 check_arg ();
 let g  = Grammar.from_file !grammar_file in
 let acc = LL1.acc g in
 let gen = LL1.gen g in
 let nt = nterminals g in
 let wf = 
 VNSet.fold (fun vn b -> 
  let acc = acc vn in
  let gen = gen vn in 
  if not acc  then Printf.fprintf stdout "Non terminal %a is not accessible\n" output_vn vn;
  if not gen then Printf.fprintf stdout "Non terminal %a is not generative\n" output_vn vn;
  acc && gen && b ) nt true in
  if not wf then exit 1;
  Printf.fprintf stdout "Grammar is well-formed\n\n";
  let null = LL1.null g in
  let first = LL1.first g null in
  let follow = LL1.follow g null first in
  VNSet.iter (fun vn -> Printf.fprintf stdout "Null %a = %b\n" output_vn vn (null vn)) nt;
  Printf.fprintf stdout "\n";
  VNSet.iter (fun vn -> Printf.fprintf stdout "First %a = %a\n" 
   output_vn vn output_vt_set (first  vn)) nt;
  Printf.fprintf stdout "\n";
  VNSet.iter (fun vn -> Printf.fprintf stdout "Follow %a = %a\n" 
   output_vn vn output_vt_set (follow  vn)) nt ;
  Printf.fprintf stdout "\n";
  flush stdout ; 
  if LL1.is_ll1 g null first follow
  then begin
   Printf.fprintf stdout "The grammar is LL1\n"; 
    try
      Printf.fprintf stdout "Input a string:\n";
      flush stdout;
      let lexbuf = Lexing.from_channel stdin  in
      let stream = scanner lexbuf in 
      let tree   = (Engine.parse g (MyLexer.terminal_of_ulex g)  stream) in 
      Engine.print_parse_tree MyLexer.string_of_token tree
    with exn -> Printf.fprintf stdout "%s\n" (Printexc.to_string exn)
  end 
  else Printf.fprintf stdout "The grammar is NOT LL1\n";

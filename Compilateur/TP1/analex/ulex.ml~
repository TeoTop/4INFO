(** [token] is the type of the different lexical units. *)
type token =
             | UL_EOF
	     | UL_PARFERM
	     | UL_PAROUV
	     | UL_EGAL
	     | UL_DIFF
	     | UL_INF
	     | UL_SUP
	     | UL_ET
	     | UL_OU	
	     | UL_SI	
	     | UL_FSI	
	     | UL_SINON	
	     | UL_SUPEG	
	     | UL_INFEG	
	     | UL_IDENT of string

(** [is_eof] : token  -> bool
    is_eof tk returns true if the lexical unit represents the end_of file.
*)
let is_eof = function
  | UL_EOF -> true
  | _      -> false

(** [print_token] : out_channel -> token -> unit
    print_token o tk prints on the output channel o the textual representation of the token tk *)
let print_token o = function
  | UL_EOF  -> Printf.fprintf o "UL_EOF"
  | UL_PARFERM -> Printf.fprintf o "UL_PARFERM"
  | UL_PAROUV -> Printf.fprintf o "UL_PAROUV"
  | UL_EGAL -> Printf.fprintf o "UL_EGAL"
  | UL_DIFF -> Printf.fprintf o "UL_DIFF"
  | UL_INF -> Printf.fprintf o "UL_INF"
  | UL_SUP -> Printf.fprintf o "UL_SUP"
  | UL_ET -> Printf.fprintf o "UL_ET"
  | UL_OU  -> Printf.fprintf o "UL_OU"
  | UL_IDENT id  -> Printf.fprintf o "UL_IDENT \"%s\"" id
  | UL_SI  -> Printf.fprintf o "UL_SI"
  | UL_SINON  -> Printf.fprintf o "UL_SINON"
  | UL_FSI  -> Printf.fprintf o "UL_FSI"
  | UL_SUPEG  -> Printf.fprintf o "UL_SUPEG"
  | UL_INFEG  -> Printf.fprintf o "UL_INFEG"



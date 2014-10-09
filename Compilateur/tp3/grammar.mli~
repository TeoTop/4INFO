type vt (** terminals *)
type vn (** non-terminals *)
type v =   (** terminals or non-terminals *)
| Vt of vt
| Vn of vn
type grammar    

type production = vn * v list

module VTSet : Set.S with type elt = vt 

module VNSet : Set.S with type elt = vn

val string_to_vt : string -> vt

val vt_to_string : vt -> string

val vn_to_string : vn -> string

val output_vn : out_channel -> vn -> unit
(** Output a non-terminal over a channel *)

val output_vt : out_channel -> vt -> unit
(** Output a terminal over a channel *)

val vt_equal : vt -> vt -> bool
(** Return true iff the terminals are equal. *)

val vn_equal : vn -> vn -> bool
(** Return true iff the non-terminals are equal. *)

val axiom    : grammar -> vn
(** Return the axiom of the grammar. *)

val end_of_stream : grammar -> vt

val terminals   : grammar -> VTSet.t
(** Return the set  of terminals of the grammar. *)

val nterminals  : grammar -> VNSet.t
(** Return the set of non-terminals of the grammar. *)

val production  : grammar -> vn -> (v list) list
(** [production g vn] returns { r | vn -> r is a production of g}
    (the set is represented as a list).
*)

val filter_production : grammar -> (production -> 'a option) -> 'a list
(** [filter_production g f] = { a | vn -> w in P /\ f vn w = Some a } *)


val from_file : string -> grammar
(** [from_file str] parses the file str and returns the corresponding grammar.
    the syntax of grammars is given by the following (informal) grammar:
    S      -> "(" vt_set "," vn_set "," axiom "," production_set ")"
    vt_set -> "{" vt_list "}"
    vn_set -> "{" vn_list "}"
    axiom  -> vn
    vt_set -> vt "," vt_set | vt
    vn_set -> vn "," vn_set | vn
    production_set -> "{" production_list "}"
    production_list -> production "," production_list | production
    production     -> vn "->" vn_vt_list 
    vn_vt_list     -> vn_vt vn_vt_list | 
    vn_vt          -> vn | vt
    vn             -> alphanumeric_string
    vt             -> alphanumeric_string
*)

val kleene_fun : grammar -> ('a -> 'a -> bool) -> ((vn -> 'a) -> vn -> 'a) -> 'a -> (vn -> 'a)
(** [kleene_fun g order f bot] computes the smallest function X : vn -> 'a
    such that forall any non-terminal of the grammar vn
    X vn = (f X) vn
    - [order] is the ordering of the elements of 'a
    - [bot] is the smallest element for the domain 'a
    - [f] is a monotonic function for the ordering [order]
*)


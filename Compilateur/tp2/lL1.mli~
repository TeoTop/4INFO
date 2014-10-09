open Grammar

val acc : grammar -> (vn -> bool)
(** [acc g X] is true if the non-terminal X is accessible from the axiom S
    i.e., there is a derivation of the form S ->* ....X.....
*)

val gen : grammar -> (vn -> bool)
(** [gen g X] is true if the language recognised by the non_terminal X is not empty
    exists w \in vt^*. X ->* w
*)

val null   : grammar -> (vn -> bool)

val first : grammar -> (vn -> bool) -> (vn -> VTSet.t)

val follow : grammar -> (vn -> bool) -> (vn -> VTSet.t) -> (vn -> VTSet.t)

val is_ll1 : grammar -> (vn -> bool) -> (vn -> VTSet.t) -> (vn -> VTSet.t) -> bool

val deriv : grammar -> (vn -> bool) -> (vn -> VTSet.t) -> (vn -> VTSet.t) -> vn -> vt -> (v list) option


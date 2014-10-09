open Grammar

let acc g = kleene_fun g order (acc_vn g) false

let gen  = fun _ -> failwith "gen : TODO"

let null = fun _ -> failwith "null : TODO"

let first = fun _ _ -> failwith "first : TODO"

let follow = fun _ _ _ -> failwith "follow : TODO"

let is_ll1 = fun _ _ _ _ -> failwith "is_ll1 : TODO"

let deriv  = fun _ _ _ _ _ _ -> failwith "deriv : TODO"

(*let acc_vn g f = 
  fun vn ->
  if vn = axiome then
*)

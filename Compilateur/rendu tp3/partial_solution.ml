open Grammar

let rec first_prod : (vn -> bool) -> (vn -> VTSet.t) -> v list -> VTSet.t =
 fun null first l -> 
  match l with 
  | [] -> VTSet.empty
  | Vt vt::_ -> VTSet.singleton vt
  | Vn vn::l -> 
   if null vn 
   then VTSet.union (first vn) (first_prod null first l)
   else first vn

let first_vn : grammar -> (vn -> bool) -> (vn -> VTSet.t) -> vn -> VTSet.t = 
 fun g null first vn -> 
  let l = production g vn in
  List.fold_left (fun acc p -> VTSet.union acc (first_prod null first p)) VTSet.empty l

let order_set = VTSet.subset

let bot_set  = VTSet.empty

let first : grammar -> (vn -> bool ) -> (vn  -> VTSet.t) = 
 fun g null -> kleene_fun g order_set (first_vn g null) bot_set

let check_pair p l = 
 let rec check_rec l = 
  match l with
  | [] -> true
  | e::l -> List.for_all (p e) l && check_rec l in
 check_rec l

let check_ll1_c1 : (vn -> bool) -> (vn -> VTSet.t)  -> (v list) list -> bool = 
 fun null first prods -> 
  let p l1 l2 = VTSet.is_empty 
   (VTSet.inter (first_prod null first l1) (first_prod null first l2)) in
  check_pair p prods

let check_ll1_c2 : (vn -> bool) -> (vn -> VTSet.t) -> (vn -> VTSet.t) -> vn -> bool = 
 fun null first follow vn -> 
  if null vn 
  then VTSet.is_empty (VTSet.inter (first vn) (follow vn))
  else true

let check_ll1_c3 : (vn -> bool) -> vn -> (v list)  list -> bool = 
 fun null vn prods -> 
  if null vn
  then 
   let l = List.filter (null_prod null) prods in
   match l with
   | [] -> failwith "Non terminal is null -- but none of the production is!"
   | [_] -> true
   |  _  -> false
  else true


let is_ll1 : grammar -> (vn -> bool) -> (vn -> VTSet.t) -> (vn -> VTSet.t) -> bool =
 fun g null first follow -> 
 let vns = nterminals  g in
 VNSet.fold (fun vn b -> 
  b 
  && 
   let prods = production g vn in
   let c1    = check_ll1_c1 null first prods in
   let c2    = check_ll1_c2 null first follow vn in
   let c3    = check_ll1_c3 null vn prods in
   c1 && c2 && c3
 ) vns true

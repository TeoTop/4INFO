open Grammar

let implic res fa = not res || fa

let is_vn : vn -> v -> bool = 
 fun vn v -> 
  match v with
  | Vt _ -> false
  | Vn vn' -> vn_equal vn vn'


let acc_vn g f = 
  fun vn ->
  if vn_equal vn (axiom g) then true
  else List.exists f (filter_production g (fun (nv,l) -> if List.exists (is_vn vn) l then Some nv else None))

let acc g = kleene_fun g implic (acc_vn g) false

(*===================================================*)

let rec gen_prod f = function
  | [] -> true
  | (Vt vt)::r -> gen_prod f r
  | (Vn vn)::r -> f vn && gen_prod f r
  

let gen_vn g f =  
 fun vn -> 
   List.exists (gen_prod f) (production g vn)
   

let gen g = kleene_fun g implic (gen_vn g) false

(*===================================================*)

let rec null_prod f = function
  | [] -> true
  | Vt vt::r -> false
  | Vn vn::r -> f vn && null_prod f r

let null_vn g f =  
 fun vn -> 
   List.exists (null_prod f) (production g vn)

let null g = kleene_fun g implic (null_vn g) false


(*===================================================*)


let rec first_prod : (vn -> bool) -> (vn -> VTSet.t) -> v list -> VTSet.t =
 fun null first l -> 
  match l with 
  | [] -> VTSet.empty
  | (Vt vt)::_ -> VTSet.singleton vt
  | (Vn vn)::l -> 
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

(*===================================================*)

let follow_vn =
 fun g null first follow vn -> 
   let rec filter1 = function
     | (x,(Vn a)::reste) -> if vn_equal vn a then Some reste else filter1 (x,reste)
     | (x,(Vt a)::reste) -> filter1(x,reste)
     | _ -> None
   in
   let rec filter2 = function
     | (x,(Vn a)::reste) -> if (null_prod null reste) then if (vn_equal vn a) then Some x else filter2 (x,reste) else None
     | (x,(Vt a)::reste) -> filter2(x,reste)
     | _ -> None
   in
  let l1 = filter_production g filter1 in
  let l2 = filter_production g filter2 in
  let s1 = List.fold_left (fun acc p -> VTSet.union acc (first_prod null first p)) VTSet.empty l1 in
  let s2 = List.fold_left (fun acc p -> VTSet.union acc (follow p)) VTSet.empty l2 in
  VTSet.union s1 s2;;

let follow = 
 fun g null f -> kleene_fun g order_set (follow_vn g null f) bot_set

(*===================================================*)


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

let deriv g nu fi fo X t =  kleene_fun g order_set (follow_vn g null f) bot_set


 


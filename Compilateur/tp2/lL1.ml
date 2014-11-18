open Grammar

(* Permet de représenter le résultat logique d'une implication (res => fa). Utiliser dans les fonctions acc, gen et null *)
let implic res fa = not res || fa

(* Permet de savoir si le paramètre vn est un terminal ou un non-terminal de la grammaire *)
let is_vn : vn -> v -> bool = 
 fun vn v -> 
  match v with
  | Vt _ -> false
  | Vn vn' -> vn_equal vn vn'

(* Retourne la liste de tous les non-terminaux en fonction de la règle actuel et met à jour la table des non-terminaux que 
le peut atteindre. 'g' représente la grammaire, 'f' la partie courante de 'acc' et 'vn' le non-terminal à traiter *)
let acc_vn g f = 
  fun vn ->
  if vn_equal vn (axiom g) then true
  else List.exists f (filter_production g (fun (nv,l) -> if List.exists (is_vn vn) l then Some nv else None))

(* Permet de retourner le plus petit point fixe de la fonctionnelle acc_vn. Cela permet de vérifier que toutes les règles
de grammaires sont bien accessibles *)
let acc g = kleene_fun g implic (acc_vn g) false

(*===================================================*)

(* Fonction qui permet d'implémenter les équations de la "productivité" d'un non-terminal *)
let rec gen_prod f = function
  | [] -> true
  | (Vt vt)::r -> gen_prod f r
  | (Vn vn)::r -> f vn && gen_prod f r
  
(* Elle permet de retourner la liste de production terminal d'une grammaire *)
let gen_vn g f =  
 fun vn -> 
   List.exists (gen_prod f) (production g vn)
   
(* Permet de savoir si une grammaire est productive *)
let gen g = kleene_fun g implic (gen_vn g) false

(*===================================================*)

(* Fonction qui permet d'implémenter les équations pour savoir si une règle est nullable *)
let rec null_prod f = function
  | [] -> true
  | Vt vt::r -> false
  | Vn vn::r -> f vn && null_prod f r

(* Retourne la liste des règles nullable *)
let null_vn g f =  
 fun vn -> 
   List.exists (null_prod f) (production g vn)

(* Permet de savoir la grammaire peut être vide *)
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

(* Permet de récupérer la liste des suivants d'une règle de la grammaire *)
let follow_vn g (null:Grammar.vn -> bool) (first:Grammar.vn -> VTSet.t) (follow:Grammar.vn -> VTSet.t) (vn:Grammar.vn) =
  let rec filter1 : Grammar.production -> Grammar.v list list option = fun p ->
    let rec concat s1 s2 =
      match (s1,s2) with
        | (Some l1,Some l2) -> Some (l1::l2)
        | (Some l,_) -> Some [l]
        | (_,Some l) -> Some l
        | _ -> None
    in
    match p with
      | x,Vt(v)::l -> filter1 (x,l)
      | x,Vn(v)::l ->
        if (vn_equal vn v) then
          let s1 = Some l in
          let s2 = filter1 (x,l) in
          concat s1 s2
        else filter1 (x,l)
      | _ -> None
  in
  let rec filter2 p =
    let rec f a = function
      | [] -> a && true
      | Vt(vt)::l -> false
      | Vn(vn)::l -> f (null vn) l
    in
    match p with
      | x,Vt(v)::l -> filter2 (x,l)
      | x,Vn(v)::l -> if (vn_equal vn v) then if (f true l) then Some x else None else filter2 (x,l)
      | _ -> None
  in
  let l1 = List.flatten (filter_production g filter1) in
  let l2 = filter_production g filter2 in
  let s1 = List.fold_left (fun a e -> VTSet.union a (first_prod null first e)) VTSet.empty l1 in
  let s2 = List.fold_left (fun a e -> VTSet.union a (follow e)) VTSet.empty l2 in
  let ret = VTSet.union s1 s2 in
  if (vn_equal (axiom g) vn) then VTSet.union ret (VTSet.singleton (end_of_stream g)) else ret;;

(* Permet de récupérer tous les suivants d'une grammaire *)
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

(*==============================*)

(*Permet de savoir si l'exemple t est dérivable par la grammaire g *)
let deriv g null first follow x t =
  if(VTSet.mem t (first x)) then
    let ll = production g x in
    let l = List.find (fun e -> VTSet.mem t (first_prod null first e)) ll in
    Some l
  else if ((null x) && (VTSet.mem t (follow x))) then
    Some []
  else
    None


 


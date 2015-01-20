open Print_ast
open Ast


let is_list_typ = function
 | TList _ -> true
 | _       -> false


let rec typ_of_pattern = 
 function
 | Ml_pattern_var(s,typ) -> TypEnv.singleton s typ , typ
 | Ml_pattern_bool b -> TypEnv.empty , Tbool
 | Ml_pattern_int i  -> TypEnv.empty , Tint
 | Ml_pattern_pair(p1,p2) -> 
  let e1,t1 = typ_of_pattern p1 in
  let e2,t2 = typ_of_pattern p2 in
  TypEnv.add_all e1 e2 , TPair(t1,t2)
 | Ml_pattern_nil ty -> if is_list_typ ty then TypEnv.empty , ty else failwith "Erreur"
 | Ml_pattern_cons(x,l) -> 
  let e1,t1 = typ_of_pattern x in
  let e2,t2 = typ_of_pattern l in
  if t2 = TList t1
  then TypEnv.add_all e1 e2, t2
  else failwith (Printf.sprintf "Type non compatible %s different de %s" (string_of_typ t2) (string_of_typ (TList t1)))


let wt_unop op t = 
 match op ,t  with
 | Ml_fst , TPair(f,s) -> f
 | Ml_snd , TPair(f,s) -> s
 | op , _  -> failwith (Printf.sprintf "Erreur: %s n'attend pas le type %s"  (string_of_unop op) (string_of_typ t))


let wt_binop op t1 t2 = 
 match op ,t1 , t2  with
 | (Ml_add | Ml_sub | Ml_mult)  , Tint , Tint ->  Tint
 | Ml_less , Tint , Tint ->  Tbool
 | Ml_eq , e1, e2 -> 
  if e1 = e2 then  Tbool 
  else  failwith (Printf.sprintf "Erreur: Le comparateur = ne peut être utilisé entre le type %s et %s" (string_of_typ e1) (string_of_typ e2))
 | _  -> failwith (Printf.sprintf "L'opérateur %s n'est pris en charge." (string_of_binop op))

let same_types l = 
 match l with
 | [] -> failwith "Doit posséder un type"
 | e:: l -> 
  if  List.for_all (fun ty -> ty = e) l
  then  e
  else 
   let t' = List.find (fun ty -> ty <> e) l in
   failwith (Printf.sprintf "Erreur: La function retourne plusieurs types (%s et %s)" (string_of_typ e) (string_of_typ t'))


let rec wt_expr (env:TypEnv.t) = function
 | Ml_int i -> Tint
 | Ml_bool b ->Tbool
 | Ml_nil l   -> if is_list_typ l then l else failwith (Printf.sprintf "Erreur: %s doit être une liste" (string_of_typ l))
 | Ml_pair(e1,e2) -> 
  let t1 = wt_expr env e1 in 
  let t2 = wt_expr env e2 in
  TPair(t1,t2)
 | Ml_cons(e1,le1) -> 
  let t1 = wt_expr env e1 in
  let t2 = wt_expr env le1 in
  if t2 = TList t1
  then t2
  else  failwith (Printf.sprintf "Erreur: :: ne peut être utilisé entre le type %s et %s" (string_of_typ t1) (string_of_typ t2))
 | Ml_unop(op,e) -> wt_unop op (wt_expr env e)
 | Ml_binop(op,e1,e2) -> wt_binop op (wt_expr env e1) (wt_expr env e2)
 | Ml_var v -> TypEnv.find v env
 | Ml_if(e1,e2,e3) -> 
  let t1 = wt_expr env e1 in 
  let t2 = wt_expr env e2 in 
  let t3 = wt_expr env e3 in
  if t1 = Tbool 
  then if t2 = t3
   then t2
   else failwith (Printf.sprintf "Erreur: la condition retourne plusisurs types (%s et %s)" (string_of_typ t2) (string_of_typ t2))
  else failwith (Printf.sprintf "Erreur: La condition doit être de type boolean et non de type %s" (string_of_typ t1))
 | Ml_fun l -> 
  let ltyp = List.map (fun (pat,e) ->
   let (env',targs) = typ_of_pattern pat in  
   TFun(targs, wt_expr (TypEnv.update_all env' env) e)) l in
  same_types ltyp
 | Ml_app(e1,e2) -> 
  let t1 = wt_expr env e1 in
  let t2 = wt_expr env e2 in
  begin
   match t1 with
   | TFun(a,r) -> 
    if t2 = a 
    then r 
    else failwith (Printf.sprintf "Erreur: Impossible d'utiliser une fonction de type %s avec des arguments de type %s" (string_of_typ t1) (string_of_typ t2))
   |   _       -> failwith (Printf.sprintf "Erreur: Le terme attendue est de type %s, impossible d'utiliser l'argument de type %s" (string_of_typ t1) (string_of_typ t2))
  end
 | Ml_let (x,e1,e2) -> 
  let t1 = wt_expr env e1 in
  wt_expr (TypEnv.update x t1 env) e2
 | Ml_letrec(x,typ,e1,e2) -> 
  let env' = TypEnv.update x typ env in
  let ty' = wt_expr env' e1 in
  if ty' = typ then   wt_expr env' e2
  else failwith (Printf.sprintf "Erreur: let rec est incompatible avec le type %s et %s" (string_of_typ typ) (string_of_typ ty'))


let wt_expr env e =
 try
  wt_expr env e 
 with 
 | Failure s -> raise (Failure s)
 | TypEnv.TypeMismatch(s,t,t') -> failwith (Printf.sprintf "Erreur: La variable %s possède un type incompatible (%s et %s)" s (string_of_typ t) (string_of_typ t'))


let wt_ast tenv ast = 
  match ast with
  | Ml_expr e -> wt_expr (!tenv) e
  | Ml_definition(s,e) -> 
   let ty' = wt_expr !tenv e in
   tenv := TypEnv.update s ty'  !tenv ;
   ty'
  | Ml_definitionrec (s,ty',e) -> 
   let ty = wt_expr (TypEnv.update s ty' !tenv) e in
   if ty = ty'
   then
    begin
     tenv := TypEnv.update s ty !tenv ;
     ty'
    end
   else failwith (Printf.sprintf "Erreur: let rec est incompatible avec le type %s et %s" (string_of_typ ty) (string_of_typ ty'))

 



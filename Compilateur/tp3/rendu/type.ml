type arbre = Bloc of sdecl * sinst and
	sdecl = (tipe * string) list 
and
	tipe = 
	  | INT
	  | BOOL 
and
	sinst = inst list
and 
	inst = 
	  | Inst_Bloc of arbre
	  | Inst of string * expr 
and
	expr = Add of expr * expr
		| And of expr * expr
		| Inf of expr * expr
		| Id of string
		| Ex of expr

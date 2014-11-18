%{open Type %}

%token EOL
%token EOF

%token BEGIN END 
%token SEMI_COLUMN COMA
%token INT BOOL 
%token FLECHE 
%token PLUS INF AND
%token PAROUV PARFERM
%token <string> IDENT

%right AND
%right INF
%right PLUS

%start bloc             /* the entry point */
%type <Type.arbre> bloc
%%

bloc:
    BEGIN sdecl SEMI_COLUMN sinst END EOF { Bloc($2, $4) }
;

sdecl:
    decl                { [$1] }
  | decl COMA sdecl		{ $1::$3 }
;


decl:
tipe IDENT {$1,$2}
;


tipe:
	INT {INT}
	| BOOL {BOOL}
;


sinst:
    inst  { [$1] }
  | inst SEMI_COLUMN sinst  { $1::$3 }
;


inst:
	bloc					{ Inst_Bloc $1  }
  | IDENT FLECHE expr       { Inst($1, $3) }
;

expr:
    IDENT                    { Id $1 }
  | PAROUV expr PARFERM      { Ex $2 }
  | expr AND expr            { And($1, $3) }
  | expr INF expr            { Inf($1, $3) }
  | expr PLUS expr           { Add($1, $3) }
;


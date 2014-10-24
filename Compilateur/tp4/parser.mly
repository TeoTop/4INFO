%token EOL
%token EOF

%token BEGIN END 
%token SEMI_COLUMN COMA
%token INT BOOL 
%token FLECHE 
%token PLUS INF AND
%token PAROUV PARFERM
%token <string> IDENT

%left AND
%left INF
%left PLUS

%start main             /* the entry point */
%type <unit> main
%%

main:
	bloc EOF		{ }
;

bloc:
    BEGIN sdecl SEMI_COLUMN sinst END { }
;

sdecl:
    decl                { }
  | decl COMA sdecl		{ }
;


decl:
    tipe IDENT          { }
;


tipe:
    INT   { }
  | BOOL  { }
;


sinst:
    inst  { }
  | inst SEMI_COLUMN sinst  { }
;


inst:
	bloc					{ }
  | IDENT FLECHE expr       { }
;

expr:
    IDENT                    { }
  | PAROUV expr PARFERM      { }
  | expr AND expr            { }
  | expr INF expr            { }
  | expr PLUS expr           { }
;


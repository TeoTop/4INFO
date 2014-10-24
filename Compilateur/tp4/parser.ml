type token =
  | EOL
  | EOF
  | BEGIN
  | END
  | SEMI_COLUMN
  | COMA
  | INT
  | BOOL
  | FLECHE
  | PLUS
  | INF
  | AND
  | PAROUV
  | PARFERM
  | IDENT of (string)

open Parsing;;
let _ = parse_error;;
let yytransl_const = [|
  257 (* EOL *);
    0 (* EOF *);
  258 (* BEGIN *);
  259 (* END *);
  260 (* SEMI_COLUMN *);
  261 (* COMA *);
  262 (* INT *);
  263 (* BOOL *);
  264 (* FLECHE *);
  265 (* PLUS *);
  266 (* INF *);
  267 (* AND *);
  268 (* PAROUV *);
  269 (* PARFERM *);
    0|]

let yytransl_block = [|
  270 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\005\000\006\000\006\000\004\000\
\004\000\007\000\007\000\008\000\008\000\008\000\008\000\008\000\
\000\000"

let yylen = "\002\000\
\002\000\005\000\001\000\003\000\002\000\001\000\001\000\001\000\
\003\000\001\000\003\000\001\000\003\000\003\000\003\000\003\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\017\000\000\000\006\000\007\000\000\000\
\000\000\000\000\001\000\000\000\000\000\005\000\000\000\010\000\
\000\000\000\000\004\000\000\000\002\000\000\000\000\000\012\000\
\000\000\009\000\000\000\000\000\000\000\000\000\013\000\016\000\
\000\000\000\000"

let yydgoto = "\002\000\
\004\000\016\000\008\000\017\000\009\000\010\000\018\000\025\000"

let yysindex = "\004\000\
\024\255\000\000\251\254\000\000\029\000\000\000\000\000\029\255\
\030\255\020\255\000\000\254\254\251\254\000\000\031\255\000\000\
\033\255\034\255\000\000\016\255\000\000\254\254\016\255\000\000\
\008\255\000\000\014\255\016\255\016\255\016\255\000\000\000\000\
\032\255\255\254"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\036\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\039\255\000\000\000\000\000\000\000\000\000\000\000\000\
\028\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\255\003\255"

let yygindex = "\000\000\
\000\000\036\000\030\000\022\000\000\000\000\000\000\000\248\255"

let yytablesize = 44
let yytable = "\003\000\
\006\000\007\000\015\000\015\000\001\000\014\000\014\000\028\000\
\029\000\015\000\015\000\015\000\015\000\014\000\027\000\014\000\
\028\000\029\000\030\000\032\000\033\000\034\000\028\000\029\000\
\030\000\003\000\031\000\023\000\011\000\024\000\011\000\011\000\
\012\000\014\000\013\000\021\000\005\000\022\000\020\000\003\000\
\028\000\008\000\019\000\026\000"

let yycheck = "\002\001\
\006\001\007\001\003\001\004\001\001\000\003\001\004\001\009\001\
\010\001\010\001\011\001\014\001\013\001\011\001\023\000\013\001\
\009\001\010\001\011\001\028\000\029\000\030\000\009\001\010\001\
\011\001\002\001\013\001\012\001\000\000\014\001\003\001\004\001\
\004\001\014\001\005\001\003\001\001\000\004\001\008\001\004\001\
\009\001\003\001\013\000\022\000"

let yynames_const = "\
  EOL\000\
  EOF\000\
  BEGIN\000\
  END\000\
  SEMI_COLUMN\000\
  COMA\000\
  INT\000\
  BOOL\000\
  FLECHE\000\
  PLUS\000\
  INF\000\
  AND\000\
  PAROUV\000\
  PARFERM\000\
  "

let yynames_block = "\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'bloc) in
    Obj.repr(
# 21 "parser.mly"
           ( )
# 124 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'sdecl) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'sinst) in
    Obj.repr(
# 25 "parser.mly"
                                      ( )
# 132 "parser.ml"
               : 'bloc))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'decl) in
    Obj.repr(
# 29 "parser.mly"
                        ( )
# 139 "parser.ml"
               : 'sdecl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'decl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'sdecl) in
    Obj.repr(
# 30 "parser.mly"
                     ( )
# 147 "parser.ml"
               : 'sdecl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'tipe) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 35 "parser.mly"
                        ( )
# 155 "parser.ml"
               : 'decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "parser.mly"
          ( )
# 161 "parser.ml"
               : 'tipe))
; (fun __caml_parser_env ->
    Obj.repr(
# 41 "parser.mly"
          ( )
# 167 "parser.ml"
               : 'tipe))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'inst) in
    Obj.repr(
# 46 "parser.mly"
          ( )
# 174 "parser.ml"
               : 'sinst))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'inst) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'sinst) in
    Obj.repr(
# 47 "parser.mly"
                            ( )
# 182 "parser.ml"
               : 'sinst))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bloc) in
    Obj.repr(
# 52 "parser.mly"
          ( )
# 189 "parser.ml"
               : 'inst))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 53 "parser.mly"
                            ( )
# 197 "parser.ml"
               : 'inst))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 57 "parser.mly"
                             ( )
# 204 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 58 "parser.mly"
                             ( )
# 211 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 59 "parser.mly"
                             ( )
# 219 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 60 "parser.mly"
                             ( )
# 227 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 61 "parser.mly"
                             ( )
# 235 "parser.ml"
               : 'expr))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : unit)

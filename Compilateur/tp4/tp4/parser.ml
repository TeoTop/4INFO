type token =
  | SET
  | WALK
  | ROTATE
  | LEFT
  | RIGHT
  | CIRCLE
  | WITH
  | DIAMETER
  | POSITION
  | LP
  | RP
  | COMMA
  | SEMICOLON
  | AFFECT
  | MULT
  | PLUS
  | DIV
  | MINUS
  | EOF
  | INT of (int)
  | IDENT of (string)

open Parsing;;
let _ = parse_error;;
# 6 "parser.mly"
  open Ast
# 29 "parser.ml"
let yytransl_const = [|
  257 (* SET *);
  258 (* WALK *);
  259 (* ROTATE *);
  260 (* LEFT *);
  261 (* RIGHT *);
  262 (* CIRCLE *);
  263 (* WITH *);
  264 (* DIAMETER *);
  265 (* POSITION *);
  266 (* LP *);
  267 (* RP *);
  268 (* COMMA *);
  269 (* SEMICOLON *);
  270 (* AFFECT *);
  271 (* MULT *);
  272 (* PLUS *);
  273 (* DIV *);
  274 (* MINUS *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  275 (* INT *);
  276 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\003\000\003\000\003\000\
\005\000\005\000\004\000\004\000\004\000\004\000\004\000\004\000\
\000\000"

let yylen = "\002\000\
\001\000\001\000\003\000\004\000\002\000\003\000\004\000\007\000\
\001\000\001\000\001\000\001\000\003\000\003\000\003\000\003\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\017\000\001\000\
\000\000\000\000\000\000\012\000\011\000\000\000\009\000\010\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\003\000\000\000\000\000\014\000\000\000\
\016\000\000\000\000\000\000\000\000\000\008\000"

let yydgoto = "\002\000\
\007\000\008\000\009\000\014\000\017\000"

let yysindex = "\255\255\
\034\255\000\000\253\254\010\255\041\255\000\255\000\000\000\000\
\247\254\011\255\024\255\000\000\000\000\026\255\000\000\000\000\
\010\255\031\255\034\255\010\255\010\255\010\255\010\255\010\255\
\010\255\026\255\010\255\000\000\016\255\026\255\000\000\005\255\
\000\000\005\255\026\255\010\255\008\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\047\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\003\000\000\000\000\000\000\000\005\000\000\000\001\000\
\000\000\009\000\010\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\029\000\000\000\247\255\000\000"

let yytablesize = 283
let yytable = "\001\000\
\013\000\005\000\006\000\019\000\004\000\010\000\018\000\026\000\
\015\000\007\000\029\000\030\000\031\000\032\000\033\000\034\000\
\011\000\035\000\038\000\022\000\020\000\024\000\022\000\023\000\
\024\000\025\000\037\000\036\000\012\000\013\000\022\000\023\000\
\024\000\025\000\003\000\004\000\005\000\021\000\027\000\006\000\
\022\000\023\000\024\000\025\000\015\000\016\000\002\000\028\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\013\000\013\000\013\000\005\000\006\000\
\013\000\004\000\013\000\015\000\015\000\015\000\007\000\000\000\
\015\000\000\000\015\000"

let yycheck = "\001\000\
\000\000\000\000\000\000\013\001\000\000\009\001\007\001\017\000\
\000\000\000\000\020\000\021\000\022\000\023\000\024\000\025\000\
\020\001\027\000\011\001\015\001\010\001\017\001\015\001\016\001\
\017\001\018\001\036\000\012\001\019\001\020\001\015\001\016\001\
\017\001\018\001\001\001\002\001\003\001\014\001\008\001\006\001\
\015\001\016\001\017\001\018\001\004\001\005\001\000\000\019\000\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\011\001\012\001\013\001\013\001\013\001\
\016\001\013\001\018\001\011\001\012\001\013\001\013\001\255\255\
\016\001\255\255\018\001"

let yynames_const = "\
  SET\000\
  WALK\000\
  ROTATE\000\
  LEFT\000\
  RIGHT\000\
  CIRCLE\000\
  WITH\000\
  DIAMETER\000\
  POSITION\000\
  LP\000\
  RP\000\
  COMMA\000\
  SEMICOLON\000\
  AFFECT\000\
  MULT\000\
  PLUS\000\
  DIV\000\
  MINUS\000\
  EOF\000\
  "

let yynames_block = "\
  INT\000\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'linstr) in
    Obj.repr(
# 30 "parser.mly"
              (  )
# 205 "parser.ml"
               : Ast.prog))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 34 "parser.mly"
                          ( )
# 212 "parser.ml"
               : 'linstr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'instr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'linstr) in
    Obj.repr(
# 35 "parser.mly"
                          ( )
# 220 "parser.ml"
               : 'linstr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                                     ( )
# 228 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "parser.mly"
                                     ( )
# 235 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'dir) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "parser.mly"
                                     ( )
# 243 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                                     ( )
# 250 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                                     ( )
# 258 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "parser.mly"
       ( )
# 264 "parser.ml"
               : 'dir))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "parser.mly"
        ( )
# 270 "parser.ml"
               : 'dir))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 52 "parser.mly"
                  ( )
# 277 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 53 "parser.mly"
                  ( )
# 284 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 54 "parser.mly"
                  ( )
# 292 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 55 "parser.mly"
                  ( )
# 300 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 56 "parser.mly"
                  ( )
# 308 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 57 "parser.mly"
                  ( )
# 316 "parser.ml"
               : 'expr))
(* Entry parse_prog *)
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
let parse_prog (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.prog)

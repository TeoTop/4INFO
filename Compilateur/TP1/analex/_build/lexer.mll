{
  open Ulex (* Ulex contains the type definition of lexical units *)
}

rule token = parse (* TODO *)
   | [' ' '\t' '\n']     { token lexbuf } (* lexbuf : buffer *)
   | "/*" ([^'*'] | '*'+ [^'/'])* '*'+'/' { token lexbuf } (* commentaires *)
   | eof     { UL_EOF  }
   | '('     { UL_PAROUV }
   | ')'     { UL_PARFERM }
   | '='     { UL_EGAL }
   | "<>"    { UL_DIFF }
   | '<'     { UL_INF  }
   | '>'     { UL_SUP  }
   | "et"    { UL_ET   }
   | "ou"    { UL_OU   }
   | "si"    { UL_SI   }
   | "sinon" { UL_SINON  }
   | "fsi"   { UL_FSI   }
   | ">="    { UL_SUPEG   }
   | "<="    { UL_INFEG   }
   | ['A'-'Z' 'a'-'z'] ['A'-'Z' 'a'-'z' '0'-'9' '_'] * as ident {UL_IDENT ident}



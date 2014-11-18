let test x = 
  let tokens = scanner x in
  List.iter (fun tk -> Printf.fprintf stdout "Token: %a\n" Ulex.print_token tk) tokens ;
  Printf.printf "DONE\n"

let test1 = "jojo et /* commentaires */) cheval = sinon (";;
Printf.printf "TEST 1:\n";;
test (Lexing.from_string test1);;


let test2 = "si x=un alors y=deux sinon z=trois";;
Printf.printf "TEST 2:\n";;
test (Lexing.from_string test2);;

let test3 = "/** comm ** entaire/// ****/";;
Printf.printf "TEST 3:\n";;
test (Lexing.from_string test3);;

let test4 = "Le ciel est bleu /* NE PAS CONFONDRE AVEC LA MER */";;
Printf.printf "TEST 4:\n";;
test (Lexing.from_string test4);;

let test5 = "Mille millions de mille a";;
Printf.printf "TEST 5:\n";;
test (Lexing.from_string test5);;

let test6 = "si x=deux et y=trois /*abscisse ordonnee*/ alors z=un ou z=cinq sinon si z=deux alors echo test fsi fsi";;
Printf.printf "TEST 6:\n";;
test (Lexing.from_string test6);;

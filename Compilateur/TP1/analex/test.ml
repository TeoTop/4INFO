let test1 = "jojo et /* commentaires */) cheval = sinon (";;
test test1;;

let test2 = "si x=1 alors y=2 sinon z=3";;
test test2;;

let test3 = "/** comm ** entaire/// ****/";;
test test3;;

let test4 = "Le ciel est bleu /* NE PAS CONFONDRE AVEC LA MER */";;
test test4;;


let test5 = "Mille millions de mile @@'$£$*$~";;
test test5;;

let test x = 
  let tokens = scanner_list x in
  List.iter (fun tk -> Printf.fprintf stdout "Token: %a\n" Ulex.print_token tk) tokens ;
  Printf.printf "DONE\n"

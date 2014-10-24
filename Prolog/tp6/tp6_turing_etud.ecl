
%%%%%%%%%%% First part

copy_prog(program(
                     start, 
                     [stop], 
                     [delta(start, ' ', ' ', right, stop),
                      delta(start, 1, ' ', right, s2),
                      delta(s2, 1, 1, right, s2),
                      delta(s2, ' ', ' ', right, s3),
                      delta(s3, 1, 1, right, s3),
                      delta(s3, ' ', 1, left, s4),
                      delta(s4, 1, 1, left, s4),
                      delta(s4, ' ', ' ', left, s5),
                      delta(s5, 1, 1, left, s5),
                      delta(s5, ' ', 1, right, start)
                     ]
                 )
         ).

initial_state(program(InitialState, _, _), InitialState).

final_states(program(_, FinalStates, _), FinalStates).

transitions(program(_, _, Deltas), Deltas).


%write to meta post format
%compile result with: 
% mpost filename
% epstopdf filename.1
dump_to_mpost(Filename, Dump) :-
        open(Filename, append, Stream),
	        write_header(Stream),
        write_dump(0, Dump, Stream),
        write_end(Stream),
        close(Stream).

write_header(Stream) :-
        write(Stream, 'prologues := 1;\n'),
        write(Stream, 'input turing;\n'),
        write(Stream, 'beginfig(1)\n').

write_end(Stream) :-
        write(Stream, 'endfig;\n'),
        write(Stream, 'end').

write_dump(_, [], _).
write_dump(Y, [(State, Tape) | Tapes], Stream) :-
        write(Stream, 'tape(0, '),
        write(Stream, Y),
        write(Stream, 'cm, 1cm, \"'),
        write(Stream, State),
        write(Stream, '\", '),
        write_tape(Tape, Stream),
        write(Stream, ');\n'),
        Y1 is Y - 2,
        write_dump(Y1, Tapes, Stream).

write_tape(tape(Left, Right), Stream) :-
        length(Left, N),
        write(Stream, '\"'),
        append(Left, Right, L),
        (param(Stream), foreach(X, L) do 
            write(Stream, X)        
        ),
        write(Stream, '\", '),
        write(Stream, N),
        write('\n').
/*
["~/4INFO/Prolog/tp6/tp6_turing_etud.ecl"].
*/
/*
  Question 1.1 : next permet de faire une transition d'un état à un autre
*/
next(Program, State0, Symbole0, Symbole1, Dir, State1):-transitions(Program, Deltas),compare(Deltas, State0, Symbole0, Symbole1, Dir, State1).

compare([delta(State0,Symbole0,Symbole1,Dir,State1)|Deltas], State0, Symbole0, Symbole1, Dir, State1).
compare([delta(St0,S0,S1,Direction,St1)|Deltas], State0, Symbole0, Symbole1, Dir, State1):- \==(St0,State0),compare(Deltas, State0, Symbole0, Symbole1, Dir, State1).
compare([delta(St0,S0,S1,Direction,St1)|Deltas], State0, Symbole0, Symbole1, Dir, State1):- \==(S0,Symbole0),compare(Deltas, State0, Symbole0, Symbole1, Dir, State1).

/*
  Question 1.2 : update_tape : mettre à jour la bande de la machine
*/
update_tape(tape(Left,[_]), Symb, right, tape(L, [' '])):-append(Left,[Symb],L).
update_tape(tape(Left,[_|Right]), Symb, right, tape(L, Right)):-append(Left,[Symb],L).
update_tape(tape(Left,[_|Right]), Symb, left, tape(L, R)):- insert(Symb,Right,R1), deplacer(Left,R1,L,R).

insert(Symb,Right,[Symb|Right]).

deplacer([A],R1,[],[A|R1]).
deplacer([A|Left],R1,[A|L],R):- deplacer(Left,R1,L,R).

/*
  Question 1.3 : Executer le programme avec input comme symbole d'entrée
*/
run_turing_machine(Program, [Symb|Input], Output, FinalState):-initial_state(Program, InitialState),next(Program,InitialState,Symb,Symb1,Dir,State1),update_tape(tape([' '],[Symb|Input]), Symb1, Dir, tape(Left,Right)),run_turing_machine_rec(Program,Left,Right,State1,Output,FinalState),!.

run_turing_machine_rec(Program, Left, Right, State0, Output, State0):-final_states(Program, FinalStates),member(State0,FinalStates),append(Left,Right,Output).

run_turing_machine_rec(Program, Left, [Symb|Input], State0, Output, FinalState):- next(Program,State0,Symb,Symb1,Dir,State1), update_tape(tape(Left,[Symb|Input]),Symb1,Dir,tape(Left1,Right1)),run_turing_machine_rec(Program,Left1,Right1,State1,Output,FinalState).

/*
  Question 1.4 : produire une liste représentant les différentes étapes de l'exécution de la machine de turing
*/
run_turing_machine(Program, [Symb|Input], Output, FinalState, Dump):-initial_state(Program, InitialState),next(Program,InitialState,Symb,Symb1,Dir,State1),update_tape(tape([' '],[Symb|Input]), Symb1, Dir, tape(Left,Right)),
append_strings("turing","0",Name), dump_to_mpost(Name,[(State0,tape([' '],[Symb|Input]))]),
run_turing_machine_rec(Program,Left,Right,State1,Output,FinalState, Dump, 1),!.

run_turing_machine_rec(Program, Left, Right, State0, Output, State0, Dump, Nb):- final_states(Program, FinalStates),member(State0,FinalStates),
 number_string(Nb,Nb_str), append_strings("turing",Nb_str,Name), dump_to_mpost(Name,[(State0,tape(Left,Right))]),
append(Left,Right,Output).


run_turing_machine_rec(Program, Left, [Symb|Input], State0, Output, FinalState, Dump, Nb):-
 next(Program,State0,Symb,Symb1,Dir,State1), update_tape(tape(Left,[Symb|Input]),Symb1,Dir,tape(Left1,Right1)), number_string(Nb,Nb_str), append_strings("turing",Nb_str,Name), dump_to_mpost(Name,[(State0,tape(Left,[Symb|Input]))]), Nb1 is Nb + 1, run_turing_machine_rec(Program,Left1,Right1,State1,Output,FinalState,Dump, Nb1).



/*
%Question 1.1
  copy_prog(Program),next(Program,start,1,NewS,Dir,NextSt).
    Program = program(start, [stop], [delta(start, ' ', ' ', right, stop), delta(start, 1, ' ', right, s2), delta(s2, 1, 1, right, s2), delta(s2, ' ', ' ', right, s3), delta(s3, 1, 1, right, s3), delta(s3, ' ', 1, left, s4), delta(s4, 1, 1, left, s4), delta(s4, ' ', ' ', left, s5), delta(s5, 1, 1, left, s5), delta(s5, ' ', 1, right, start)])
    NewS = ' '
    Dir = right
    NextSt = s2
    Yes (0.00s cpu, solution 1, maybe more)

%Question 1.2
  update_tape(tape([' '],[1,' ']),' ',right,UpdatedTape).
    UpdatedTape = tape([' ', ' '], [' '])
    Yes (0.00s cpu)
  update_tape(tape([' ',' ',' '],[' ']),1,left,UpdatedTape).
    UpdatedTape = tape([' ', ' '], [' ', 1])
    Yes (0.00s cpu)

%Question 1.3
  copy_prog(P),run_turing_machine(P,[1],Output,FinalState).
    P = program(start, [stop], [delta(start, ' ', ' ', right, stop), delta(start, 1, ' ', right, s2), delta(s2, 1, 1, right, s2), delta(s2, ' ', ' ', right, s3), delta(s3, 1, 1, right, s3), delta(s3, ' ', 1, left, s4), delta(s4, 1, 1, left, s4), delta(s4, ' ', ' ', left, s5), delta(s5, 1, 1, left, s5), delta(s5, ' ', 1, right, start)])
    Output = [' ', 1, ' ', 1]
    FinalState = stop
    Yes (0.00s cpu) 

%Question 1.4
*/
%%%%%%%%%%% Optional part        

%make_pairs(+, -): 'a list * ('a * 'a) list
make_pairs([], _, []).
make_pairs([X | L], L2, Res) :-
        make_pairs_aux(X, L2, Pairs),
        make_pairs(L, L2, RemainingPairs),
        append(Pairs, RemainingPairs, Res).

%make_pairs_aux(+, +, -): 'a * 'a list * ('a * 'a) list
make_pairs_aux(_, [], []).
make_pairs_aux(X, [Y | Ys], [(X, Y) | Zs]) :-
        make_pairs_aux(X, Ys, Zs).

complete(S1, Sym, Symbols, Directions, States, Res) :-
        member(Sym1, Symbols),
        member(Dir, Directions),
        member(S2, States),
        Res = delta(S1, Sym, Sym1, Dir, S2).

complete_list([], _, _, _, []).
complete_list([(S, Sym) | Pairs], Symbols, Directions, States, [Delta | Deltas]) :-
        complete(S, Sym, Symbols, Directions, States, Delta),
        complete_list(Pairs, Symbols, Directions, States, Deltas).

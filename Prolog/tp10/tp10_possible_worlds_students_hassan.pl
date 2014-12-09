% dana likes cody
% bess does not like dana
% cody does not like abby
% nobody likes someone who does not like her
% abby likes everyone who likes bess
% dana likes everyone bess likes
% everybody likes somebody
/*
["~/4INFO/4INFO/Prolog/tp10/tp10_possible_worlds_students_hassan.pl"].
*/
people([abby, bess, cody, dana, peter]).

likes(dana, cody).
likes(bess, cody).
likes(bess, abby).
likes(abby, bess).
likes(abby, cody).

%----------- Question 1 ------------
% Retourne toutes les pairs d'élèment du tableau possibles 
make_all_pairs([], []).
make_all_pairs([X|L], [likes(X,X)|Res]):- combin(X, L, R1), make_all_pairs(L, Res1), append(R1, Res1, Res).
combin(_, [], []).
combin(X, [Y|L], [likes(X,Y),likes(Y,X)|R]):- combin(X, L, R).

%----------- Question 2 ------------
% Retourne une par une les sous tableau possible
/*sub_list(L, L). 
sub_list([X|_], [X]).
sub_list([_|L], Res):- sub_list(L, Res).*/
sub_list([],[]).
sub_list([X|L],[X|L2]):-sub_list(L,L2).
sub_list([_|L],L2):-sub_list(L,L2). 

%----------- Question 3 ------------
%Ecrire les 7 prédicats représentant les 7 propositions
%aux
find(X, [X|L], L).
find(X, [Y|L], [Y|L1]):- \==(X, Y), find(X, L, L1).

include([],_).
include([X|L1], L2):- find(X, L2, LRes), include(L1, LRes).

% dana likes cody
proposition1([likes(dana, cody)|_]):-!.
proposition1([_|L]):-proposition1(L).

% bess does not like dana
proposition2([]).
proposition2([X|L]):- \==(X, likes(bess, dana)), proposition2(L).

% cody does not like abby
proposition3([]).
proposition3([X|L]):- \==(X, likes(cody, abby)), proposition3(L).

% nobody likes someone who does not like her
proposition4([]).
proposition4([likes(X, Y)|L]):- \==(X, Y), find(likes(Y, X), L, L1), !, proposition4(L1).
proposition4([likes(X, X)|L]):- proposition4(L).
proposition4([likes(_, _)|_]):- fail.


% abby likes everyone who likes bess
/*proposition5([]).
proposition5([likes(X, bess)|L]):- \==(X, abby), find(likes(abby, X), L, _), !, proposition5(L).
proposition5([likes(_, bess)|_]):- fail.
proposition5([likes(abby, bess)|L]):- proposition5(L).
proposition5([likes(_, Y)|L]):- \==(Y, bess), proposition5(L).*/

proposition5(L) :- proposition5a(L,L).
proposition5a([],_).
proposition5a([likes(X,bess)|L],La) :- member(likes(abby,X),La), proposition5a(L,La).
proposition5a([likes(_,Y)|L],La) :- \==(Y,bess), proposition5a(L,La).
% dana likes everyone bess likes
proposition6([]).
proposition6([likes(bess, X)|L]):- find(likes(dana, X), L, _), !, proposition6(L).
proposition6([likes(bess, _)|_]):- fail.
proposition6([likes(Y, _)|L]):- \==(Y, bess), proposition6(L).

% everybody likes somebody
/*proposition7(L):- proposition7_bis(L, People), people(People1), include(People1, People), !.
proposition7_bis([], []).
proposition7_bis([likes(X, Y)|L], [X|People]):- \==(X, Y), proposition7_bis(L, People).*/


proposition7(L) :- people(Lp), proposition7a(Lp,L).
proposition7a([],_).
proposition7a([X|L],La) :- member(likes(X,_),La), proposition7a(L,La),!.

%----------- Question 4 ------------
% Réussi autant de fois qu'il existe de monde possible selon les propositions
possible_worlds(W):- people(People), make_all_pairs(People, W1), sub_list(W1, W)
, proposition4(W)
, proposition5(W)
, proposition6(W)
, proposition1(W)
, proposition3(W)
, proposition2(W)
, proposition7(W)
.
		
%----------- Question 5 ------------
test_possible_worlds:- possible_worlds(World), writeln(World), fail.		

%----------- Question 6 ------------

coverage:ccompile("~/4INFO/4INFO/Prolog/tp10/tp10_possible_worlds_students_hassan.pl").
test_possible_worlds.
coverage:result("~/4INFO/4INFO/Prolog/tp10/tp10_possible_worlds_students_hassan").


/*------------- Test ---------------

-------------Question 1 --------------
make_all_pairs([1,2], Res).
	Res = [likes(1, 1), likes(1, 2), likes(2, 1), likes(2, 2)]
	Yes (0.00s cpu)

-------------Question 2 --------------
sub_list([1,2], Res).
        Res = [1, 2]
        Yes
        Res = [1]
        Yes
        Res = [2]
        Yes
        Res = []
        Yes (0.00s cpu, solution 4)

-------------Question 3 --------------

%dana aime cody
proposition1([likes(cody,dana), likes(dana,dana)]).
        No (0.00s cpu)

proposition1([likes(cody,dana), likes(dana,cody)]).
        Yes (0.00s cpu) 


%bess n'aime pas dana
proposition2([likes(bess,dana), likes(dana,cody)]).
        No (0.00s cpu)
proposition2([likes(bess,cody), likes(dana,cody)]).
        Yes (0.00s cpu)


%cody n'aime pas abby
proposition3([likes(cody,abby), likes(dana,cody)]).
        No (0.00s cpu)
proposition3([likes(cody,dana), likes(dana,cody)]).
        Yes (0.00s cpu)


%Personne n'aime quelqu'un qui ne l'aime pas (a modifier si member marche)
proposition4([likes(cody,dana), likes(dana,cody), likes(abby,bess)]).
        No (0.00s cpu)
proposition4([likes(cody,dana), likes(dana,cody), likes(abby,bess), likes(bess,abby)]).
        Yes (0.00s cpu, solution 1, maybe more) ? ;
        No (0.00s cpu)


%Abby aime tous ceux qui aime Bess
proposition5([likes(cody,bess), likes(dana,bess), likes(abby,cody), likes(abby,dana)]).
        Yes (0.00s cpu)

proposition5([likes(cody,bess), likes(dana,bess), likes(abby,cody), likes(abby,bess)]).
        No (0.00s cpu)

proposition5([likes(cody,bess), likes(dana,bess), likes(abby,cody)]).
        No (0.00s cpu)


%Dana aime tous ceux que Bess aime
proposition6([likes(bess,cody), likes(dana,cody), likes(bess,abby), likes(dana,abby)]).
        Yes (0.00s cpu)

proposition6([likes(bess,cody), likes(dana,cody), likes(bess,abby)]).
        No (0.00s cpu)

proposition6([likes(bess,cody), likes(dana,cody), likes(bess,abby), likes(dana,bess)]).
        No (0.00s cpu)


%Tout le monde aime quelqu'un
proposition7([likes(bess,cody), likes(dana,cody), likes(cody,abby), likes(abby,dana)]).
Yes (0.00s cpu)

proposition7([likes(bess,cody), likes(dana,cody), likes(cody,abby), likes(cody,dana)]).
        No (0.00s cpu)

proposition7([]).
        No (0.00s cpu)


-------------Question 4 --------------

possible_worlds(Monde).

        Monde = [likes(abby, abby), likes(abby, bess), likes(abby, dana), likes(bess, abby), likes(cody, cody), likes(cody, dana), likes(dana, abby), likes(dana, cody), likes(dana, dana)]
        Yes (0.02s cpu, solution 1, maybe more) ? ;

        Monde = [likes(abby, abby), likes(abby, bess), likes(abby, dana), likes(bess, abby), likes(cody, cody), likes(cody, dana), likes(dana, abby), likes(dana, cody)]
        Yes (0.02s cpu, solution 2, maybe more) ? ;

        Monde = [likes(abby, abby), likes(abby, bess), likes(abby, dana), likes(bess, abby), likes(cody, dana), likes(dana, abby), likes(dana, cody), likes(dana, dana)]
        Yes (0.02s cpu, solution 3, maybe more) ? ;

        Monde = [likes(abby, abby), likes(abby, bess), likes(abby, dana), likes(bess, abby), likes(cody, dana), likes(dana, abby), likes(dana, cody)]
        Yes (0.02s cpu, solution 4, maybe more) ? ;

        No (0.06s cpu)
-------------Question 5 --------------
test_possible_worlds.
[likes(abby, abby), likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(cody, cody), likes(cody, dana), likes(dana, cody), likes(dana, dana)]
[likes(abby, abby), likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(cody, cody), likes(cody, dana), likes(dana, cody)]
[likes(abby, abby), likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(cody, dana), likes(dana, cody), likes(dana, dana)]
[likes(abby, abby), likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(cody, dana), likes(dana, cody)]

No (0.21s cpu)
-------------Question 6 --------------

coverage:ccompile("~/4INFO/4INFO/Prolog/tp10/tp10_possible_worlds_students_hassan.pl").
        WARNING: module 'coverage' does not exist, loading library...
        source_processor.eco loaded in 0.00 seconds
        module_options.eco loaded in 0.00 seconds
        hash.eco   loaded in 0.00 seconds
        document.eco loaded in 0.01 seconds
        pretty_printer.eco loaded in 0.01 seconds
        coverage.eco loaded in 0.01 seconds
        compiler_common.eco loaded in 0.00 seconds
        compiler_normalise.eco loaded in 0.01 seconds
        compiler_map.eco loaded in 0.00 seconds
        compiler_analysis.eco loaded in 0.00 seconds
        compiler_peephole.eco loaded in 0.00 seconds
        compiler_codegen.eco loaded in 0.01 seconds
        compiler_varclass.eco loaded in 0.00 seconds
        compiler_indexing.eco loaded in 0.00 seconds
        compiler_regassign.eco loaded in 0.01 seconds
        asm.eco    loaded in 0.00 seconds
        ecl_compiler.eco loaded in 0.03 seconds
        coverage: inserted 91 coverage counters into module eclipse
        4INFO/4INFO/Prolog/tp10/tp10_possible_worlds_students_hassan.pl compiled 1917712 bytes in 0.04 seconds

        Yes (0.05s cpu)
test_possible_worlds.
        [likes(abby, abby), likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(cody, cody), likes(cody, dana), likes(dana, cody), likes(dana, dana)]
        [likes(abby, abby), likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(cody, cody), likes(cody, dana), likes(dana, cody)]
        [likes(abby, abby), likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(cody, dana), likes(dana, cody), likes(dana, dana)]
        [likes(abby, abby), likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(cody, dana), likes(dana, cody)]
        No (0.21s cpu)

coverage:result("~/4INFO/4INFO/Prolog/tp10/tp10_possible_worlds_students_hassan").
        Writing /home-reseau/helomari/4INFO/4INFO/Prolog/tp10/coverage/tp10_possible_worlds_students_hassan.html
        Yes (0.01s cpu)


*/
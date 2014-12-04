% dana likes cody
% bess does not like dana
% cody does not like abby
% nobody likes someone who does not like her
% abby likes everyone who likes bess
% dana likes everyone bess likes
% everybody likes somebody

%["~/4INFO/Prolog/tp10/tp10_possible_worlds_students.pl"].

people([abby, bess, cody, dana]).

likes(dana, cody).
likes(bess, cody).
likes(bess, abby).
likes(abby, bess).
likes(abby, cody).

%----------- Question 1 ------------
% Retourne toutes les pairs d'élèment du tableau possibles 

make_all_pairs(L,R):-make_all_pairs2(L,L,R).

make_all_pairs2([],_,[]).
make_all_pairs2([X|L],Lp,R):- make_all_pairs3(X, Lp,L2), make_all_pairs2(L,Lp,L3), append(L2,L3,R).

make_all_pairs3(_,[],[]).
make_all_pairs3(X,[Y|L],[likes(X,Y)|L2]):-make_all_pairs3(X,L,L2).


%----------- Question 2 ------------
% Retourne une par une les sous tableau possible
sub_list([],[]).
sub_list([X|L],[X|L2]):-sub_list(L,L2).
sub_list([_|L],L2):-sub_list(L,L2). 


%----------- Question 3 ------------
%Ecrire les 7 prédicats représentant les 7 propositions
%dana aime cody
proposition1(L):-member(likes(dana,cody),L).

%bess n'aime pas dana
proposition2(L):-not(member(likes(bess,dana),L)).

%cody n'aime pas abby
proposition3(L):-not(member(likes(cody,abby),L)).

%Personne n'aime quelqu'un qui ne l'aime pas (a modifier si member marche)
proposition4(L):-proposition4a(L,L).
proposition4a([],_).
proposition4a([likes(X,Y)|L],La):- member(likes(Y,X),La), proposition4a(L,La).


%Abby aime tous ceuw qui aime Bess
proposition5(L) :- proposition5a(L,L).
proposition5a([],_).
proposition5a([likes(X,bess)|L],La) :- member(likes(abby,X),La), proposition5a(L,La).
proposition5a([likes(_,Y)|L],La) :- \==(Y,bess), proposition5a(L,La).

%Dana aime tous ceux que Bess aime
proposition6(L):- proposition6a(L,L).
proposition6a([],_).
proposition6a([likes(bess,X)|L],La) :- member(likes(dana,X),La), proposition6a(L,La).
proposition6a([likes(Y,_)|L],La) :- \==(Y,bess), proposition6a(L,La).

%Tout le monde aime quelqu'un
proposition7(L) :- people(Lp), proposition7a(Lp,L).
proposition7a([],_).
proposition7a([X|L],La) :- member(likes(X,_),La), proposition7a(L,La),!.


%----------- Question 4 ------------
% Réussi autant de fois qu'il existe de monde possible selon les propositions
possible_worlds(Monde) :- people(Lp), make_all_pairs(Lp,Paire), sub_list(Paire,Monde), proposition1(Monde), proposition2(Monde),  proposition3(Monde),proposition4(Monde), proposition5(Monde), proposition6(Monde), proposition7(Monde).

		
%----------- Question 5 ------------
		

%----------- Question 6 & 7 ------------
test_possible_worlds :-
        possible_worlds(World), writeln(World), fail.


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

*/
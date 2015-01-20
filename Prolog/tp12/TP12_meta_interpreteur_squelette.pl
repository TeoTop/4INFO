% ======================================================================== 
%        QUESTION 2.4 : dynamic
% ========================================================================
:- dynamic(enfant/1).
:- dynamic(age/2).
:- dynamic(pere/2).
:- dynamic(parent/2).
:- dynamic(my_append/3).

enfant(e2).
enfant(e1).
age(e2,10).
age(e1,12).
age(p1,43).
pere(p1,e1).
pere(p1,e2).
parent(X,Y):-pere(X,Y).

built_in(read(_)).
built_in(writeln(_)).

my_append([],Ys,Ys).
my_append([X|Xs],Ys,[X|Zs]):-
	writeln(X),
	my_append(Xs,Ys,Zs).

% ======================================================================== 
%        QUESTION 2.1 : solve0_v1
% ========================================================================
solve0_v1(A):-A.

% ======================================================================== 
%        QUESTION 2.2 : solve0
% ========================================================================


% ======================================================================== 
%        QUESTION 2.9 : solve1_1
% ========================================================================
solve1_1(true):- !.
solve1_1(A):- clause(A, Body), solve1_1(Body).

% ======================================================================== 
%        QUESTION 2.11 : solve1_2
% ========================================================================
solve1_2(true):- !.
solve1_2((A,B)):- built_in(A), !, solve1_2(B).
solve1_2(A):- clause(A, Body), solve1_2(Body).

% ======================================================================== 
%        QUESTION 2.12 : solve2_1
% ========================================================================
solve2_1(true, [true]):- !.
solve2_1((A,B), [A,builtin|Branch]):- built_in(A), !, solve2_1(B, Branch).
solve2_1(A, [A|Branch]):- clause(A, Body), solve2_1(Body, Branch).


% ======================================================================== 
%        QUESTION 2.14 : solve2_2
% ========================================================================
solve2_2(true, [true]):- !.
solve2_2((A,B), [A,builtin|Branch]):- built_in(A), !, solve2_2(B, Branch).
solve2_2(A, [A|Branch]):- clause(A, Body), solve2_2(Body, Branch).
solve2_2(A, [A,echec]):- not(clause(A, _)).


% ======================================================================== 
%        Boucle d interprétation
% ========================================================================

result(X):-
	solve1_2(X),
	write("\n\tResult: "),
	writeln(X),
	more.

result(_):-
	writeln("\tNo more solutions").

more:-
	write("\t(more_solutions ?) "),
	read(yes),!,fail
	.
more.

my_top:-
	write("\n\t[my_toplevel]: "),
	read(X),
	result(X),
	my_top.

/*
% ======================================================================== 
%        QUESTION 2.1 : solve0_v1
% ========================================================================
solve0_v1(enfant(X)).

X = e2
Yes (0.00s cpu, solution 1, maybe more) ? ;

X = e1
Yes (0.00s cpu, solution 2)
% ======================================================================== 
%        QUESTION 2.2 : solve0
% ========================================================================
C'est Prolog qui est appelé

% ======================================================================== 
%        QUESTION 2.3 : clause
% ========================================================================
procedure not dynamic in clause(parent(X, Y), Z) in module eclipse
Abort


% ======================================================================== 
%        QUESTION 2.9 et 10 : solve1_1
% ========================================================================
accessing a procedure defined in another module in clause((writeln(a), my_append(Xs, Y, [b, c])), _228)
Abort


% ======================================================================== 
%        QUESTION 2.11 : solve1_2
% ========================================================================
solve1_2(my_append(X,Y,[a,b,c])).
	X = []
	Y = [a, b, c]
	Yes (0.00s cpu, solution 1, maybe more)

	X = [a]
	Y = [b, c]
	Yes (0.00s cpu, solution 2, maybe more)

	X = [a, b]
	Y = [c]
	Yes (0.00s cpu, solution 3, maybe more)

	X = [a, b, c]
	Y = []
	Yes (0.00s cpu, solution 4)


% ======================================================================== 
%        QUESTION 2.12 : solve2_1 succès
% ========================================================================
solve2_1(my_append(X,Y,[a,b,c]), Branch).
	X = []
	Y = [a, b, c]
	Branch = [my_append([], [a, b, c], [a, b, c]), true]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	X = [a]
	Y = [b, c]
	Branch = [my_append([a], [b, c], [a, b, c]), writeln(a), builtin, my_append([], [b, c], [b, c]), true]
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	X = [a, b]
	Y = [c]
	Branch = [my_append([a, b], [c], [a, b, c]), writeln(a), builtin, my_append([b], [c], [b, c]), writeln(b), builtin, my_append([], [c], [c]), true]
	Yes (0.00s cpu, solution 3, maybe more) ? ;

	X = [a, b, c]
	Y = []
	Branch = [my_append([a, b, c], [], [a, b, c]), writeln(a), builtin, my_append([b, c], [], [b, c]), writeln(b), builtin, my_append([c], [], [c]), writeln(c), builtin, my_append([], [], []), true]
	Yes (0.00s cpu, solution 4)

% ======================================================================== 
%        QUESTION 2.13 : solve2_1 echec
% ========================================================================
solve2_1(my_append([a,c],B,[a,b,c]), Branch).
	No (0.00s cpu)
% ======================================================================== 
%        QUESTION 2.14 : solve2_2
% ========================================================================
solve2_2(my_append([a,c],B,[a,b,c]), Branch).
	B = B
	Branch = [my_append([a, c], B, [a, b, c]), writeln(a), builtin, my_append([c], B, [b, c]), echec]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	No (0.00s cpu)


% ======================================================================== 
%        Boucle d interprétation
% ========================================================================
my_top.

	[my_toplevel]:  enfant(X).

	Result: enfant(e2)
	(more_solutions ?)  yes.

	Result: enfant(e1)
	(more_solutions ?)  no.

	[my_toplevel]:  enfant(X).

	Result: enfant(e2)
	(more_solutions ?)  no.

	[my_toplevel]:  enfant(X).

	Result: enfant(e2)
	(more_solutions ?)  yes.

	Result: enfant(e1)
	(more_solutions ?)  yes.
	No more solutions

	[my_toplevel]:  

*/
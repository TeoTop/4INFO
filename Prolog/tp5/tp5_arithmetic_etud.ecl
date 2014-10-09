/**
["~/4INFO/Prolog/tp5/tp5_arithmetic_etud.ecl"].
**/
/*
	Question 1.1 : Somme de deux entiers de Peano
*/
add(zero,X,X).
add(s(X),Y,s(S)):- add(X,Y,S).
/*
add(s(zero),zero,S).
	S = s(zero)
	Yes (0.00s cpu)
add(X,Y,s(s(zero))).
	X = zero
	Y = s(s(zero))

	X = s(zero)
	Y = s(zero)

	X = s(s(zero))
	Y = zero
	Yes (0.00s cpu, solution 3)
*/

/*
	Question 1.2 : Différence entre deux entiers de Peano
*/
sub(X,Y,S):-add(Y,S,X).
/*sub(X,zero,X).
sub(X,X,zero).
sub(s(X),s(Y),S):-sub(X,Y,S).*/
/*
sub(s(s(zero)),s(zero),S).
	S = s(zero)
	Yes (0.00s cpu, solution 1, maybe more)
*/
/*
	Question 1.3 : Produit de deux entiers de Peano
*/
prod(zero,_,zero).
prod(s(X),Y,S):-prod(X,Y,Z),add(Z,Y,S).
/*
prod(s(s(zero)),s(s(s(zero))),S).
	S = s(s(s(s(s(s(zero))))))
	Yes (0.00s cpu)

prod(zero,s(zero),S).
	S = zero
	Yes (0.00s cpu)

prod(zero,zero,S).
	S = zero
	Yes (0.00s cpu)

prod(s(zero),zero,S).
	S = zero
	Yes (0.00s cpu)
*/
/*
	Question 1.4 : Factorielle d'un entier de Peano
*/
factorial(zero,s(zero)).
factorial(s(X),S):-factorial(X,Y),prod(s(X),Y,S).
/*
factorial(s(s(s((zero)))),S).
	S = s(s(s(s(s(s(zero))))))
	Yes (0.00s cpu)

factorial(s(s(((zero)))),S).
	S = s(s(zero))
	Yes (0.00s cpu)

factorial(s((((zero)))),S).
	S = s(zero)
	Yes (0.00s cpu)

factorial(((((zero)))),S).
	S = s(zero)
	Yes (0.00s cpu)
*/
/*
	Question 1.5 : Somme de deux entiers en représentation binaire
*/
add_bin(X,Y,S):-add_bin_rec(X,Y,0,S).
add_bin_rec([],[],0,[]).
add_bin_rec([],[],1,[1]).
add_bin_rec([],[B|Y],0,[B|Y]).
add_bin_rec([A|X],[],0,[A|X]).
add_bin_rec([],[B|Y],Ret,S):- \==(Ret,0),add_bin_rec([Ret],[B|Y],0,S).
add_bin_rec([A|X],[],Ret,S):- \==(Ret,0),add_bin_rec([A|X],[Ret],0,S).
add_bin_rec([A|X],[B|Y],Ret0,[R|S]):-add_bit(A,B,Ret0,R,Ret),add_bin_rec(X,Y,Ret,S).
/*
add_bin(X,Y,[0,0,1]).
	X = []
	Y = [0, 0, 1]

	X = [0, 0, 1]
	Y = []

	X = [0]
	Y = [0, 0, 1]

	X = [0, 0, 1]
	Y = [0]

	X = [0, 0]
	Y = [0, 0, 1]

	X = [0, 0, 1]
	Y = [0, 0]

	X = [0, 1]
	Y = [0, 1]

	X = [1]
	Y = [1, 1]

	X = [1, 1]
	Y = [1]

	X = [1, 0]
	Y = [1, 1]

	X = [1, 1]
	Y = [1, 0]
	Yes (0.00s cpu, solution 11, maybe more)

add_bin([1,1],[1,0,1,1],S).
	S = [0, 0, 0, 0, 1]
	Yes (0.00s cpu, solution 1, maybe more)

add_bin([1],[0,0,1,1],S).
	S = [1, 0, 1, 1, 0]
	Yes (0.00s cpu, solution 1, maybe more)

add_bin([1,1],[1,1],[0,1,1]).
	Yes (0.00s cpu, solution 1, maybe more)

add_bin([0,0,1],Y,[1,1,1]).
	Y = [1, 1]
	Yes (0.00s cpu, solution 1, maybe more)
*/

/*
	Question 1.6 : Différence entre deux entiers en représentation binaire
*/
sub_bin(X,Y,S):-add_bin(Y,S,X).
/*
sub_bin([1,1],Y,S).
	Y = []
	S = [1, 1]

	Y = [1, 1]
	S = []

	Y = [0]
	S = [1, 1]

	Y = [0, 1]
	S = [1]

	Y = [1]
	S = [0, 1]

	Y = [1, 1]
	S = [0]
	Yes (0.00s cpu, solution 6, maybe more)

sub_bin([1,1,1],[0,0,1],S).
	S = [1, 1]
	Yes (0.00s cpu, solution 1, maybe more)

sub_bin([1,0,1],[0,0,1],[1]).
	Yes (0.00s cpu, solution 1, maybe more)

*/

/*
	Question 1.7 : Produit de deux entiers en représentation binaire
*/
prod_bin([],_,[]).
prod_bin([A|X],Y,S):-prod_bin1(A,Y,Res1),prod_bin(X,Y,Res2),add_bin(Res1,[0|Res2],S).
prod_bin1(_,[],[]).
prod_bin1(A,[B|Y],[R|S]):-prod_bin2(A,B,R),prod_bin1(A,Y,S).
prod_bin2(0,_,0).
prod_bin2(X,0,0):- \==(X,0).%pour ne pas refaire 0 * 0 = 0
prod_bin2(1,1,1).
/*
prod_bin([1,1],[1,0,1],S).
	S = [1, 1, 1, 1]
	Yes (0.00s cpu, solution 1, maybe more)

prod_bin([1,0,1],[1,0,1],S).
	S = [1, 0, 0, 1, 1]
	Yes (0.00s cpu, solution 1, maybe more)
*/
/*
	Question 1.8 : Factorielle d'un entier en représentation binaire
*/
factorial_bin([],[1]).
factorial_bin([0],[1]).
factorial_bin(X,F):- sub_bin(X,[1],Sub),factorial_bin(Sub,Fact),prod_bin(X,Fact,F).
/*
factorial_bin([0,0,1],F).
	F = [0, 0, 0, 1, 1]
	Yes (0.00s cpu, solution 1, maybe more)

factorial_bin(X,[0,1,1]).
	X = [1, 1]
	Yes (0.00s cpu, solution 1, maybe more)
*/
%%%%%%%%%%% Binary representation
add_bit(0, 0, 0, 0, 0).
add_bit(0, 0, 1, 1, 0).
add_bit(0, 1, 0, 1, 0).
add_bit(0, 1, 1, 0, 1).
add_bit(1, 0, 0, 1, 0).
add_bit(1, 0, 1, 0, 1).
add_bit(1, 1, 0, 0, 1).
add_bit(1, 1, 1, 1, 1).

%%%%%%%%%%% Optional part
evaluate_numbers(N1, M1, N2, M2) :-
        evaluate(N1, N2),
        evaluate(M1, M2),
        number(N2),
        number(M2).        

evaluate(N, N) :- number(N).

evaluate(add(N1, M1), N) :-
        evaluate_numbers(N1, M1, N2, M2),
        N is N2 + M2.

evaluate(sub(N1, M1), N) :-
        evaluate_numbers(N1, M1, N2, M2),
        N is N2 - M2.

evaluate(prod(N1, M1), N) :-
        evaluate_numbers(N1, M1, N2, M2),
        N is N2 * M2.

evaluate(eq(N1, M1), Res) :-
        evaluate_numbers(N1, M1, N2, M2),
        (
            N2 = M2, Res = t
        ;
            N2 \= M2, Res = f
        ).

evaluate(fun(X, Body), fun(X, Body)).


fresh_variables(Expr, Res) :-
       fresh_variables(Expr, [], Res).

fresh_variables(X, Assoc, Y) :-
        var(X),
        !,
        assoc(X, Assoc, Y).

fresh_variables(add(X1, Y1), Assoc, add(X2, Y2)) :-
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(prod(X1, Y1), Assoc, prod(X2, Y2)) :-
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(sub(X1, Y1), Assoc, sub(X2, Y2)) :-
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(eq(X1, Y1), Assoc, eq(X2, Y2)) :-
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(if(Cond1, X1, Y1), Assoc, if(Cond2, X2, Y2)) :-
        fresh_variables(Cond1, Assoc, Cond2),
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(Number, _, Number) :- number(Number).

fresh_variables(fun(X, Body1), Assoc, fun(Y, Body2)) :-
        fresh_variables(Body1, [(X, Y) | Assoc], Body2).

fresh_variables(apply(Fun1, Param1), Assoc, apply(Fun2, Param2)) :-
        fresh_variables(Fun1, Assoc, Fun2),
        fresh_variables(Param1, Assoc, Param2).
        
%Fun = fun(N, fun(F, if(eq(N, 0), 1, prod(N, apply(apply(F, sub(N, 1)), F))))), Factorial = fun(N, apply(apply(Fun, N), Fun)), evaluate(apply(Factorial, 42), Res).

evaluate(if(evaluate(_,t),Then,_)):-Then.
evaluate(if(evaluate(_,f),_,Else)):-Else.
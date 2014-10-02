/*["~/4INFO/Prolog/tp4/tp4_arbres_etud.pl"].*/
/**
TP 4 Arbres binaires - Prolog

@author Theo CHAPON
@author Hassan El OMARI ALAOUI
@version Annee scolaire 2014/2015
*/


/*
-------------------------------------------------------------------------------
 Définition des prédicats
-------------------------------------------------------------------------------
*/

/*
Question 1 : B est un arbre binaire d'entier
*/
arbre_binaire(arb_bin(R,vide,vide)):-integer(R).
arbre_binaire(arb_bin(R,G,vide)):-integer(R),arbre_binaire(G).
arbre_binaire(arb_bin(R,vide,D)):-integer(R),arbre_binaire(D).
arbre_binaire(arb_bin(R,G,D)):- integer(R),arbre_binaire(G),arbre_binaire(D).
/*
arbre_binaire(arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)))).
	Yes (0.00s cpu, solution 1, maybe more)

arbre_binaire(arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin("5", vide, vide)))).
	No (0.00s cpu)

*/

/*
Question 2 : E est l'une des étiquettes de B
*/
dans_arbre_binaire(E,arb_bin(E,_,_)):-!.
dans_arbre_binaire(E,arb_bin(_,G,_)):-dans_arbre_binaire(E,G),!.
dans_arbre_binaire(E,arb_bin(_,_,D)):-dans_arbre_binaire(E,D),!.
/*
On met un cut car si on trouve que E est égal à l'une des racines de l'arbre binaire, il n'est pas nécessaire de boucler sur les autres branches.

dans_arbre_binaire(3,arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))).
	Yes (0.00s cpu, solution 1, maybe more)
dans_arbre_binaire(6,arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))).
	No (0.00s cpu)
*/


/*
Question 3 : S est un sous arbre de B
*/
sous_arbre_binaire(S,S):-!.
sous_arbre_binaire(S,arb_bin(_,G,_)):-sous_arbre_binaire(S,G),!.
sous_arbre_binaire(S,arb_bin(_,_,D)):-sous_arbre_binaire(S,D),!.
/*
On met un cut car si on trouve le sous arbre S de l'arbre binaure B, il n'est pas nécessaire de boucler sur les autres branches.

sous_arbre_binaire(arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, 7, vide)),arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, 7, vide))).
	Yes (0.00s cpu)

sous_arbre_binaire(arb_bin(5,8,vide),arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, 7, vide))).
	No (0.00s cpu)

sous_arbre_binaire(arb_bin(5,7,vide),arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, 7, vide))).	
	Yes (0.00s cpu)
*/

/*
Question 4 : B1 est l'arbre B où toute occurrence du sous arbre SA1 est remplacée par le sous arbre SA2
*/
remplacer(_,_,arb_bin(R,vide,vide),arb_bin(R,vide,vide)).
remplacer(SA1,SA2,arb_bin(R,vide,SA1),arb_bin(R,vide,SA2)).
remplacer(SA1,SA2,arb_bin(R,SA1,vide),arb_bin(R,SA2,vide)).
remplacer(SA1,SA2,arb_bin(R,G,vide),arb_bin(R,B,vide)):-remplacer(SA1,SA2,G,B).
remplacer(SA1,SA2,arb_bin(R,vide,D),arb_bin(R,vide,B)):-remplacer(SA1,SA2,D,B).

remplacer(SA1,SA2,arb_bin(R,SA1,SA1),arb_bin(R,SA2,SA2)).
remplacer(SA1,SA2,arb_bin(R,G,SA1),arb_bin(R,B,SA2)):- \==(G,SA1),remplacer(SA1,SA2,G,B).
remplacer(SA1,SA2,arb_bin(R,SA1,D),arb_bin(R,SA2,B)):- \==(D,SA1),remplacer(SA1,SA2,D,B).
remplacer(SA1,SA2,arb_bin(R,G,D),arb_bin(R,G1,D1)):- \==(SA1,G),\==(SA1,D),remplacer(SA1,SA2,G,G1),remplacer(SA1,SA2,D,D1).
/*
remplacer(arb_bin(3,vide,vide),arb_bin(4,vide,vide),arb_bin(1,arb_bin(3,vide,vide),arb_bin(3,vide,vide)),B).
	B = arb_bin(1, arb_bin(4, vide, vide), arb_bin(4, vide, vide))
	Yes (0.00s cpu, solution 1, maybe more)

remplacer(arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)),arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, 7, vide)),arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))),B).
	B = arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, 7, vide)))
	Yes (0.00s cpu, solution 1, maybe more)

remplacer(arb_bin(3,vide,vide),arb_bin(4,vide,vide),arb_bin(1,arb_bin(3,vide,vide),arb_bin(5,arb_bin(3,vide,vide),arb_bin(9,vide,vide))),B).
	B = arb_bin(1, arb_bin(4, vide, vide), arb_bin(5, arb_bin(4, vide, vide), arb_bin(9, vide, vide)))
	Yes (0.00s cpu, solution 1, maybe more)

remplacer(arb_bin(3,vide,vide),arb_bin(4,vide,vide),arb_bin(1,arb_bin(6,vide,vide),arb_bin(5,arb_bin(8,vide,vide),arb_bin(9,vide,vide))),B).
	B = arb_bin(1, arb_bin(6, vide, vide), arb_bin(5, arb_bin(8, vide, vide), arb_bin(9, vide, vide)))
	Yes (0.00s cpu, solution 1, maybe more)
*/

/*
	Question 5 : B1 et B2 sont isomorphes
*/
isomorphes(arb_bin(R,vide,vide),arb_bin(R,vide,vide)).
isomorphes(arb_bin(R,G1,D1),arb_bin(R,G2,D2)):- isomorphes(G1,G2),isomorphes(D1,D2).
isomorphes(arb_bin(R,G1,D1),arb_bin(R,G2,D2)):- isomorphes(G1,D2),isomorphes(D1,G2).
/*
isomorphes(arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide))),arb_bin(3, arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide)), arb_bin(4, vide, vide))).
	Yes (0.00s cpu, solution 1, maybe more)
*/

/*
	Question 6 : L contient les informations de l'arbre B en le parcourant en infixe
*/
/***Fonction auxiliaire****/
concat([A|X],Z,[A|T]):- concat(X,Z,T).
concat([],Z,Z).
/**************************/

infixe(vide,[]).
infixe(arb_bin(R,G,D),L) :- infixe(G,L1), infixe(D,L2), concat(L1,[R|L2],L).
/*
infixe(arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))),L).
	L = [6, 2, 1, 4, 3, 5]
	Yes (0.00s cpu)
*/

/*
	Question 7 : B2 est l’arbre ordonné d’entiers obtenu par l’insertion de la valeur X dans l’arbre ordonné d’entiers B1.
*/
insertion_arbre_ordonne(X,vide,arb_bin(X,vide,vide)).
insertion_arbre_ordonne(X,arb_bin(X,G,D),arb_bin(X,G,D)).
insertion_arbre_ordonne(X,arb_bin(R,G,D1),arb_bin(R,G,D2)) :-
	>(X,R),
	insertion_arbre_ordonne(X,D1,D2).
insertion_arbre_ordonne(X,arb_bin(R,G1,D),arb_bin(R,G2,D)) :-
	<(X,R),
	insertion_arbre_ordonne(X,G1,G2).
/*
insertion_arbre_ordonne(1,arb_bin(8, arb_bin(4, arb_bin(2, vide, vide), arb_bin(6, vide, vide)), arb_bin(12, arb_bin(10, vide, vide), vide)),B).
	B = arb_bin(8, arb_bin(4, arb_bin(2, arb_bin(1, vide, vide), vide), arb_bin(6, vide, vide)), arb_bin(12, arb_bin(10, vide, vide), vide))
	Yes (0.00s cpu)

insertion_arbre_ordonne(12,arb_bin(8, arb_bin(4, arb_bin(2, vide, vide), arb_bin(6, vide, vide)), arb_bin(12, arb_bin(10, vide, vide), vide)),B).
	B = arb_bin(8, arb_bin(4, arb_bin(2, vide, vide), arb_bin(6, vide, vide)), arb_bin(12, arb_bin(10, vide, vide), vide))
	Yes (0.00s cpu, solution 1, maybe more)
*/

/*
	Question 8 : 
*/
insertion_arbre_ordonne1(X,arb_bin(_,A,_)):-free(A),A = arb_bin(X,_,_),!.
insertion_arbre_ordonne1(X,arb_bin(X,_,_)).
insertion_arbre_ordonne1(X,arb_bin(R,_,D)) :-
	>(X,R),insertion_arbre_ordonne1(X,D).
insertion_arbre_ordonne1(X,arb_bin(R,G,_)) :-
	<(X,R),insertion_arbre_ordonne1(X,G).

/*
insertion_arbre_ordonne2(1,arb_bin(8, arb_bin(4, arb_bin(2, _, _), arb_bin(6, _, _)), arb_bin(12, arb_bin(10, _, _), _)),B).
	B = arb_bin(8, arb_bin(4, arb_bin(2, arb_bin(1, _233, _234), _84), arb_bin(6, _95, _96)), arb_bin(12, arb_bin(10, _115, _116), _122))
	Yes (0.00s cpu)

insertion_arbre_ordonne2(4,arb_bin(8, arb_bin(4, arb_bin(2, _, _), arb_bin(6, _, _)), arb_bin(12, arb_bin(10, _, _), _)),B).
	B = arb_bin(8, arb_bin(4, arb_bin(2, _83, _84), arb_bin(6, _95, _96)), arb_bin(12, arb_bin(10, _115, _116), _122))
	Yes (0.00s cpu, solution 1, maybe more)
*/
/*
-------------------------------------------------------------------------------
 Tests
-------------------------------------------------------------------------------
*/


% Quelques arbres à copier coller pour vous faire gagner du temps, mais
% n'hésitez pas à en définir d'autres

/*
arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)))

arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))

arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, 7, vide))

arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide)))

arb_bin(3, arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide)), arb_bin(4, vide, vide))

arb_bin(3, arb_bin(6, vide, vide), arb_bin(5, arb_bin(4, vide, vide), arb_bin(7, vide, vide)))

arb_bin(8, arb_bin(4, arb_bin(2, vide, vide), arb_bin(6, vide, vide)), arb_bin(12, arb_bin(10, vide, vide), vide))

arb_bin(8, arb_bin(4, arb_bin(2, _, _), arb_bin(6, _, _)), arb_bin(12, arb_bin(10, _, _), _))

arb_bin(6,arb_bin(2,arb_bin(1,vide,vide),arb_bin(4,vide,vide)),arb_bin(8,vide,arb_bin(10,vide,vide)))

arb_bin(8,arb_bin(2,arb_bin(1,vide,vide),arb_bin(4,vide,vide)),arb_bin(6,vide,arb_bin(10,vide,vide)))

arb_bin(6,arb_bin(2,arb_bin(1,vide,vide),arb_bin(4,vide,vide)),arb_bin(8,arb_bin(2,arb_bin(1,vide,vide),arb_bin(4,vide,vide)),arb_bin(10,vide,vide)))

*/

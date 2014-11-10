/**
TP 7 Base de Données Déductives (BDD) - Prolog

@author Theo CHAPON
@author Hassan EL OMARI ALAOUI
@version Annee scolaire 2014/2015
*/


/*
===============================================================================
===============================================================================
 Définition des prédicats
===============================================================================
*/

% ============================================================================= 
% SECTION 2 : Opération relationnelles
% ============================================================================= 

piece_lyon(X,Y,lyon).

piece_lieu(_,X,Y).

union_fournisseur(X,Y):-demandeFournisseur(X,Y).
union_fournisseur(X,Y):-fournisseurReference(_,X,Y).

intersection_fournisseur(X,Y):-demandeFournisseur(X,Y),fournisseurReference(_,X,Y).

difference_fournisseur(X,Y):-demandeFournisseur(X,Y),not(intersection_fournisseur(X,Y)).

produit_cartesien(X,Y,Z,A,B,C):-fournisseurReference(X,Y,Z),livraison(A,B,C).

jointure(Y,Z,A,B,C):-fournisseurReference(A,Y,Z),livraison(A,B,C).

jointure300(Y,Z,A,B,C):-fournisseurReference(A,Y,Z),livraison(A,B,C),C>350.

division1(P,N,Num):-piece(P,N,lyon),not(livraison(Num,P,_)).
division(Nom):-fournisseurReference(Num,Nom,_),not(division1(_,_,Num)).

somme([],0).
somme([A|L],S):-somme(L,B),S is B + A.
total_piece(Nom,T):- fournisseurReference(Num,Nom,_),findall(Q,livraison(Num,_,Q),L),somme(L,T).

% ============================================================================= 
% SECTION 3 : Au delà de l’algèbre relationnelle
% ============================================================================= 
realiser_composant(C,Cd):-assemblage(C,A,_),realiser_composant(A,Cd).
realiser_composant(C,Cd):-assemblage(C,Cd,_).

multiply([],_,[]).
multiply([ass(C,Q)|L],Qc,[ass(C,M)|ListeMult]):-M is Q*Qc,multiply(L,Qc,ListeMult).

nombre_total(C,T):-nombre_total_bis([ass(C,1)],T).
nombre_total_bis([],0).
nombre_total_bis([ass(C,Qc)|Liste],T):-not(piece(_,C,_)),findall(ass(Cd,Q),assemblage(C,Cd,Q),L),multiply(L,Qc,ListeMult),append(Liste,ListeMult,S),nombre_total_bis(S,T).
nombre_total_bis([ass(C,Q)|Liste],T):-piece(_,C,_),nombre_total_bis(Liste,N),T is Q + N,!.


total(Nom,Nb):-findall(Num,piece(Num,Nom,_),Comp),total_bis(Comp,0,Nb).
total_bis([],Nb,Nb).
total_bis([Num|Suite],Acc,Nb):-findall(Q,livraison(_,Num,Q),L),somme(L,T),Acc1 is Acc + T,total_bis(Suite,Acc1,Nb).
total_piece_livraison([],[]).
total_piece_livraison([ass(Nom,Q)|Composants],[S|Total]):-total(Nom,Nb),S is Nb/Q,total_piece_livraison(Composants,Total).
nombre_voiture(N):-nombre_voiture_bis([ass(voiture,1)],Composants),total_piece_livraison(Composants,Total),min(Total,Real),floor(Real,N).
nombre_voiture_bis([],[]).
nombre_voiture_bis([ass(C,Qc)|Liste],Composants):-not(piece(_,C,_)),findall(ass(Cd,Q),assemblage(C,Cd,Q),L),multiply(L,Qc,ListeMult),append(Liste,ListeMult,S),nombre_voiture_bis(S,Composants).
nombre_voiture_bis([ass(C,Q)|Liste],Composants):-piece(_,C,_),nombre_voiture_bis(Liste,Composant_S),append([ass(C,Q)],Composant_S,Composants),!.

/*
===============================================================================
===============================================================================
 Tests
===============================================================================
*/

% ============================================================================= 
% SECTION 2 : Opération relationnelles
% ============================================================================= 
/*
piece_lyon(X,Y,lyon).
	X = p1
	Y = tole
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	X = p2
	Y = jante
	Yes (0.00s cpu, solution 2)


piece_lieu(_,X,Y).
	X = tole
	Y = lyon
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	X = jante
	Y = lyon
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	X = jante
	Y = marseille
	Yes (0.00s cpu, solution 3, maybe more) ? ;

	X = pneu
	Y = clermontFerrand
	Yes (0.00s cpu, solution 4, maybe more) ? ;

	X = piston
	Y = toulouse
	Yes (0.00s cpu, solution 5, maybe more) ? ;

	X = soupape
	Y = lille
	Yes (0.00s cpu, solution 6, maybe more) ? ;

	X = vitre
	Y = nancy
	Yes (0.00s cpu, solution 7, maybe more) ? ;

	X = tole
	Y = marseille
	Yes (0.00s cpu, solution 8, maybe more) ? ;

	X = vitre
	Y = marseille
	Yes (0.00s cpu, solution 9)


union_fournisseur(X,Y).
	X = dupont
	Y = lyon
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	X = michel
	Y = clermontFerrand
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	X = durand
	Y = lille
	Yes (0.00s cpu, solution 3, maybe more) ? ;

	X = dupond
	Y = lille
	Yes (0.00s cpu, solution 4, maybe more) ? ;

	X = martin
	Y = rennes
	Yes (0.00s cpu, solution 5, maybe more) ? ;

	X = smith
	Y = paris
	Yes (0.00s cpu, solution 6, maybe more) ? ;

	X = brown
	Y = marseille
	Yes (0.00s cpu, solution 7, maybe more) ? ;

	X = dupont
	Y = lyon
	Yes (0.00s cpu, solution 8, maybe more) ? ;

	X = durand
	Y = lille
	Yes (0.00s cpu, solution 9, maybe more) ? ;

	X = martin
	Y = rennes
	Yes (0.00s cpu, solution 10, maybe more) ? ;

	X = michel
	Y = clermontFerrand
	Yes (0.00s cpu, solution 11, maybe more) ? ;

	X = smith
	Y = paris
	Yes (0.00s cpu, solution 12, maybe more) ? ;

	X = brown
	Y = marseille
	Yes (0.00s cpu, solution 13)

intersection_fournisseur(X,Y). 6 solutions
	X = dupont
	Y = lyon
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	X = michel
	Y = clermontFerrand
	Yes (0.00s cpu, solution 2, maybe more)

difference_fournisseur(X,Y).
	X = dupond
	Y = lille
	Yes (0.00s cpu, solution 1, maybe more)

produit_cartesien(X,Y,Z,A,B,C). 60 solutions
	X = f1
	Y = dupont
	Z = lyon
	A = f1
	B = p1
	C = 300
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	X = f1
	Y = dupont
	Z = lyon
	A = f2
	B = p2
	C = 200
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	X = f1
	Y = dupont
	Z = lyon
	A = f3
	B = p3
	C = 200
	Yes (0.00s cpu, solution 3, maybe more) ? ...

jointure(Y,Z,A,B,C). 10 solutions
	Y = dupont
	Z = lyon
	A = f1
	B = p1
	C = 300
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	Y = dupont
	Z = lyon
	A = f1
	B = p2
	C = 300
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	Y = durand
	Z = lille
	A = f2
	B = p2
	C = 200
	Yes (0.00s cpu, solution 3, maybe more) ? ...

jointure300(Y,Z,A,B,C).
	Y = michel
	Z = clermontFerrand
	A = f4
	B = p4
	C = 400
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	Y = brown
	Z = marseille
	A = f6
	B = p5
	C = 500
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	Y = brown
	Z = marseille
	A = f6
	B = p6
	C = 1000
	Yes (0.00s cpu, solution 3, maybe more)

division(Nom).
	Nom = dupont
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	Nom = michel
	Yes (0.00s cpu, solution 2, maybe more)

total_piece(Nom,T).
	Nom = dupont
	T = 600
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	Nom = durand
	T = 200
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	Nom = martin
	T = 200
	Yes (0.00s cpu, solution 3, maybe more) ? ;

	Nom = michel
	T = 1000
	Yes (0.00s cpu, solution 4, maybe more) ? ;

	Nom = smith
	T = 0
	Yes (0.00s cpu, solution 5, maybe more) ? ;

	Nom = brown
	T = 1800
	Yes (0.00s cpu, solution 6)

*/


% ============================================================================= 
% SECTION 3 : Au delà de l’algèbre relationnelle
% ============================================================================= 
/*
realiser_composant(voiture,C).
	C = tole
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	C = vitre
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	C = jante
	Yes (0.00s cpu, solution 3, maybe more) ? ;

	C = pneu
	Yes (0.00s cpu, solution 4, maybe more) ? ;

	C = piston
	Yes (0.00s cpu, solution 5, maybe more) ? ;

	C = soupape
	Yes (0.00s cpu, solution 6, maybe more) ? ;

	C = porte
	Yes (0.00s cpu, solution 7, maybe more) ? ;

	C = roue
	Yes (0.00s cpu, solution 8, maybe more) ? ;

	C = moteur
	Yes (0.00s cpu, solution 9)

nombre_total(voiture,N).
	N = 36
	Yes (0.00s cpu, solution 1, maybe more)

nombre_voiture(N).
	N = 62.0
	Yes (0.00s cpu, solution 1, maybe more) ?
*/
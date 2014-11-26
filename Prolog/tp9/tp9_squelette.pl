/**
TP 9 Prolog

@author Theo CHAPON
@author Hassan EL OMARI ALAOUI
@version Annee scolaire 2014/2015
*/


/*
	Question 1.1 : combiner(Copains, Binomes), produire la liste Binomes de tous les binômes que l'on peut créer à partir de la liste Copains
*/
/*
["~/4INFO/Prolog/tp9/tp9_squelette.pl"].
*/
combiner([_],[]).
combiner([A|Copains],Binomes):- creer(A,Copains,B),combiner(Copains,Binomes1),append(B,Binomes1,Binomes).

creer(_,[],[]).
creer(A,[X|Copains],[(A,X)|B]):- creer(A,Copains,B). 


/*
	Question 1.2: extraire(AllPossibleBinomes, NbBinomes, Tp, RemainingBinomes), extraire NbBinomes de la liste de tous les binomes
*/

exist((A,B),[(X,Y)|Tp]):- A=X;A=Y;B=X;B=Y;exist((A,B),Tp).

extraire(AllPossibleBinomes,NbBinomes,Tp,RemainingBinomes):- extraire_aux(AllPossibleBinomes,NbBinomes,[],Tp,RemainingBinomes).

extraire_aux(AllPossibleBinomes,0,Tp,Tp,AllPossibleBinomes).

extraire_aux([(A,B)|AllPossibleBinomes],NbBinomes,Tp_acc,Tp,RemainingBinomes):- not(NbBinomes=0),not(exist((A,B),Tp_acc)),NbBinomes1 is NbBinomes - 1,extraire_aux(AllPossibleBinomes,NbBinomes1,[(A,B)|Tp_acc],Tp,RemainingBinomes).



extraire_aux([(A,B)|AllPossibleBinomes],NbBinomes,Tp_acc,Tp,[(A,B)|RemainingBinomes]):- not(NbBinomes=0),extraire_aux(AllPossibleBinomes,NbBinomes,Tp_acc,Tp,RemainingBinomes).


/*
	Question 1.3: les_tps(Copains, Tps), fournir tous les binômages possibles pour les étudiants Copains
*/
les_tps(Copains,[Tps_acc|Tps]):- combiner(Copains, Binomes), extraire(Binomes,2,Tps_acc,R),tps_aux(R,Tps),!.
tps_aux([],[]).
tps_aux(Binomes,[Tps_acc|Tps]):-extraire(Binomes,2,Tps_acc,R),tps_aux(R,Tps).


/* Test
Q1.1
	combiner([pluto,riri,fifi,loulou],Binomes).
		Binomes = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
		Yes

Q1.2
	combiner([pluto,riri,fifi,loulou],Binomes),extraire(Binomes,2,Tp,R).

		Binomes = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
		Tp = [(fifi, loulou), (pluto, riri)]
		R = [(pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou)]
		
		Binomes = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
		Tp = [(riri, loulou), (pluto, fifi)]
		R = [(pluto, riri), (pluto, loulou), (riri, fifi), (fifi, loulou)]

		Binomes = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
		Tp = [(riri, fifi), (pluto, loulou)]
		R = [(pluto, riri), (pluto, fifi), (riri, loulou), (fifi, loulou)]

Q1.3
les_tps([pluto,riri,fifi,loulou],Tps).
	Tps = [[(fifi, loulou), (pluto, riri)], [(riri, loulou), (pluto, fifi)], [(riri, fifi), (pluto, loulou)]]
	Yes (0.00s cpu)

*/
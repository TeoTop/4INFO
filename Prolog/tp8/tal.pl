/**
TP 8 Traitement Automatique de la Langue (TAL) - Prolog

@author Theo CHAPON
@author Hassan EL OMARI ALAOUI
@version Annee scolaire 2014/2015
*/


/*
===============================================================================
===============================================================================
 Définition des prédicats
===============================================================================

% Afin de simplifier la correction, merci de conserver dans votre grammaire
% l'ordre ci-dessous
 

phrase_simple
gp_nominal 
gp_verbal
gp_prepositionnel
relatif

article
nom_commun
nom_propre
adjectif
prep       
verbe
pronom


%% Question 1.1  Grammaire de la langue française (la vraie) %% 

phrase_simple ::= gp_nominal gp_verbal
gp_nominal ::= article nom_commun relatif
gp_nominal ::= article nom_commun
gp_nominal ::= article nom_commun adjectif relatif
gp_nominal ::= article nom_commun adjectif
gp_nominal ::= nom_propre
gp_nominal ::= nom_propre relatif
relatif ::= pronom gp_verbal
gp_verbal ::= verbe
gp_verbal ::= verbe gp_prepositionnel
gp_verbal ::= verbe gp_nominal
gp_prepositionnel ::= prep gp_nominal
        
        

===============================================================================
*/
art(le,mas,sin).
art(la,fem,sin).
art(les,mas,plu).
art(un,mas,sin).
art(une,fem,sin).
art(des,_,plu).

nc(chien,mas,sin,animal).
nc(chiens,mas,plu,animal).
nc(enfants,mas,plu,humain).
nc(rue,fem,sin,lieu).
nc(pull,mas,sin,objet).
nc(steack,mas,sin,objet).
nc(femme,fem,sin,humain).

np(paul,mas,sin,humain).

adj(noir,mas,sin,_).

pre(dans,lieu).   

vb(aboie,sin,animal,vide).
vb(aboient,plu,animal,vide).
vb(jouent,plu,_,_).
vb(marche,sin,_,lieu).
vb(porte,sin,_,objet).
vb(mange,sin,_,objet).

pn(qui).

article([X|L],L):-art(X).
nom_commun([X|L],L):-nc(X).
nom_propre([X|L],L):-np(X).
adjectif([X|L],L):-adj(X).
prep([X|L],L):-pre(X).
verbe([X|L],L):-vb(X).
pronom([X|L],L):-pn(X).
/*
article_arbre([X|L],L,art(X)):-art(X).
nom_commun_arbre([X|L],L,nc(X)):-nc(X).
nom_propre_arbre([X|L],L,np(X)):-np(X).
adjectif_arbre([X|L],L,adj(X)):-adj(X).
prep_arbre([X|L],L,prep(X)):-pre(X).
verbe_arbre([X|L],L,vb(X)):-vb(X).
pronom_arbre([X|L],L,pn(X)):-pn(X).
*/
article_arbre([X|L],L,art(X),G,N):-art(X,G,N).
nom_commun_arbre([X|L],L,nc(X),G,N,C):-nc(X,G,N,C).
nom_propre_arbre([X|L],L,np(X),G,N,C):-np(X,G,N,C).
adjectif_arbre([X|L],L,adj(X),G,N,C):-adj(X,G,N,C).
prep_arbre([X|L],L,prep(X),C):-pre(X,C).
verbe_arbre([X|L],L,vb(X),N,C1,C2):-vb(X,N,C1,C2).
pronom_arbre([X|L],L,pn(X)):-pn(X).

/*
===============================================================================
 Question
===============================================================================
*/

% Quelques phrases de test à copier coller pour vous faire gagner du temps, mais
% n'hésitez pas à en définir d'autres
/*
	["~/4INFO/Prolog/tp8/tal.pl"].
*/

/* Question 2.1 : Réaliser la grammaire à l'aide de prolog */

analyse(L):-phrase_simple(L,[]).
phrase_simple(L,R):-gp_nominal(L,L1),gp_verbal(L1,R).
gp_nominal(L,R):-article(L,L1),nom_commun(L1,L2),suite_grp_nominal2(L2,R).
gp_nominal(L,R):-nom_propre(L,L1),suite_grp_nominal(L1,R).
suite_grp_nominal2(L,R):-suite_grp_nominal(L,R).
suite_grp_nominal2(L,R):-adjectif(L,L1),suite_grp_nominal2(L1,R).
suite_grp_nominal(L,L).
suite_grp_nominal(L,R):-relatif(L,R).

relatif(L,R):-pronom(L,L1),gp_verbal(L1,R).

gp_verbal(L,R):-verbe(L,R).
gp_verbal(L,R):-verbe(L,L1),gp_prepositionnel(L1,R).
gp_verbal(L,R):-verbe(L,L1),gp_nominal(L1,R).
gp_prepositionnel(L,R):-prep(L,L1),gp_nominal(L1,R).

/* Test 

analyse([le,chien,aboie]).
	Yes
analyse([les,enfants,jouent]).
	Yes 
analyse([paul,marche,dans,la,rue]).
	Yes 
analyse([la,femme,qui,porte,un,pull,noir,mange,un,steack]).
	Yes 
analyse([les,chiens,aboient]).
	Yes 
analyse([la,femme,qui,porte,un,pull,noir,mange,un,chien]).              
	Yes 
*/

/* Question 2.2 : Réaliser un arbre de la grammaire à l'aide de prolog */


analyse_arbre(L,A):-phrase_simple_arbre(L,[],A).
phrase_simple_arbre(L,R,phr(A1,A2)):-gp_nominal_arbre(L,L1,A1),gp_verbal_arbre(L1,R,A2).
gp_nominal_arbre(L,R,gn(A1,A2)):-article_arbre(L,L1,A1),nom_commun_arbre(L1,R,A2).
gp_nominal_arbre(L,R,gn(A1,A2,A3)):-article_arbre(L,L1,A1),nom_commun_arbre(L1,L2,A2),relatif_arbre(L2,R,A3).
gp_nominal_arbre(L,R,gn(A1,A2,A3)):-article_arbre(L,L1,A1),nom_commun_arbre(L1,L2,A2),adjectif_arbre(L2,R,A3).
gp_nominal_arbre(L,R,gn(A1,A2,A3,A4)):-article_arbre(L,L1,A1),nom_commun_arbre(L1,L2,A2),adjectif_arbre(L2,L3,A3),relatif_arbre(L3,R,A4).
gp_nominal_arbre(L,R,gn(A)):-nom_propre_arbre(L,R,A).
gp_nominal_arbre(L,R,gn(A1,A2)):-nom_propre_arbre(L,L1,A1),relatif_arbre(L1,R,A2).

relatif_arbre(L,R,rel(A1,A2)):-pronom_arbre(L,L1,A1),gp_verbal_arbre(L1,R,A2).

gp_verbal_arbre(L,R,gv(A)):-verbe_arbre(L,R,A).
gp_verbal_arbre(L,R,gv(A1,A2)):-verbe_arbre(L,L1,A1),gp_prepositionnel_arbre(L1,R,A2).
gp_verbal_arbre(L,R,gv(A1,A2)):-verbe_arbre(L,L1,A1),gp_nominal_arbre(L1,R,A2).
gp_prepositionnel_arbre(L,R,gp(A1,A2)):-prep_arbre(L,L1,A1),gp_nominal_arbre(L1,R,A2).


/* Test

analyse_arbre([le,chien,aboie],A).
	A = phr(gn(art(le), nc(chien)), gv(vb(aboie)))

analyse_arbre([les,enfants,jouent],A).
	A = phr(gn(art(les), nc(enfants)), gv(vb(jouent)))

analyse_arbre([paul,marche,dans,la,rue],A).
	A = phr(gn(np(paul)), gv(vb(marche), gp(prep(dans), gn(art(la), nc(rue)))))

analyse_arbre([la,femme,qui,porte,un,pull,noir,mange,un,steack],A).
	A = phr(gn(art(la), nc(femme), rel(pn(qui), gv(vb(porte), gn(art(un), nc(pull), adj(noir))))), gv(vb(mange), gn(art(un), nc(steack))))

analyse_arbre([les,chiens,aboient],A).
	A = phr(gn(art(les), nc(chiens)), gv(vb(aboient)))

analyse_arbre([la,femme,qui,porte,un,pull,noir,mange,un,chien],A).              
	A = phr(gn(art(la), nc(femme), rel(pn(qui), gv(vb(porte), gn(art(un), nc(pull), adj(noir))))), gv(vb(mange), gn(art(un), nc(chien))))
*/

/* Question 2.3 */
analyse_arbre(L,A):-phrase_simple_arbre(L,[],A).
phrase_simple_arbre(L,R,phr(A1,A2)):-gp_nominal_arbre(L,L1,A1,G,N),gp_verbal_arbre(L1,R,A2,N).

gp_nominal_arbre(L,R,gn(A1,A2),G,N):-article_arbre(L,L1,A1,G,N),nom_commun_arbre(L1,R,A2,G,N).

gp_nominal_arbre(L,R,gn(A1,A2,A3),G,N):-article_arbre(L,L1,A1,G,N),nom_commun_arbre(L1,L2,A2,G,N),relatif_arbre(L2,R,A3,N).

gp_nominal_arbre(L,R,gn(A1,A2,A3),G,N):-article_arbre(L,L1,A1,G,N),nom_commun_arbre(L1,L2,A2,G,N),adjectif_arbre(L2,R,A3,G,N).

gp_nominal_arbre(L,R,gn(A1,A2,A3,A4),G,N):-article_arbre(L,L1,A1,G,N),nom_commun_arbre(L1,L2,A2,G,N),adjectif_arbre(L2,L3,A3,G,N),relatif_arbre(L3,R,A4,N).

gp_nominal_arbre(L,R,gn(A),G,N):-nom_propre_arbre(L,R,A,G,N).

gp_nominal_arbre(L,R,gn(A1,A2),G,N):-nom_propre_arbre(L,L1,A1,G,N),relatif_arbre(L1,R,A2,N).

relatif_arbre(L,R,rel(A1,A2),N):-pronom_arbre(L,L1,A1),gp_verbal_arbre(L1,R,A2,N).
gp_verbal_arbre(L,R,gv(A),N):-verbe_arbre(L,R,A,N).

gp_verbal_arbre(L,R,gv(A1,A2),N):-verbe_arbre(L,L1,A1,N),gp_prepositionnel_arbre(L1,R,A2).

gp_verbal_arbre(L,R,gv(A1,A2),N):-verbe_arbre(L,L1,A1,N),gp_nominal_arbre(L1,R,A2,_,_).
gp_prepositionnel_arbre(L,R,gp(A1,A2)):-prep_arbre(L,L1,A1),gp_nominal_arbre(L1,R,A2,_,_).

/* Test
analyse_arbre([paul,marche,dans,le,rue],A).
	No (0.00s cpu)
analyse_arbre([paul,aboient,dans,la,rue],A).
	No (0.00s cpu)
*/

/*
analyse_arbre([le,chien,aboie],A).
analyse_arbre([les,enfants,jouent],A).
analyse_arbre([paul,marche,dans,la,rue],A).
analyse_arbre([la,femme,qui,porte,un,pull,noir,mange,un,steack],A).
analyse_arbre([les,chiens,aboient],A).
analyse_arbre([la,femme,qui,porte,un,pull,noir,mange,un,chien],A).              

*/


/* Question 2.4 */

analyse_arbre(L,A):-phrase_simple_arbre(L,[],A).
phrase_simple_arbre(L,R,phr(A1,A2)):-gp_nominal_arbre(L,L1,A1,G,N,C),gp_verbal_arbre(L1,R,A2,N,C,_).

gp_nominal_arbre(L,R,gn(A1,A2),G,N,C):-article_arbre(L,L1,A1,G,N),nom_commun_arbre(L1,R,A2,G,N,C).

gp_nominal_arbre(L,R,gn(A1,A2,A3),G,N,C):-article_arbre(L,L1,A1,G,N),nom_commun_arbre(L1,L2,A2,G,N,C),relatif_arbre(L2,R,A3,N,C).

gp_nominal_arbre(L,R,gn(A1,A2,A3),G,N,C):-article_arbre(L,L1,A1,G,N),nom_commun_arbre(L1,L2,A2,G,N,C),adjectif_arbre(L2,R,A3,G,N,C).

gp_nominal_arbre(L,R,gn(A1,A2,A3,A4),G,N,C):-article_arbre(L,L1,A1,G,N),nom_commun_arbre(L1,L2,A2,G,N,C),adjectif_arbre(L2,L3,A3,G,N,C),relatif_arbre(L3,R,A4,N,C).

gp_nominal_arbre(L,R,gn(A),G,N,C):-nom_propre_arbre(L,R,A,G,N,C).

gp_nominal_arbre(L,R,gn(A1,A2),G,N,C):-nom_propre_arbre(L,L1,A1,G,N,C),relatif_arbre(L1,R,A2,N,C).

relatif_arbre(L,R,rel(A1,A2),N,C):-pronom_arbre(L,L1,A1),gp_verbal_arbre(L1,R,A2,N,C,_).
gp_verbal_arbre(L,R,gv(A),N,C1,C2):-verbe_arbre(L,R,A,N,C1,C2).

gp_verbal_arbre(L,R,gv(A1,A2),N,C1,C2):-verbe_arbre(L,L1,A1,N,C1,C2),gp_prepositionnel_arbre(L1,R,A2).

gp_verbal_arbre(L,R,gv(A1,A2),N,C1,C2):-verbe_arbre(L,L1,A1,N,C1,C2),gp_nominal_arbre(L1,R,A2,_,_,C2).
gp_prepositionnel_arbre(L,R,gp(A1,A2)):-prep_arbre(L,L1,A1,C),gp_nominal_arbre(L1,R,A2,_,_,C).

/* Test
analyse_arbre([paul,mange,un,steack],A).
	A = phr(gn(np(paul)), gv(vb(mange), gn(art(un), nc(steack))))
	Yes

analyse_arbre([paul,mange,la,rue],A).
	No

analyse_arbre([paul,aboie],A).
	No

 analyse_arbre([les,enfants,jouent,dans,le,chien],A).
	No
*/
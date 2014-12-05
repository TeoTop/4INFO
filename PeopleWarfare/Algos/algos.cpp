#include <time.h>
#include <stdlib.h>
#include "algos.h"
#include <math.h>
int* Algos::generer_carte(int nbCase, int nbTypeCase) {
	srand(time(NULL));
	int* nb = (int*)malloc(nbTypeCase * sizeof(int));
	int* cases = (int*)malloc(nbCase * sizeof(int));
	for (int i = 0; i < nbTypeCase; i++)
	{
		nb[i] = 0;
	}
	bool drap = false;
	for (int i = 0, typeCase = 0; i < nbCase; i++)
	{
		drap = false;
		while (!drap)
		{
			typeCase = rand() % nbTypeCase;
			if (nb[typeCase] < nbCase / nbTypeCase)
			{
				nb[typeCase] += 1;
				drap = true;
			}
		}
		cases[i] = typeCase;
	}
	return cases;
}
int** Algos::suggestion_cases(int* cases, int* posEnnemi, int posActuelle, int typeUnite) {
	int** cases_dispo;
	cases_dispo = (int**)malloc(sizeof(int*)* 2);
	return cases_dispo;
}


/*
if (type == EnumPeuple.ELF && carte.getCase(c).getType() == EnumCase.DESERT) return false;

if ( ((type == EnumPeuple.ELF && carte.getCase(c).getType() != EnumCase.FORET) ||
(type == EnumPeuple.ORC && carte.getCase(c).getType() != EnumCase.PLAINE)) && pm < 1)
{
return false;
}

List<int> casesDispo = new List<int>();

casesDispo.Add(c - taille);
casesDispo.Add(c + taille);
casesDispo.Add(c - 1);
casesDispo.Add(c + 1);

if (carte.getX(c) % 2 == 1)
{
casesDispo.Add(c - (taille - 1));
casesDispo.Add(c + (taille + 1));
}
else
{
casesDispo.Add(c + (taille - 1));
casesDispo.Add(c - (taille + 1));
}

// move on Montagne box for a Nain.
if (type == EnumPeuple.NAIN && carte.getCase(cInit).getType() == EnumCase.MONTAGNE &&
carte.getCase(c).getType() == EnumCase.MONTAGNE && !adv.verifierUnite(c).Any())
{
return true;
}

if (casesDispo.Contains(c))
{
return true;
}

return false;*/

/*
cases = tableau de la carte : [id] -> type de cases ; id correspond au numéro de la case
posEnnemi = tableau des positions ennemies : [id] -> position ; id = n° unité
posActuelle = n° case de l'unité à déplacer
type unite = 0 Orc, 1 Elf, 2 Nain
*/
/*
int** Algos::cases_atteignable(int* cases, int nbCase int* posEnnemi, int posActuelle, int typeUnite){
	int nbCase = 1;
	int* cases_dispo = (int*)malloc(sizeof(int) * 6);

	cases_dispo[0] = posActuelle - sqrt((double)nbCase)

	int* cases_dispo = (int*)realloc(cases_dispo, ++nbCase * sizeof(int));

}*/


int* Algos::placer_joueurs(int nbCase) {
	int placement[2];
	srand(time(NULL));
	if (rand() % 2) {
		placement[0] = 0;
		placement[1] = nbCase - 1;
	}
	else {
		placement[0] = sqrt((double)nbCase);
		placement[1] = nbCase - (placement[0] + 1);
	}
	return placement;
}


EXTERNC DLL Algos* Algos_New() {
	return new Algos();
}
EXTERNC DLL void Algos_Delete(Algos* algos) {
	delete algos;
}
/*EXTERNC DLL int* Gen_GenCarte(Algos* gen, int nbCase, int nbTypeCase) {
	return gen->generer_carte(nbCase, nbTypeCase);
}*/
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
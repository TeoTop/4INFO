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



int** Algos::cases_atteignable(int* cases, int nbCase int* posEnnemi, int posActuelle, int typeUnite, int pm){
	int taille_dispo = 1;
	int cases_possible[6];
	int(*case_dispo)[2];

	if (pm == 0){
		case_dispo = malloc(1 * sizeof(*case_dispo)); // case_dispo = null;
		return case_dispo;
	}
	
	cases_possible[0] = posActuelle - sqrt((double)nbCase);
	cases_possible[1] = posActuelle + sqrt((double)nbCase);
	cases_possible[2] = posActuelle + 1;
	cases_possible[3] = posActuelle - 1;

	if ((posActuelle/nbCase) % 2 == 1)
	{
		cases_possible[4] = posActuelle - (sqrt((double)nbCase) - 1));
		cases_possible[5] = posActuelle + (sqrt((double)nbCase) + 1));
	}
	else
	{
		cases_possible[4] = posActuelle + (sqrt((double)nbCase) - 1));
		cases_possible[5] = posActuelle - (sqrt((double)nbCase) + 1));
	}

	switch (typeUnite)
	{
		case 0:
			if (pm != 1)
			{
				for (int i = 0; i < 6; i++){
					if (cases[i] != 2){
						cases_possible[i] = -1;
					}
				}
			}
			break;
		case 1:
			for (int i = 0; i < 6; i++){
				if ((pm != 1 && cases[i] != 1) || cases[i] == 3){
					cases_possible[i] = -1;
				}
			}
			break;
		case 2:
			if (cases[posActuelle] == 3){
				for (int i = 0; i < nbCase; ++i){
					if (cases[i] == 3){
						for (int j = 0; j < sizeof(posEnnemi) / sizeof(int); j++){
							if (i == posEnnemi[j]){
								cases_possible[i] = -1;
							}
						}
					}
				}
			}
			break;
	}
	
	for (int i = 0; i < 6; i++){
		if (cases_possible[i] >= 0){
			case_dispo = realloc(case_dispo, taille_dispo * sizeof(*case_dispo)); // case_dispo = null;
			case_dispo[taille_dispo - 1][0] = cases_possible[i];
			case_dispo[taille_dispo - 1][1] = 0;
			for (int j = 0; j < sizeof(posEnnemi) / sizeof(int); j++){
				if (cases_possible[i] == posEnnemi[j]){
					case_dispo[taille_dispo - 1][1] = 1;
				}
			}
		}
	}

	return case_dispo;
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
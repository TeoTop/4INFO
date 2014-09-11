#include "Carte.h"
#include <iostream>


Carte* Carte::_debutN = 0;
Carte* Carte::_debutS = 0;
Carte* Carte::_finN = 0;
Carte* Carte::_finS = 0;


Carte::Carte(int couleur, int valeur, char proprietaire) : _couleur(couleur), _valeur(valeur), _proprietaire(proprietaire), _succ(NULL)
{
	if (proprietaire == 'N')
	{
		if (Carte::_debutN == NULL) {
			Carte::_debutN = this;
			Carte::_finN = this;
		}
		else
		{
			Carte::_finN->_succ = this;
			Carte::_finN = this;
		}
	}
	else if (proprietaire == 'S') {
		if (Carte::_debutS == NULL) {
			Carte::_debutS = this;
			Carte::_finS= this;
		}
		else
		{
			Carte::_finS->_succ = this;
			Carte::_finS= this;
		}
	}
}

void Carte::afficher() {
	char couleur[4][10] = { "PIQUE", "TREFLE", "COEUR", "CARREAU" };
	char valeur[13][10] = { "AS", "DEUX", "TROIS", "QUATRE", "CINQ", "SIX", "SEPT", "HUIT", "NEUF", "DIX", "VALET", "DAME", "ROI" };
	std::cout << " " << valeur[this->_valeur - 1] << " de " << couleur[this->_couleur - 1] << " (" << this->_valeur << "," << this->_couleur << ")" << std::endl;
}

void Carte::afficherN() {
	Carte* a;
	a = Carte::_debutN;
	do {
		a->afficher();
	} while (a = a->suc());
}
void Carte::afficherS() {
	Carte* a;
	a = Carte::_debutS;
	do {
		a->afficher();
	} while (a = a->suc());
}

Carte* Carte::suc() {
	return this->_succ;
}

Carte* Carte::getNTete() {
	return Carte::_debutN;
}
Carte* Carte::getSTete() {
	return Carte::_debutS;
}

bool Carte::egale(Carte c) {
	return (this->_valeur == c._valeur);
}
bool Carte::_equal(Carte c) {
	return (this->_valeur == c._valeur && this->_couleur == c._couleur);
}
bool Carte::supAbs(Carte c) {
	return (this->_valeur > c._valeur);
}


void Carte::changerProp() {
	this->_change();
}


void Carte::_change(bool proprietaire) {
	Carte* a;
	Carte* pred = NULL;
	Carte** debut;
	char prop = (proprietaire) ? (this->_proprietaire == 'N') ? 'S' : 'N' : this->_proprietaire;
	debut = (this->_proprietaire == 'N') ? &Carte::_debutN : &Carte::_debutS;
	a = *debut;
	do
	{
		if (this->_equal(*a)) {
			if (pred == NULL) {
				*debut = a->_succ;
			}
			else {
				pred->_succ = a->_succ;
			}
			break;
		}
		pred = a;
	} while (a = a->suc());

	new Carte(this->_couleur, this->_valeur, prop);
}

void Carte::passerDerriere() {
	this->_change(false);
}
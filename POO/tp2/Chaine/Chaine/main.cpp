#include "stdafx.h"
#include "Chaine.h"
#include <iostream>

using namespace std;


int main(int argc, char* argv[])
{
	char* c = "Et il m'a dit : ";
	char* c2 = "Genial la POO, ";
	Chaine chaine1 = Chaine(c);
	Chaine chaine2 = Chaine(c2);
	Chaine chaine3 = Chaine(chaine1);
	cout << "LG : " << chaine1.getLg() << endl;
	cout << ((chaine1 >= chaine2) ? "True" : "False") << endl;
	cout << ((chaine1 == chaine3) ? "True" : "False") << endl;
	cout << chaine1 << endl;
	Chaine* chaine4 = chaine1 + chaine2;
	cout << "Chaine4 : " << *chaine4 << endl;
	*chaine4 += chaine2.sous_chaine(0, chaine2.getLg() - 2);
	cout << "Chaine4 : " << *chaine4 << endl;
	cout << chaine1.sous_chaine(0, 1).getChaine() << endl;
	cout << chaine1[0] << " " << chaine1[1] << " " << chaine1.sous_chaine('b', 'b') << endl;
	cout << chaine1 << endl;
	cout << chaine1.sous_chaine(17, 18) << endl;
	return 0;
}

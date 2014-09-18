#include "stdafx.h"
#include "Chaine.h"
#include <iostream>

using namespace std;


int main(int argc, char* argv[])
{
	char* c = "aba";
	char* c2 = "ba";
	Chaine chaine1 = Chaine(c);
	Chaine chaine2 = Chaine(c2);
	Chaine chaine3 = Chaine(chaine1);
	cout << ((chaine1 >= chaine2) ? "True" : "False") << endl;
	cout << ((chaine1 == chaine3) ? "True" : "False") << endl;
	Chaine chaine4 = *(chaine1 + chaine2);
	cout << (chaine4.getChaine()) << endl;
	cout << chaine1.sous_chaine(0, 1).getChaine() << endl;
	//cout << chaine1 << endl;
	return 0;
}

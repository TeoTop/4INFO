// Exception.cpp : définit le point d'entrée pour l'application console.
//

#include "stdafx.h"
#include "Fraction.h"


int _tmain(int argc, _TCHAR* argv[])
{
	Fraction f1 = Fraction(1, 2);
	//cout << f1 << endl;
	Fraction f2 = Fraction(3, 2);
	//cout << f2 << endl;
	Fraction *f3 = f1 + f2;
	//cout << f1 << " + " << f2 << " = " << *f3 << endl;

	while (1) {
		try {
			cout << f2.eval() << endl;
			f2 *= f2;
		}
		catch (exception& e) {
			cerr << e.what() << endl;
			break;
		}
	}


	int a;
	cin >> a;
	return 0;
}


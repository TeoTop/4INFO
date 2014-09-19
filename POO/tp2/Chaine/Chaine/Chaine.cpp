#include "stdafx.h"
#include "string.h"
#include "Chaine.h"

char* _copie(char* c) {
	char * chaine = (char*)malloc(sizeof(char)*(strlen(c) + 1));
	int i = 0;// c = 'a'
	do {
		chaine[i] = c[i];
	} while (c[i++] != '\0');
	return chaine;
}

Chaine::Chaine() : _chaine("")
{
	cout << "Constructeur1" << endl;
}

Chaine::Chaine(const char * c) {
	cout << "Constructeur2" << endl;
	_chaine = _copie((char*)c);
}

Chaine::Chaine(const Chaine& c) {
	cout << "Constructeur3" << endl;
	_chaine = c.getChaine();
}



Chaine::~Chaine() {
	cout << "Destructeur" << endl;
	delete _chaine;
}
char* Chaine::getChaine() const {
	return _chaine;
}

int Chaine::getLg() const {
	const char* s;
	for (s = _chaine; *s; ++s);
	return s - _chaine;
}
Chaine& Chaine::setChaine(const char* c) {
	_chaine = _copie((char*)c);
	return *this;
}
Chaine& Chaine::setChaine(const Chaine& c) {
	_chaine = _copie(c.getChaine());
	return *this;
}
Chaine Chaine::sous_chaine(char deb, char fin) const {
	char* res;
	bool flag = false;
	int i,j;
	res = (char*)malloc(2*sizeof(char));
	for (i = 0, j = 0; _chaine[i] != '\0'; i++) {
		if (_chaine[i] == deb) {
			flag = true;
		}
		if (flag) {
			res[j++] = _chaine[i];
			res = (char*)realloc(res, (j+2)*sizeof(char));
		}
		if (_chaine[i] == fin) {
			break;
		}
	}
	res[j] = '\0';
	return Chaine(res);
}
Chaine Chaine::sous_chaine(int ind1, int ind2) const {
	char* res;
	int lg = getLg();
	if (ind1 > lg)
		return Chaine();
	int end = (ind2 > lg) ? lg : ind2;
	res = (char*)malloc((end - ind1 + 1)*sizeof(char));
	for (int i = ind1, j = 0; i < end; i++) {
		res[j++] = _chaine[i];
	}
	res[end] = '\0';
	return Chaine(res);
}
char& Chaine::operator[](int i) const {
	return _chaine[i];
}

ostream& Chaine::print(ostream& os) {
	return os << _chaine;
}


bool operator==(const Chaine& c1, const Chaine& c2) {
	return (strcmp(c1._chaine, c2._chaine) == 0);
}
bool operator>=(const Chaine& c1, const Chaine& c2) {
	return (strcmp(c1._chaine, c2._chaine) >= 0);
}

bool operator<=(const Chaine& c1, const Chaine& c2) {
	return (strcmp(c1._chaine, c2._chaine) <= 0);
}

bool operator>(const Chaine& c1, const Chaine& c2) {
	return (strcmp(c1._chaine, c2._chaine) > 0);
}


bool operator<(const Chaine& c1, const Chaine& c2) {
	return (strcmp(c1._chaine, c2._chaine) < 0);
}


Chaine& operator+=(Chaine& c1, const Chaine& c2) {
	int i = strlen(c1._chaine);
	int j = 0;
	do {
		c1._chaine[i++] = c2._chaine[j];
	} while (c2._chaine[j++] != '\0');
	return c1;
}

Chaine* operator+(const Chaine& c1, const Chaine& c2) {
	Chaine* res = new Chaine();
	res->setChaine(c1);
	*res += c2;
	return res;
}

ostream& operator<<(ostream& os, Chaine& c) {
	return c.print(os);
}
#include "stdafx.h"
#include "string.h"
#include "Chaine.h"

char* _copie(char* c, int lg) {
	char * chaine = (char*)malloc(sizeof(char)*(lg + 1));
	int i;
	for (i = 0; i < lg; i++) {
		chaine[i] = c[i];
	}
	chaine[i] = '\0';
	return chaine;
}

Chaine::Chaine() : _lg(0), _chaine("")
{
	cout << "Constructeur1" << endl;
}

Chaine::Chaine(const char * c) {
	cout << "Constructeur2" << endl;
	_lg = strlen((char*)c);
	_chaine = _copie((char*)c, _lg);
}

Chaine::Chaine(const Chaine& c) {
	cout << "Constructeur3" << endl;
	_chaine = c.getChaine();
	_lg = c.getLg();
}



Chaine::~Chaine() {
	cout << "Destructeur" << endl;
	delete &_lg;
	delete _chaine;
}
char* Chaine::getChaine() const {
	return _chaine;
}
int Chaine::getLg() const {
	return _lg;
}
Chaine& Chaine::setChaine(const char* c) {
	_lg = strlen((char*)*c);
	_chaine = _copie((char*)c, _lg);
	return *this;
}
Chaine& Chaine::setChaine(const Chaine& c) {
	_chaine = c.getChaine();
	_lg = c.getLg();
	return *this;
}
Chaine Chaine::sous_chaine(char deb, char fin) const {
	char* res;
	bool flag = false;
	res = (char*)malloc(2*sizeof(char));
	for (int i = 0,j = 0; i < _lg; i++) {
		if (_chaine[i] == deb) {
			flag = true;
		}
		if (flag) {
			res[j++] = _chaine[i];
			res = (char*)realloc(res, (j+2)*sizeof(char));
		}
		if (_chaine[i] == fin) {
			res[i + 1] = '\0';
			break;
		}
	}
	return *new Chaine(res);
}
Chaine Chaine::sous_chaine(int ind1, int ind2) const {
	char* res;
	if (ind1 > _lg)
		return NULL;
	int end = (ind2 > _lg) ? _lg : ind2;
	res = (char*)malloc((end - ind1 + 1)*sizeof(char));
	for (int i = ind1, j = 0; i < end; i++) {
		res[j++] = _chaine[i];
	}
	res[end] = '\0';
	return *new Chaine(res);
}
char& Chaine::operator[](int i) const {
	return _chaine[i];
}

ostream& Chaine::print(ostream& os) {
	return os << _chaine;
}
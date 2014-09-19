#ifndef CHAINE_H
#define CHAINE_H
#include "iostream"
using namespace std;
class Chaine {
	char* _chaine;
public:
	Chaine();
	Chaine(const char* c);
	Chaine(const Chaine& c);
	~Chaine();
	char* getChaine() const;
	Chaine& setChaine(const char* c);
	Chaine& setChaine(const Chaine& c);
	ostream& print(ostream& os);
	Chaine sous_chaine(char deb, char fin) const;
	Chaine sous_chaine(int ind1, int ind2) const;
	int getLg() const;
	char& operator[](int i) const;

	friend bool operator==(const Chaine& c1, const Chaine& c2);
	friend bool operator>=(const Chaine& c1, const Chaine& c2);
	friend bool operator<=(const Chaine& c1, const Chaine& c2);
	friend bool operator>(const Chaine& c1, const Chaine& c2);
	friend bool operator<(const Chaine& c1, const Chaine& c2);
	friend Chaine& operator+=(Chaine& c1, const Chaine& c2);
	friend Chaine* operator+(const Chaine& c1, const Chaine& c2);
	friend ostream& operator<<(ostream& os, Chaine& c);
};
#endif
#ifndef CHAINE_H
#define CHAINE_H
#include "iostream"
using namespace std;
class Chaine {
public:
	char* _chaine;
	int _lg;
	Chaine();
	Chaine(const char* c);
	Chaine(const Chaine& c);
	~Chaine();
	char* getChaine() const;
	int getLg() const;
	Chaine& setChaine(const char* c);
	Chaine& setChaine(const Chaine& c);
	ostream& print(ostream& os);
	Chaine sous_chaine(char deb, char fin) const;
	Chaine sous_chaine(int ind1, int ind2) const;


	inline friend bool operator==(const Chaine& c1, const Chaine& c2) {
		return (strcmp(c1._chaine, c2._chaine) == 0);
	}
	inline friend bool operator>=(const Chaine& c1, const Chaine& c2) {
		return (strcmp(c1._chaine, c2._chaine) >= 0);
	}

	inline friend bool operator<=(const Chaine& c1, const Chaine& c2) {
		return (strcmp(c1._chaine, c2._chaine) <= 0);
	}

	inline friend bool operator>(const Chaine& c1, const Chaine& c2) {
		return (strcmp(c1._chaine, c2._chaine) > 0);
	}


	inline friend bool operator<(const Chaine& c1, const Chaine& c2) {
		return (strcmp(c1._chaine, c2._chaine) < 0);
	}


	inline friend Chaine& operator+=(Chaine& c1, const Chaine& c2) {
		int lg = c1._lg + c2._lg;
		for (int i = c1._lg, j = 0; i < lg; i++, j++) {
			c1._chaine[i] = c2._chaine[j];
		}
		c1._chaine[lg] = '\0';
		c1._lg = lg;
		return c1;
	}

	inline friend Chaine* operator+(const Chaine& c1, const Chaine& c2) {
		Chaine* res = new Chaine(c1);
		*res += c2;
		return res;
	}
	char& operator[](int i) const;
};

/*ostream& operator<<(ostream& os, Chaine& c) {
	return c.print(os);
}*/
#endif
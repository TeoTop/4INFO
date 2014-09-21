#ifndef CHAINE_H
#define CHAINE_H
#include "iostream"
using namespace std;
class Chaine {
	char* _chaine;
public:
	/**
	 * \fn Chaine()
	 * \brief Chaine constructor without parameters
	 */
	Chaine();
	/**
	 * \fn Chaine(const char* c)
	 * \brief Chaine constructor with an array of character as parameter
	 * \param[in] c array of character
	 */
	Chaine(const char* c);
	/**
	 * \fn Chaine(const Chaine& c)
	 * \brief Chaine constructor with a parameter
	 * \param[in] c Chaine
	 */
	Chaine(const Chaine& c);
	/**
	 * \fn ~Chaine()
	 * \brief Chaine destructor
	 */
	~Chaine();
	/**
	 * \fn char* getChaine() const
	 * \brief Getter of _chaine attribute
	 * \return char* _chaine
	 */
	char* getChaine() const;
	/**
	 * \fn int getLg() const
	 * \brief Return length of the string
	 * \return int
	 */
	int getLg() const;
	/**
	 * \fn Chaine& setChaine(const char* c)
	 * \brief Setter of _chaine attribute
	 * \param[in] c array of character
	 * \return Chaine&
	 */
	Chaine& setChaine(const char* c);
	/**
	 * \fn Chaine& setChaine(const Chaine& c)
	 * \brief Setter of _chaine attribute
	 * \param[in] c Chaine&
	 * \return Chaine&
	 */
	Chaine& setChaine(const Chaine& c);
	/**
	 * \fn ostream& print(ostream& os)
	 * \brief Display Chaine object
	 * \param[in,out] os output stream 
	 * \return ostream& reference of output stream
	 */
	ostream& print(ostream& os);
	/**
	 * \fn Chaine sous_chaine(char deb, char fin) const
	 * \brief Return a substring of _chaine
	 * Return Chaine object created from substring of _chaine using deb
	 * as the first character and fin the last one
	 * \param[in] deb first character
	 * \param[in] fin last character
	 * \return Chaine
	 */
	Chaine sous_chaine(char deb, char fin) const;
	/**
	 * \fn Chaine sous_chaine(char deb, char fin) const
	 * \brief Return a substring of _chaine
	 * Return Chaine object created from substring of _chaine using ind1
	 * as the first index and ind2 the last one
	 * \param[in] ind1 first index
	 * \param[in] ind2 last index
	 * \return Chaine
	 */
	Chaine sous_chaine(int ind1, int ind2) const;
	/**
	 * \fn char& operator[](int i) const
	 * \brief Overloads subscripting operator
	 * Return the character that's in the index i given as parameter
	 * \param[in] i index
	 * \return char&
	 */
	char& operator[](int i) const;
	/**
	 * \fn friend bool operator==(const Chaine& c1, const Chaine& c2)
	 * \brief Overloads == operator
	 * Return true if c1 is equal to c2, false otherwise
	 * \param[in] c1 Chaine&
	 * \param[in] c2 Chaine&
	 * \return bool
	 */
	friend bool operator==(const Chaine& c1, const Chaine& c2);
	/**
	 * \fn friend bool operator>=(const Chaine& c1, const Chaine& c2)
	 * \brief Overloads >= operator
	 * Return true if c1 is superior or equal to c2, false otherwise
	 * \param[in] c1 Chaine&
	 * \param[in] c2 Chaine&
	 * \return bool
	 */
	friend bool operator>=(const Chaine& c1, const Chaine& c2);
	/**
	 * \fn friend bool operator<=(const Chaine& c1, const Chaine& c2)
	 * \brief Overloads <= operator
	 * Return true if c1 is less or equal to c2, false otherwise
	 * \param[in] c1 Chaine&
	 * \param[in] c2 Chaine&
	 * \return bool
	 */
	friend bool operator<=(const Chaine& c1, const Chaine& c2);
	/**
	 * \fn friend bool operator>(const Chaine& c1, const Chaine& c2)
	 * \brief Overloads > operator
	 * Return true if c1 is superior to c2, false otherwise
	 * \param[in] c1 Chaine&
	 * \param[in] c2 Chaine&
	 * \return bool
	 */
	friend bool operator>(const Chaine& c1, const Chaine& c2);
	/**
	 * \fn friend bool operator<(const Chaine& c1, const Chaine& c2)
	 * \brief Overloads < operator
	 * Return true if c1 is less to c2, false otherwise
	 * \param[in] c1 Chaine&
	 * \param[in] c2 Chaine&
	 * \return bool
	 */
	friend bool operator<(const Chaine& c1, const Chaine& c2);
	/**
	 * \fn friend bool operator+=(const Chaine& c1, const Chaine& c2)
	 * \brief Overloads += operator
	 * Return concatenation of c1 and c2
	 * \param[in,out] c1 Chaine&
	 * \param[in] c2 Chaine&
	 * \return Chaine&
	 */
	friend Chaine& operator+=(Chaine& c1, const Chaine& c2);
	/**
	 * \fn friend bool operator+(const Chaine& c1, const Chaine& c2)
	 * \brief Overloads + operator
	 * Return concatenation of c1 and c2
	 * \param[in,out] c1 Chaine&
	 * \param[in] c2 Chaine&
	 * \return Chaine*
	 */
	friend Chaine* operator+(const Chaine& c1, const Chaine& c2);
	/**
	 * \fn friend bool operator<<(const Chaine& c1, const Chaine& c2)
	 * \brief Overloads << operator
	 * Return output stream to display Chaine object
	 * \param[in,out] os ostream&
	 * \param[in] c Chaine&
	 * \return ostream&
	 */
	friend ostream& operator<<(ostream& os, Chaine& c);
};
#endif

#ifndef FRACTION_H
#define FRACTION_H
#include <algorithm>
#include <exception>
#include <iostream>
using namespace std;
class Fraction
{	
	int _num;/*<!Numerator>*/
	int _den;/*<!Denominator>*/
	/**
	 * \fn ostream& print(ostream& os)
	 * \brief Display Fraction object
	 * \param[in,out] os output stream 
	 * \return ostream& reference of output stream
	 */
	ostream& _print(ostream& os);
public:
	/**
	* \fn Fraction()
	* \brief Fraction constructor without parameters
	*/
	Fraction();
	/**
	* \fn Fraction(const int num, const int den)
	* \brief Fraction constructor with parameters
	* \param[in] num : fraction's numerator
	* \param[in] den : fraction's denominator
	*/
	Fraction(const int num, const int den);
	/**
	* \fn Fraction(const Fraction& f)
	* \brief Fraction copy constructor
	* \param[in] f : fraction
	*/
	Fraction(const Fraction &f);
	/**
	* \fn int getNum() const
	* \brief Getter of _num
	* \return int
	*/
	int getNum() const;
	/**
	* \fn int getNum() const
	* \brief Getter of _den
	* \return int
	*/
	int getDen() const;
	/**
	* \fn double eval() const;
	* \brief Give the real value in double of the fraction
	* \return double
	*/
	double eval() const;
	/**
	* \fn Fraction& simplifier()
	* \brief Simplify a fraction
	* \return void
	*/
	Fraction& simplifier();
	/**
	* \fn friend Fraction& operator+=(Fraction& f1, const Fraction f2)
	* \brief Overloads += operator
	* Return the addition between two fractions
	* \param[in,out] f1 Fraction&
	* \param[in] f2 Fraction&
	* \return Fraction&
	*/
	friend Fraction& operator+=(Fraction& f1, const Fraction f2);
	/**
	* \fn friend Fraction& operator+(const Fraction& f1, const Fraction f2)
	* \brief Overloads + operator
	* Return the addition between two fractions
	* \param[in] f1 Fraction&
	* \param[in] f2 Fraction&
	* \return Fraction*
	*/
	friend Fraction* operator+(const Fraction& f1, const Fraction f2);
	/**
	* \fn friend Fraction& operator-=(Fraction& f1, const Fraction f2)
	* \brief Overloads -= operator
	* Return the substraction between two fractions
	* \param[in,out] f1 Fraction&
	* \param[in] f2 Fraction&
	* \return Fraction&
	*/
	friend Fraction& operator-=(Fraction& f1, const Fraction f2);
	/**
	* \fn friend Fraction& operator-(const Fraction& f1, const Fraction f2)
	* \brief Overloads - operator
	* Return the substraction between two fractions
	* \param[in] f1 Fraction&
	* \param[in] f2 Fraction&
	* \return Fraction*
	*/
	friend Fraction* operator-(const Fraction& f1, const Fraction f2);
	/**
	* \fn friend Fraction& operator*=(Fraction& f1, const Fraction f2)
	* \brief Overloads *= operator
	* Return the multiplication between two fractions
	* \param[in,out] f1 Fraction&
	* \param[in] f2 Fraction&
	* \return Fraction&
	*/
	friend Fraction& operator*=(Fraction& f1, const Fraction f2);
	/**
	* \fn friend Fraction& operator*(const Fraction& f1, const Fraction f2)
	* \brief Overloads * operator
	* Return the multiplication between two fractions
	* \param[in] f1 Fraction&
	* \param[in] f2 Fraction&
	* \return Fraction*
	*/
	friend Fraction* operator*(const Fraction& f1, const Fraction f2);
	/**
	* \fn friend Fraction& operator/=(Fraction& f1, const Fraction f2)
	* \brief Overloads /= operator
	* Return the division between two fractions
	* \param[in,out] f1 Fraction&
	* \param[in] f2 Fraction&
	* \return Fraction&
	*/
	friend Fraction& operator/=(Fraction& f1, const Fraction f2);
	/**
	* \fn friend Fraction& operator/(const Fraction& f1, const Fraction f2)
	* \brief Overloads / operator
	* Return the division between two fractions
	* \param[in] f1 Fraction&
	* \param[in] f2 Fraction&
	* \return Fraction*
	*/
	friend Fraction* operator/(const Fraction& f1, const Fraction f2);
	/**
	* \fn friend bool operator<<(ostream& os, Fraction& f)
	* \brief Overloads << operator
	* Return output stream to display Fraction object
	* \param[in,out] os ostream&
	* \param[in] f Fraction&
	* \return ostream&
	*/
	friend ostream& operator<<(ostream& os, Fraction& f);
};
enum Over{PLUS, MULT};
#endif
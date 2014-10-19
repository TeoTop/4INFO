#pragma once
#include "stdafx.h"
#include "list.h"

using namespace std;
template <class T>
// == operator required
class Ensemble {
private:
	List<T> _ensemble;/*<! Set >*/
	/**
	 * \fn ostream& _print(ostream& os)
	 * \brief Display Ensemble object
	 * \param[in,out] os output stream 
	 * \return ostream& reference of output stream
	 */
	ostream& _print(ostream& os) {
		return os << _ensemble;
	}
public:
	/**
	* \fn Ensemble<T>()
	* \brief Ensemble<T> default constructor
	*/
	Ensemble<T>():_ensemble() {}
	/**
	* \fn Ensemble<T>(const Ensemble<T>& e)
	* \brief Ensemble<T> copy constructor
	* \param[in] e : Ensemble
	*/
	Ensemble<T>(const Ensemble<T>& e):_ensemble(e._ensemble) {}

	/**
	* \fn bool exists(T value)
	* \brief Test whether value exists in the set or not
	* \param[in] value : T
	* \return Return true if value exist in the set, false otherwise
	*/
	bool exists(T value) {
		for (ListIterator<T> it = _ensemble.beg(); !it.finished(); ++it){
			if (it.get() == value)
			{
				return true;
			}
		}
		return false;
	}

	/**
	* \fn friend Ensemble<T>& operator+=(Ensemble<T>& e1, Ensemble<T> e2)
	* \brief Overloads += operator
	* Return the union between two sets
	* \param[in,out] e1 Ensemble<T>&
	* \param[in] e2 Ensemble<T>&
	* \return Ensemble<T>&
	*/
	friend Ensemble<T>& operator+=(Ensemble<T>& e1, Ensemble<T>& e2) {
		for (ListIterator<T> it = e2._ensemble.beg(); !it.finished(); ++it)
		{
			if (!e1.exists(it.get()))
			{
				e1._ensemble.addElement(it.get()/*, List<T>::LP_last*/); // we can't access LP_last beacause it's protected
			}
		}
		return e1;
	}

	/**
	* \fn friend Ensemble<T> operator+(const Ensemble<T>& e1, Ensemble<T> e2)
	* \brief Overloads + operator
	* Return the union between two sets
	* \param[in,out] e1 Ensemble<T>&
	* \param[in] e2 Ensemble<T>&
	* \return Ensemble<T>
	*/
	friend Ensemble<T> operator+(const Ensemble<T>& e1, Ensemble<T>& e2) {
		Ensemble<T> e3(e1);
		return e3 += e2;
	}

	/**
	* \fn friend Ensemble<T>& operator-=(Ensemble<T>& e1, Ensemble<T> e2)
	* \brief Overloads -= operator
	* Return the substruction between two sets
	* \param[in,out] e1 Ensemble<T>&
	* \param[in] e2 Ensemble<T>&
	* \return Ensemble<T>&
	*/
	friend Ensemble<T>& operator-=(Ensemble<T>& e1, Ensemble<T>& e2){
		for (ListIterator<T> it = e2._ensemble.beg(); !it.finished(); ++it)
		{
			e1._ensemble.delElement(it.get());
		}
		return e1;
	}

	/**
	* \fn friend Ensemble<T> operator-(const Ensemble<T>& e1, Ensemble<T> e2)
	* \brief Overloads - operator
	* Return the substruction between two sets
	* \param[in,out] e1 Ensemble<T>&
	* \param[in] e2 Ensemble<T>&
	* \return Ensemble<T>
	*/
	friend Ensemble<T> operator-(const Ensemble<T>& e1, Ensemble<T>& e2){
		Ensemble<T> e3(e1);
		return e3 -= e2;
	}

	/**
	* \fn friend Ensemble<T>& operator*=(Ensemble<T>& e1, Ensemble<T> e2)
	* \brief Overloads *= operator
	* Return the intersection between two sets
	* \param[in,out] e1 Ensemble<T>&
	* \param[in] e2 Ensemble<T>&
	* \return Ensemble<T>&
	*/
	friend Ensemble<T>& operator*=(Ensemble<T>& e1, Ensemble<T>& e2) {
		Ensemble e3(e1);
		for (ListIterator<T> it = e3._ensemble.beg(); !it.finished(); ++it)
		{
			if (!e2.exists(it.get()))
			{
				e1._ensemble.delElement(it.get());
			}
		}
		return e1;
	}

	/**
	* \fn friend Ensemble<T> operator*(const Ensemble<T>& e1, Ensemble<T> e2)
	* \brief Overloads * operator
	* Return the intersection between two sets
	* \param[in,out] e1 Ensemble<T>&
	* \param[in] e2 Ensemble<T>&
	* \return Ensemble<T>
	*/
	friend Ensemble<T> operator*(const Ensemble<T>& e1, Ensemble<T>& e2) {
		Ensemble<T> e3(e1);
		return e3 *= e2;
	}
	
	/**
	* \fn friend Ensemble<T>& operator/=(Ensemble<T>& e1, Ensemble<T> e2)
	* \brief Overloads /= operator
	* Return the difference between two sets
	* \param[in,out] e1 Ensemble<T>&
	* \param[in] e2 Ensemble<T>&
	* \return Ensemble<T>&
	*/
	friend Ensemble<T>& operator/=(Ensemble<T>& e1, Ensemble<T>& e2){
		return e1 = (e1 + e2) - (e1 * e2);
	}

	/**
	* \fn friend Ensemble<T> operator/(const Ensemble<T>& e1, Ensemble<T> e2)
	* \brief Overloads / operator
	* Return the difference between two sets
	* \param[in,out] e1 Ensemble<T>&
	* \param[in] e2 Ensemble<T>&
	* \return Ensemble<T>
	*/
	friend Ensemble<T> operator/(const Ensemble<T>& e1, Ensemble<T>& e2){
		Ensemble<T> e3(e1);
		return e3 /= e2;
	}

	/**
	* \fn template<typename T> friend istream& operator>>(istream& os, Ensemble<T>& f)
	* \brief Overloads >> operator
	* Read Ensemble object
	* \param[in,out] os istream&
	* \param[in] f Ensemble&
	* \return istream&
	*/
	template<typename T> friend istream& operator>>(istream& is, Ensemble<T>& e);

	/**
	* \fn template<typename T> friend ostream& operator<<(ostream& os, Ensemble<T>& f)
	* \brief Overloads << operator
	* Return output stream to display Ensemble object
	* \param[in,out] os ostream&
	* \param[in] f Ensemble&
	* \return ostream&
	*/
	template<typename T> friend ostream& operator<<(ostream& os, Ensemble<T>& e);

};
template <class T>
istream& operator>>(istream& is, Ensemble<T>& e){
	return is >> e._ensemble;
}
template <class T>
ostream& operator<<(ostream& os, Ensemble<T>& e) {
	return e._print(os);
}
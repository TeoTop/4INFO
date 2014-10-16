#pragma once
#include "stdafx.h"
#include "list.h"

using namespace std;
template <class T>
// == operator required
class Ensemble {
private:
	List<T> _ensemble;
	ostream& _print(ostream& os) {
		return os << _ensemble;
	}
public:
	Ensemble<T>():_ensemble() {}
	Ensemble<T>(const Ensemble<T>& e):_ensemble(e._ensemble) {}
	~Ensemble<T>(){}

	bool exists(T value) {
		for (ListIterator<T> it = _ensemble.beg(); !it.finished(); ++it){
			if (it.get() == value)
			{
				return true;
			}
		}
		return false;
	}

	friend Ensemble<T>& operator+=(Ensemble<T>& e1, Ensemble<T>& e2) {
		for (ListIterator<T> it = e2._ensemble.beg(); !it.finished(); ++it)
		{
			if (!e1.exists(it.get()))
			{
				e1._ensemble.addElement(it.get()/*, List<T>::LP_last*/);
			}
		}
		return e1;
	}
	friend Ensemble<T> operator+(const Ensemble<T>& e1, Ensemble<T>& e2) {
		Ensemble<T> e3(e1);
		return e3 += e2;
	}

	friend Ensemble<T>& operator-=(Ensemble<T>& e1, Ensemble<T>& e2){
		for (ListIterator<T> it = e2._ensemble.beg(); !it.finished(); ++it)
		{
			e1._ensemble.delElement(it.get());
		}
		return e1;
	}
	friend Ensemble<T> operator-(const Ensemble<T>& e1, Ensemble<T>& e2){
		Ensemble<T> e3(e1);
		return e3 -= e2;
	}

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
	friend Ensemble<T> operator*(const Ensemble<T>& e1, Ensemble<T>& e2) {
		Ensemble<T> e3(e1);
		return e3 *= e2;
	}
	
	friend Ensemble<T>& operator/=(Ensemble<T>& e1, Ensemble<T>& e2){
		return e1 = (e1 + e2) - (e1 * e2);
	}
	friend Ensemble<T> operator/(const Ensemble<T>& e1, Ensemble<T>& e2){
		Ensemble<T> e3(e1);
		return e3 /= e2;
	}
	template<typename T> friend istream& operator>>(istream& is, Ensemble<T>& e);
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
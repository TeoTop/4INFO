#include "stdafx.h"
#include "Fraction.h"

Fraction::Fraction() :_num(0), _den(1){}
Fraction::Fraction(const int num, const int den) : _num(num), _den(den){
	if (_den == 0)
	{
		throw exception("The denominator must be not equal to 0");
	}
}
Fraction::Fraction(const Fraction& f) {
	_num = f.getNum();
	_den = f.getDen();
}
int Fraction::getNum() const {
	return _num;
}
int Fraction::getDen() const {
	return _den;
}
double Fraction::eval() const {
	return (double) _num / _den;
}
int pgcd(int a, int b) {
	int d = abs(a - b);
	if (d == 0) {
		return a;
	}
	else {
		return pgcd(min(a, b), d);
	}
}
Fraction& Fraction::simplifier() {
	int a;
	while ((a = pgcd(_num, _den)) != 1) {
		_num /= a;
		_den /= a;
	}
	return *this;
}
void testOverflow(int a, int b, int operation) {
	char sign = a > 0 && b > 0 ? 1 : a < 0 && b < 0 ? -1 : 0;
	int sum;
	switch (operation) {
	case PLUS:
		sum = a + b;
		break;
	case MULT:
		sum = a * b;
		break;
	}
	if (sign && sign == 1 && sum < 0 || sign == -1 && sum > 0){
		throw exception("Overflow occured");
	}
}
Fraction& operator+=(Fraction& f1, const Fraction f2) {
	testOverflow(f1._num, f2._den, MULT);
	int a = f1._num * f2._den;
	testOverflow(f2._num, f1._den, MULT);
	int b = f2._num * f1._den;
	testOverflow(a, b, PLUS);
	f1._num = a + b;
	testOverflow(f1._den, f2._den, MULT);
	f1._den *= f2._den;
	f1.simplifier();
	return f1;
}
Fraction* operator+(const Fraction& f1, const Fraction f2) {
	Fraction* f3 = new Fraction(f1);
	*f3 += f2;
	return f3;
}
Fraction& operator-=(Fraction& f1, const Fraction f2) {
	Fraction f3 = Fraction(-f2._num, f2._den);
	f1 += f3;
	return f1;
}
Fraction* operator-(const Fraction& f1, const Fraction f2) {
	Fraction* f3 = new Fraction(f1);
	*f3 -= f2;
	return f3;
}
Fraction& operator*=(Fraction& f1, const Fraction f2) {
	testOverflow(f1._num, f2._num, MULT);
	f1._num *= f2._num;
	testOverflow(f1._den, f2._den, MULT);
	f1._den *= f2._den;
	f1.simplifier();
	return f1;
}
Fraction* operator*(const Fraction& f1, const Fraction f2) {
	Fraction* f3 = new Fraction(f1);
	*f3 *= f2;
	return f3;
}
Fraction& operator/=(Fraction& f1, const Fraction f2) {
	Fraction f3 = Fraction(f2._den, f2._num);
	f1 *= f3;
	return f1;
}
Fraction* operator/(const Fraction& f1, const Fraction f2) {
	Fraction* f3 = new Fraction(f1);
	*f3 /= f2;
	return f3;
}
ostream& Fraction::_print(ostream& os) {
	return os << _num << "/" << _den;
}
ostream& operator<<(ostream& os, Fraction& f) {
	return f._print(os);
}
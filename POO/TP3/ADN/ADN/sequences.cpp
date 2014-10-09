/*!
 * \file  sequences.cpp
 * \brief  Sequences reading 
 * \date to be updated
 * \author to be updated
*/
#include "stdafx.h"
#include "sequences.h"

using namespace std;

ostream & operator<< (ostream & os, const seqmac & s) 
{
    s.writeseq(os);
    return os;
}

seqmac::seqmac(const string & seq, const string & name, const string & alphabet) : 
  _alph(alphabet), _name(name) 
{
    string s="";
    for(string::const_iterator c = seq.begin();c != seq.end(); c++ ) 
    {
		if (_alph.is_in_alpha(*c)) { s += *c; }
		// exception
		else {
			stringstream e;
			e << *c << " is not in the alphabet";
			throw exception(e.str().c_str());
		}
    }
	// exception
	if ((s.length() % 3) != 0)
	{
		throw exception("Wrong number of bases");
	}
    _seq = s;
}

void testStartStop(const string& seq, string& t) {
	bool start = false;
	bool stop = false;
	bool flag = false;
	for (string::const_iterator c = seq.begin(); c != seq.end() - 2; c++) {
		stringstream codonStream;
		string codon;
		codonStream << *c << *(c + 1) << *(c + 2);
		codon = codonStream.str();
		if (codon == "A" + t + "G")
		{
			if (start)
			{
				throw exception("STOP missing after START");
			}
			start = true;
			stop = false;
			flag = false;
			c += 2;
		}
		if (codon == t + "AA" || codon == t + "GA" || codon == t + "AG") {
			if (!start)
			{
				throw exception("STOP before START");
			}
			start = false;
			stop = true;
			flag = true;
			c += 2;
			if (c > seq.end() - 2) {
				break;
			}
		}
	}
	if (start && !stop)
	{
		throw exception("STOP missing after START");
	}
	if (!flag)
	{
		throw exception("START and STOP missing");
	}
}

seqadn::seqadn(const string & seq, const string & name) : seqmac(seq,name,"CGAT")
{
	string T = "T";
	// exception
	testStartStop(seq, T);
}

seqarn::seqarn(const string & seq, const string & name) : seqmac(seq,name,"ACGU") 
{
	string U = "U";
	// exception
	testStartStop(seq, U);
}

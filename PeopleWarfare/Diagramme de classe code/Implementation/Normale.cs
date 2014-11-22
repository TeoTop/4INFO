using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class Normale : StrategieCarte
    {
        public Normale()
        {
            cases = new List<CaseA>();
            nbCase = 100;
            type = (int)EnumCarte.PETITE;
        }

        public override int type
        {
            get;
            set;
        }

        public override int nbCase
        {
            get;
            set;
        }
    }
}

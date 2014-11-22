using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class Demo : StrategieCarte
    {
        public Demo()
        {
            cases = new List<CaseA>();
            nbCase = 36;
            type = (int) EnumCarte.DEMO;
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

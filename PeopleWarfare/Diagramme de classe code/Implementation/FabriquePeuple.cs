using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class FabriquePeuple
    {
        public static FabriquePeuple INSTANCE = new FabriquePeuple();
        private FabriquePeuple()
        {
            throw new System.NotImplementedException();
        }

        public static Peuple creerPeuple(string p)
        {
            throw new System.NotImplementedException();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class FabriqueCase
    {
        private Dictionary<int, Case> Cases
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public static FabriqueCase INSTANCE = new FabriqueCase();
        private FabriqueCase()
        {
        }

        public Case obtenirCase(int cle)
        {
            //creer la case quand la clé est null (-1)
            throw new System.NotImplementedException();
        }

        private Case creerCase()
        {
            throw new System.NotImplementedException();
        }
    }
}

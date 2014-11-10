using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public abstract class StrategieCarte : Carte
    {

        public System.Collections.Generic.List<PeopleWar.CaseA> cases
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public Carte creerCarte()
        {
            throw new System.NotImplementedException();
        }
    }
}

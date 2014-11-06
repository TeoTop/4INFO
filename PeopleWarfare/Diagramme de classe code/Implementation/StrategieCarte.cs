using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public abstract class StrategieCarte : Carte
    {
        public CaseA CaseA
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public CaseA CaseA1
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public FabriqueCase FabriqueCase
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

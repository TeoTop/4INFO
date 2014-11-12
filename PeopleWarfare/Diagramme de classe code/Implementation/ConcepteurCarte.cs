using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class ConcepteurCarte
    {
        public static ConcepteurCarte INSTANCE = new ConcepteurCarte();

        private StrategieCarte carte { get; }

        private ConcepteurCarte() { }
        public static void definirCarte(StrategieCarte carte)
        {
            throw new System.NotImplementedException();
        }

        public static Carte creerCarte()
        {
            throw new System.NotImplementedException();
        }
    }
}

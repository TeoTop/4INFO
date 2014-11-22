using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class MonteurNvllePartie : PeopleWar.MonteurPartie
    {
        public MonteurNvllePartie()
        {
        }


        /**
         * Create a map from a type 'carte'
         * @param int carte
         * @return Carte
         */
        public override Carte creerCarte(int carte)
        {
            Carte c = null;
            switch (carte)
            {
                case (int)EnumCarte.DEMO:
                    c = new Demo();
                    break;
                case (int)EnumCarte.PETITE:
                    c = new Normale();
                    break;
                case (int)EnumCarte.NORMALE:
                    c = new Petite();
                    break;
            }
            ConcepteurCarte.INSTANCE.definirCarte(c);
            ConcepteurCarte.INSTANCE.creerCarte();
            return c;
        }

        public override Joueur creerJoueur(string nom, int p, int nbUnite)
        {
            throw new System.NotImplementedException();
        }
    }
}

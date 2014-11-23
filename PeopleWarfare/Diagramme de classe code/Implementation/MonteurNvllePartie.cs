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
         * @param EnumCarte carte
         * @return Carte
         */
        public override Carte creerCarte(EnumCarte carte)
        {
            Carte c = null;
            switch (carte)
            {
                case EnumCarte.DEMO:
                    c = new Demo();
                    break;
                case EnumCarte.PETITE:
                    c = new Normale();
                    break;
                case EnumCarte.NORMALE:
                    c = new Petite();
                    break;
            }
            ConcepteurCarte.INSTANCE.definirCarte(c);
            ConcepteurCarte.INSTANCE.creerCarte();
            return c;
        }

        /**
         * Create a player with his people.
         * @param string nom
         * @param EnumPeuple p
         * @param int nbUnite
         * @return Carte
         */
        public override Joueur creerJoueur(string nom, EnumPeuple p, int nbUnite)
        {
            //On crée le peuple qui sera ensuite associé au joueur. La race est définie par l'énumération p.
            Peuple peuple = FabriquePeuple.INSTANCE.creerPeuple(p, nbUnite);

            //on crée le joueur en lui associant un nom et son peuple
            JoueurImp joueur = new JoueurImp(nom, peuple);

            return joueur;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class DirecteurPartie
    {
        public DirecteurPartie()
        {
        }

        public MonteurPartie MonteurPartie
        {
            get;
            set;
        }
    
        /**
         * Create a game
         * @param int carte
         * @param int p1
         * @param int p2
         * @return Partie
         */
        public Partie creerPartie(int carte, int p1, int p2)
        {
            Carte c = MonteurPartie.creerCarte(carte);
            int nbUnite = 0;
            int nbTourMax = 0;
            switch (carte)
            {
                case (int)EnumCarte.DEMO:
                    nbUnite = 4;
                    nbTourMax = 5;
                    break;
                case (int)EnumCarte.PETITE:
                    nbUnite = 6;
                    nbTourMax = 20;
                    break;
                case (int)EnumCarte.NORMALE:
                    nbUnite = 8;
                    nbTourMax = 30;
                    break;
            }
            Joueur j1 = MonteurPartie.creerJoueur("J1", p1, nbUnite);
            Joueur j2 = MonteurPartie.creerJoueur("J2", p2, nbUnite);
            return new PartieImp(c, j1, j2, nbTourMax);
        }

        /**
         * Define a builder for the game
         * @param MonteurPartie monteurPartie
         * @return void
         */
        public void definirMonteur(MonteurPartie monteurPartie)
        {
            MonteurPartie = monteurPartie;
        }
    }
}

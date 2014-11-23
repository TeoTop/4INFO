using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class DirecteurPartie
    {
        public DirecteurPartie() {}

        public MonteurPartie MonteurPartie { get; set; }

        /**
         * Create a game
         * @param EnumCarte carte
         * @param EnumPeuple p1
         * @param EnumPeuple p2
         * @return Partie
         */
        public Partie creerPartie(String nom1, String nom2, EnumCarte carte, EnumPeuple p1, EnumPeuple p2)
        {
            Carte c = MonteurPartie.creerCarte(carte);
            int nbUnite = 0;
            int nbTourMax = 0;

            switch (carte)
            {
                case EnumCarte.DEMO:
                    nbUnite = 4;
                    nbTourMax = 5;
                    break;
                case EnumCarte.PETITE:
                    nbUnite = 6;
                    nbTourMax = 20;
                    break;
                case EnumCarte.NORMALE:
                    nbUnite = 8;
                    nbTourMax = 30;
                    break;
            }
            Joueur j1 = MonteurPartie.creerJoueur(nom1, p1, nbUnite);
            Joueur j2 = MonteurPartie.creerJoueur(nom2, p2, nbUnite);
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

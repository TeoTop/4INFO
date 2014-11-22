using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class PartieImp : Partie
    {
        /**
         * PartieImp Constructor
         * @param int carte
         * @param int p1
         * @param int p2
         * @param int nbTourMax
         */
        public PartieImp(Carte carte, Joueur j1, Joueur j2, int nbTourMax)
        {
            this.carte = (StrategieCarte)carte;
            this.j1 = (JoueurImp)j1;
            this.j2 = (JoueurImp)j2;
            this.joueurCourant = 0;
            tours = new List<TourImp>();
            this.nbTourMax = nbTourMax;
        }

        public List<PeopleWar.TourImp> tours
        {
            get;
            set;
        }
        
        public StrategieCarte carte
        {
            get;
            set;
        }

        public int nbTourMax
        {
            get;
            set;
        }

        public int x
        {
            get;
            set;
        }

        public int y
        {
            get;
            set;
        }

        public int joueurCourant
        {
            get;
            set;
        }

        public JoueurImp j1
        {
            get;
            set;
        }

        public JoueurImp j2
        {
            get;
            set;
        }

        /**
         * Return one of the two players
         * key = 0 for Player1 and key = 1 for Player2
         * if key != 0 and key != 1, return null
         * @param key
         * @return Joueur|null
         */
        public Joueur getJoueur(int key)
        {
            return (key == 0) ? this.j1 : (key == 1) ? this.j2 : null;
        }

        /**
         * Return the number of rounds
         * @return int
         */
        public int getNbTour()
        {
            return this.tours.Count();
        }

        public bool verifierSelUnite()
        {
            throw new NotImplementedException();
        }

        /**
         * Set x and y of the selected box
         * @param int x
         * @param int y
         * @return void
         */
        public void selectionnerCase(int x, int y)
        {
            this.x = x;
            this.y = y;
        }

        /**
         * Check whether the game is finished
         * If the game has finished, return the player who wins
         * @return Joueur|null
         */
        public Joueur verifierFinPartie()
        {
            if (this.j1.verifierDefaite())
            {
                return this.j2;
            }
            else if (this.j2.verifierDefaite())
            {
                return this.j1;
            }
            else if (this.getNbTour() >= nbTourMax)
            {
                return (this.j1.calculerNbPoint() > this.j2.calculerNbPoint()) ? this.j1 : this.j2;
            }
            return null;
        }

        /**
         * Switch player
         * @return void
         */
        public void switcherJoueur()
        {
            joueurCourant = (joueurCourant + 1) % 2;
        }

        /**
         * Return a round using a key
         * The count begin from 0
         * @param int key
         * @return Tour|null
         */
        public Tour getTour(int key)
        {
            if (isValidTour(key))
            {
                return tours[key];
            }
            return null;
        }

        /**
         * Check if a round is valid
         * @param int key
         * @return Boolean
         */
        public Boolean isValidTour(int key)
        {
            return (key > 0 && key < getNbTour());
        }
    }
}

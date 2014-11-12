using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Partie
    {
        Joueur getJoueur(int key);

        int getNbTour();

        bool verifierSelUnite();

        Partie selectionnerCase(int x, int y);

        bool verifierFinPartie();

        void switcherJoueur();

        Tour getTour(int key);
    }
}

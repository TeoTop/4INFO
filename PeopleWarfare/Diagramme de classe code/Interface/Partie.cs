using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Partie
    {
        Joueur getJoueur(int key);

        Carte getCarte();

        int getNbTour();
    }
}

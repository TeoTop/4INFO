using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Partie
    {
        void creerPartie();

        void recupererCarte();

        void recupererJoueur();
    }
}

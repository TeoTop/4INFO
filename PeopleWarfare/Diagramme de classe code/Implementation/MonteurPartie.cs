using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public abstract class MonteurPartie
    {

        public abstract Carte creerCarte(int carte);

        public abstract Joueur creerJoueur(string nom, int p, int nbUnite);
    }
}

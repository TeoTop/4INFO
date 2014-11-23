using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public abstract class MonteurPartie
    {

        public abstract Carte creerCarte(EnumCarte carte);

        public abstract Joueur creerJoueur(string nom, EnumPeuple p, int nbUnite);
    }
}

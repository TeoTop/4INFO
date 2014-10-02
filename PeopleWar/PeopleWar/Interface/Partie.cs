using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Partie
    {
        Partie creerPartie();

        Carte recupererCarte();

        List<Joueur> recupererJoueur();

        bool sauvegarder();

        Partie charger();
    }
}

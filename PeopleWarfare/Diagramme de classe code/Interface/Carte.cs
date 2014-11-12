using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Carte
    {
        Carte creerCarte();

        Case getCase(int key);

        int getX(int key);

        int getY(int key);

        int getNbCase();
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Carte
    {
        Carte creerCarte();

        String getType();

        int getNbCase();

        List<Case> getCases();

        Case getCase(int key);

        int getX(string key);

        int getY(string key);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Peuple
    {
        Unite uniteSuivante();

        Unite getUnite(int key);

        String getInformation();

        List<Unite> verifierUnite(int x, int y);

        int getNbUnite();
    }
}

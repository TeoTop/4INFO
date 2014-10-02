using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Unite
    {
        bool attaquer(Case Case);

        Case seDeplacer(int x, int y);

        void appliquerCaracterisitique(List<Caracteristique> caracteristique);
    }
}

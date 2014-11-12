using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Unite
    {
        void afficherCaracteristique();

        int getAttEff();

        int getDefEff();

        bool seDeplacer(int x, int y);

        int combattre(Unite uniteAdv);
    }
}

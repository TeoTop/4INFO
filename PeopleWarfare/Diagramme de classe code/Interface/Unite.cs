using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Unite
    {
        void afficherCaracteristique();

        int getX();

        int getY();

        int getVie();

        int getAtt();

        int getAttEff();

        int getDef();

        int getDefEff();
    }
}

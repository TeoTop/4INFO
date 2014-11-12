using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Combat
    {
        Unite getUniteAtt();

        Unite getUniteDef();

        int calculerNbCombat();

        float calculerReussiteAtt();

        int effectuerCombat();

        Unite choisirUniteDef(List<Unite> UnitesDef);
    }
}

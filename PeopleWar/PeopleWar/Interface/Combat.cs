using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Combat
    {
        List<Unite> recupererUnite();

        Joueur vainqueur();
    }
}

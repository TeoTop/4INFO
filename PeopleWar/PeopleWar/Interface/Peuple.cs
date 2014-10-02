using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Peuple
    {
        List<Unite> recupererUnite();

        List<Caracteristique> caracteristique();

        Unite creerUnite();
    }
}

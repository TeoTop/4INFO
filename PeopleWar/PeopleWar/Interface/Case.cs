using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Case
    {
        Unite recupererUnite();

        int getX();

        int getY();
    }
}

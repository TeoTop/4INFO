using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PeopleWar;
class Test
{
    public static void Main(string[] args)
    {
        MonteurPartie m = new MonteurNvllePartie();
        Carte c = m.creerCarte((int)EnumCarte.PETITE);
        Console.WriteLine(c.ToString());
        Console.WriteLine(c.getX(25) + " " + c.getY(25));
        Console.Read();
    }
}

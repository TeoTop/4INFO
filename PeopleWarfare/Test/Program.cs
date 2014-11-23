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
        DirecteurPartie dp = new DirecteurPartie();
        dp.definirMonteur(new MonteurNvllePartie());
        Partie partie = dp.creerPartie("Theo", "Hassan", EnumCarte.PETITE, EnumPeuple.NAIN, EnumPeuple.ELF);

        Console.WriteLine("Test");
        Console.WriteLine(partie.getJoueur(0).ToString());
        Console.WriteLine(partie.getJoueur(1).ToString());

        partie.getJoueur(0).calculerNbPoint();
        partie.getJoueur(0).calculerNbPoint();

        Console.WriteLine(partie.getJoueur(0).ToString());

        Console.WriteLine(partie.getJoueur(0).getPeuple().getInformation());
        Console.WriteLine(partie.getJoueur(1).getPeuple().getInformation());

        Console.WriteLine(partie.getJoueur(0).getPeuple().getUnite(0).afficherCaracteristique());

        Console.WriteLine(partie.getCarte().ToString());
        Console.WriteLine(partie.getCarte().getX(25) + " " + partie.getCarte().getY(25));

        Console.Read();
    }
}

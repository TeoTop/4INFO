﻿using System;
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
        PartieImp partie = dp.creerPartie("Theo", "Hassan", EnumCarte.PETITE, EnumPeuple.ORC, EnumPeuple.ELF);

        Console.WriteLine("Test");
        Console.WriteLine(partie.getJoueur(0).ToString());
        Console.WriteLine(partie.getJoueur(1).ToString());

        partie.getJoueur(0).calculerNbPoint(partie.carte);
        partie.getJoueur(0).calculerNbPoint(partie.carte);

        Console.WriteLine(partie.getJoueur(0).ToString());

        Console.WriteLine(partie.j1.peuple.getInformation());
        Console.WriteLine(partie.j2.peuple.getInformation());

        Console.WriteLine(partie.j1.peuple.getUnite(0).afficherCaracteristique());

        Console.WriteLine(partie.carte.ToString());
        Console.WriteLine(partie.carte.getX(25) + " " + partie.carte.getY(25));

        Console.Read();
    }
}

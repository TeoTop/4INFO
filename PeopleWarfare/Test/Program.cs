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
        int choix = 0;

        while (choix == 0)
        {
            Console.WriteLine("HELLO !!! Bienvenu sur PeopleWarfare\n\n Veuillez choisir entre Nouvelle partie et" +
                    " Charger partie :\n\t (1) Nouvelle partie\n\t (2) Charger partie");
            choix = int.Parse(Console.ReadLine());

            if (choix != 1)
            {
                Console.Clear();
                Console.WriteLine(choix);
                Console.WriteLine("Ce choix n'est pas valide et Charger partie n'est pas encore codé\n");
                choix = 0;
            }
        }

        string nom1 = null;
        string nom2 = null;
        EnumPeuple p1 = EnumPeuple.ORC;
        EnumPeuple p2 = EnumPeuple.ORC;

        configurerJoueur(ref nom1, ref p1);
        configurerJoueur(ref nom2, ref p2);

        EnumCarte carte = choixCarte();



        DirecteurPartie dp = new DirecteurPartie();
        dp.definirMonteur(new MonteurNvllePartie());
        PartieImp partie = dp.creerPartie(nom1, nom2, carte, p1, p2);

        Console.WriteLine("Lets Figth !!!");
        /* Console.WriteLine(partie.getJoueur(0).ToString());
         Console.WriteLine(partie.getJoueur(1).ToString());

         partie.getJoueur(0).calculerNbPoint(partie.carte);
         partie.getJoueur(0).calculerNbPoint(partie.carte);

         Console.WriteLine(partie.getJoueur(0).ToString());

         Console.WriteLine(partie.j1.peuple.getInformation());
         Console.WriteLine(partie.j2.peuple.getInformation());

         Console.WriteLine(partie.j1.peuple.getUnite(0).afficherCaracteristique());

         Console.WriteLine(partie.carte.ToString());
         Console.WriteLine(partie.carte.getX(25) + " " + partie.carte.getY(25));*/

        Console.Read();
    }

    public static void configurerJoueur(ref string nom, ref EnumPeuple peuple)
    {
        Console.Write("Nom du joueur : ");
        nom = Console.ReadLine();

        int choix = 0;
        while (choix < 1 || choix > 3)
        {
            Console.Write("\n\nChoix du peuple ( 1 - Orc ; 2 - Elf ; 3 - Nain ) : ");
            choix = int.Parse(Console.ReadLine()); ;

            switch (choix)
            {
                case 1:
                    peuple = EnumPeuple.ORC;
                    break;
                case 2:
                    peuple = EnumPeuple.ELF;
                    break;
                case 3:
                    peuple = EnumPeuple.NAIN;
                    break;
                default:
                    Console.WriteLine("\nCe choix n'est pas valide !\n");
                    break;
            }
        }
    }

    public static EnumCarte choixCarte()
    {
        int choix = 0;
        while (true)
        {
            Console.Write("\n\nChoix de la carte ( 1 - Demo ; 2 - Petite ; 3 - Normale ) : ");
            choix = int.Parse(Console.ReadLine());

            switch (choix)
            {
                case 1:
                    return EnumCarte.DEMO;
                case 2:
                    return EnumCarte.PETITE;
                case 3:
                    return EnumCarte.NORMALE;
                default:
                    Console.WriteLine("\nCe choix n'est pas valide !\n");
                    break;
            }
        }
    }
}

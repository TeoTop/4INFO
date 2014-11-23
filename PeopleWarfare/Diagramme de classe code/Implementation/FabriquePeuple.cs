using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class FabriquePeuple
    {
        // la fabrique est instanciée et peut être appeler par toute les classes.
        public static FabriquePeuple INSTANCE = new FabriquePeuple();

        private FabriquePeuple() {}

        /**
         * Allows you to create the people with its units.
         * @param int p
         * @param int nbUnite
         * @return Peuple
         */

        public Peuple creerPeuple(EnumPeuple p, int nbUnite)
        {
            // on instancie le peuple à null pour le return.
            PeupleA peuple = null;

            // crée le peuple en fonction de la race p.
            switch (p)
            {
                case EnumPeuple.ORC:
                    peuple = new Orc(nbUnite);
                    break;
                case EnumPeuple.ELF:
                    peuple = new Elf(nbUnite);
                    break;
                case EnumPeuple.NAIN:
                    peuple = new Nain(nbUnite);
                    break;
                default:
                    Console.WriteLine("Erreur : impossible de créer le peuple, erreur dans le peuple associé");
                    break;
            }

            return (Peuple) peuple;
        }
    }
}

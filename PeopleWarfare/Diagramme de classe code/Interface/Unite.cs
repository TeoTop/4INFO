using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public interface Unite
    {
        /**
         * Displays the current characteristics of a unit.
         * @return string
         */
        string afficherCaracteristique();

        /**
         * Returns the attack function of life.
         * @return float
         */
        float getAttEff();

        /**
         * Returns the defense function of life.
         * @return float key
         */
        float getDefEff();

        /**
         * Modifies the box associated with the unit. 
         * True if movement it's done.
         * @param int c
         * @return bool
         */
        bool seDeplacer(int c);

        /**
         * Lets fighting unity against enemy unit.
         * @param Unite uniteAdv
         * @return int
         */
        int combattre(Unite uniteAdv);

        /**
         * Shows whether the unit can reach the box c.
         * True if it's possible
         * @param int x
         * @param int y
         * @return bool
         */
        bool verifierDeplacement(int cInit, int c, int taille, EnumPeuple type, Carte carte, Peuple adv);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class UniteImp : Unite
    {
        public int x { get; set; }
        public int y { get; set; }

        public int attaque { get; set; }

        public int defense { get; set; }

        public int vie { get; set; }

        public int pm { get; set; }

        public int point { get; set; }

        public UniteImp()
        {
            //les statistiques de base sont définie par le jeu
            attaque = 2;
            defense = 1;
            vie = 5;
            pm = 1;
            point = 1;
        }

        public string afficherCaracteristique()
        {
            return "Unite :\n\t- Attaque : " + attaque + "\n\t- Defense : " + defense + "\n\t- Vie : " + vie +
                "\n\t- Point de mouvement : " + pm + "\n\t- Point rapporté : " + point;
        }

        public float getAttEff()
        {
            return attaque * vie / 5;
        }

        public float getDefEff()
        {
            return defense * vie / 5;
        }

        public bool seDeplacer(int x, int y)
        {
            this.x = x;
            this.y = y;

            return true;
        }

        public int combattre(Unite uniteAdv)
        {
            return 1;
        }

        public bool verifierDeplacement(int x, int y)
        {
            if (Math.Abs(this.x - x) < 2 && Math.Abs(this.y - y) < 2) return true;

            return false;

                // !!!!!!!!! vérifier bonus;
        }
    }
}

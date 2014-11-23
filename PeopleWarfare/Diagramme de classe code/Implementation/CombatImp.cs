using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class CombatImp : Combat
    {
        /**
         * @var UniteImp uniteDef
         */ 
        public UniteImp uniteDef
        {
            get;
            set;
        }

        /**
         * @var UniteImp uniteAtt
         */
        public UniteImp uniteAtt
        {
            get;
            set;
        }

        /**
         * Constructor
         * @param Unite uniteAtt
         * @param List<Unite> unitesDef
         */
        public CombatImp(Unite uniteAtt, List<Unite> unitesDef)
        {
            this.uniteAtt = (UniteImp) uniteAtt;
            this.uniteDef = (UniteImp) choisirUniteDef(unitesDef);
        }

        /**
         * Calculate the number of battles
         * @return int
         */
        public int calculerNbCombat()
        {
            Random rnd = new Random();
            int max = (uniteAtt.vie > uniteDef.vie) ? uniteAtt.vie : uniteDef.vie;
            return rnd.Next(3, max + 2);
        }

        /**
         * Calculate the success' probability of the attack
         * Between 0 and 1
         * @return float
         */
        public float calculerReussiteAtt()
        {
            float att = 0,
                  def = 0,
                  taux = ((att = uniteAtt.getAttEff()) > (def = uniteDef.getDefEff())) ? def / att : att / def;
            return 50 * (1 + taux);
        }

        /**
         * Launch a battle
         * @return int
         */
        public int effectuerCombat()
        {
            throw new NotImplementedException();
        }

        /**
         * Choose the item who will defend the box
         * @param List<Unite> unitesDef
         * @return Unite
         */
        public Unite choisirUniteDef(List<Unite> unitesDef)
        {
            if (unitesDef.Count() == 0) throw new ArgumentNullException();
            Unite uniteDef = null;
            foreach (Unite unite in unitesDef)
            {
                if (uniteDef == null || uniteDef.getDefEff() < unite.getDefEff())
                {
                    uniteDef = unite;
                }
            }
            return uniteDef;
        }
    }
}

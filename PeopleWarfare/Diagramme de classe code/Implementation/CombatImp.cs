using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class CombatImp : Combat
    {
        public CombatImp(Unite uniteAtt, List<PeopleWar.Unite> unitesDef)
        {
            throw new System.NotImplementedException();
        }
    
        public UniteImp uniteDef
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public UniteImp uniteAtt
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        Unite Combat.getUniteAtt()
        {
            throw new NotImplementedException();
        }

        Unite Combat.getUniteDef()
        {
            throw new NotImplementedException();
        }

        int Combat.calculerNbCombat()
        {
            throw new NotImplementedException();
        }

        float Combat.calculerReussiteAtt()
        {
            throw new NotImplementedException();
        }

        int Combat.effectuerCombat()
        {
            throw new NotImplementedException();
        }

        Unite Combat.choisirUniteDef(List<Unite> UnitesDef)
        {
            throw new NotImplementedException();
        }
    }
}

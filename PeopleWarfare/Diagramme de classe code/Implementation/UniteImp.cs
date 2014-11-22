using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class UniteImp : Unite
    {
        private int x { get; set; }
        private int y { get; set; }

        public int attaque
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public int defense
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public int vie
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public int pm
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }
    
        public UniteImp()
        {
            throw new System.NotImplementedException();
        }


        void Unite.afficherCaracteristique()
        {
            throw new NotImplementedException();
        }

        int Unite.getAttEff()
        {
            throw new NotImplementedException();
        }

        int Unite.getDefEff()
        {
            throw new NotImplementedException();
        }

        bool Unite.seDeplacer(int x, int y)
        {
            throw new NotImplementedException();
        }

        int Unite.combattre(Unite uniteAdv)
        {
            throw new NotImplementedException();
        }
    }
}

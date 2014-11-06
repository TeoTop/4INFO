using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class FabriqueCase
    { 
        public static FabriqueCase INSTANCE = new FabriqueCase();
        //faire une lazy instancation

        private FabriqueCase()
        {
            Desert = null;
            Foret = null;
            Montagne = null;
            Plaine = null;
        }

        public Desert Desert
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public Foret Foret
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public Montagne Montagne
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public Plaine Plaine
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }
        
        public Case getCase(string type)
        {
            //creer la case quand la clé est null
            throw new System.NotImplementedException();
        }
    }
}

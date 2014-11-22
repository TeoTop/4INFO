using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public abstract class PeupleA : Peuple
    {

        public List<PeopleWar.UniteImp> unites
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        Unite Peuple.uniteSuivante()
        {
            throw new NotImplementedException();
        }

        Unite Peuple.getUnite(int key)
        {
            throw new NotImplementedException();
        }

        string Peuple.getInformation()
        {
            throw new NotImplementedException();
        }

        List<Unite> Peuple.verifierUnite(int x, int y)
        {
            throw new NotImplementedException();
        }

        int Peuple.getNbUnite()
        {
            throw new NotImplementedException();
        }
    }
}

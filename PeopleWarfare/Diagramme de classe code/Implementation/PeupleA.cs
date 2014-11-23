using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public abstract class PeupleA : Peuple
    {
        public int uniteActuel { get; set; }

        public List<PeopleWar.UniteImp> unites { get; set; }

        public Unite getUniteActuel()
        {
            return unites[uniteActuel];
        }

        public Unite uniteSuivante()
        {
            return getUnite(++uniteActuel);
        }

        public Unite getUnite(int key)
        {
            return unites[key];
        }

        public abstract string getInformation();

        public List<Unite> verifierUnite(int x, int y)
        {
            List<Unite> u = null;

            foreach (Unite unite in unites)
            {
                if (unite.getX() == x && unite.getY() == y) u.Add(unite);
            }

            return u;
        }

        public int getNbUnite()
        {
            return unites.Count;
        }

        public void creerUnites(int nbUnite)
        {
            //on instancie la liste d'unités
            unites = new List<UniteImp>();

            //on boucle dur le nombre d'unité pour les instancier et les ajouter à la liste
            for (int i = 0; i < nbUnite; i++)
            {
                unites.Add(new UniteImp());
            }
        }
    }
}

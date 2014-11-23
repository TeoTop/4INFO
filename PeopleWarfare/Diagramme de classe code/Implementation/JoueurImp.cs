using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PeopleWar
{
    public class JoueurImp : Joueur
    {
        public PeupleA peuple { get; set; }

        public int nbPoints { get; set; }

        public String nom { get; set; }

        public JoueurImp(String n, Peuple p)
        {
            nom = n;
            nbPoints = 0;
            peuple = (PeupleA)p;
        }

        public Peuple getPeuple(){
            return peuple;
        }

        public int calculerNbPoint()
        {
            // adds 1 point for each unit still alive
            // on ajoute 1 point par unité encore en vie
            return nbPoints += peuple.unites.Count();

            // !!!!!!!!!  vérifier les bonus
        }

        public bool verifierDefaite()
        {
            //we check if the list still contains elements
            //on regarde si il n'y plus d'élément
            if (!peuple.unites.Any())
            {
                // player loses
                // le joueur a perdu
                return true;
            }

            return false;
        }

        public override String ToString()
        {
            return "Joueur : \n\t- Nom : " + nom + "\n\t- Peuple : " + peuple.GetType().Name + "\n\t- Nombre de points : " + nbPoints.ToString();
        }
    }
}

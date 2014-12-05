using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PeopleWar;

namespace WarFareWPF
{
    public class PlayerView : Notifier
    {
        public PeopleView peuple
        {
            get;
            set;
        }

        public JoueurImp joueur { get; set; }
        public PlayerView(JoueurImp joueur)
        {
            this.joueur = joueur;
            peuple = new PeopleView(joueur.peuple);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using PeopleWar;

namespace WarFareWPF
{
    /// <summary>
    /// Logique d'interaction pour GameWindow.xaml
    /// </summary>
    public partial class GameWindow : Window
    {
        public PartieImp partie { get; set; }

        public int nbUnitesj1 { 
            get { return partie.j1.peuple.getNbUnite(); }
        }

        public int nbUnitesj2 { 
            get { return partie.j2.peuple.getNbUnite(); } 
        }

        public GameWindow()
        {
            DirecteurPartie dp = new DirecteurPartie();
            dp.definirMonteur(new MonteurNvllePartie());
            this.partie = dp.creerPartie("theo", "hassan", EnumCarte.DEMO, EnumPeuple.ORC, EnumPeuple.ELF);
            InitializeComponent();
        }

        public string nomJoueur()
        {
            return partie.j1.nom;
        }
    }
}

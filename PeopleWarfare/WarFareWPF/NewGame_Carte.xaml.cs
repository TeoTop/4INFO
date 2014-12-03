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
    /// Logique d'interaction pour NewGame_Carte.xaml
    /// </summary>
    public partial class NewGame_Carte : Window
    {

        public static String j1 { get; set; }
        public static String j2 { get; set; }
        public static EnumPeuple p1 { get; set; }
        public static EnumPeuple p2 { get; set; }
        public NewGame_Carte(String j1, String j2, int p1, int p2)
        {
            InitializeComponent();
            AbstractWindow.j1 = j1;
            AbstractWindow.j2 = j2;
            AbstractWindow.p1 = (EnumPeuple)p1;
            AbstractWindow.p2 = (EnumPeuple)p2;
        }

        private void Demo(object sender, RoutedEventArgs e)
        {
            CreateGame(EnumCarte.DEMO);
        }

        private void Petite(object sender, RoutedEventArgs e)
        {
            CreateGame(EnumCarte.PETITE);
        }

        private void Normale(object sender, RoutedEventArgs e)
        {
            CreateGame(EnumCarte.NORMALE);
        }

        private void CreateGame(EnumCarte carte)
        {
            DirecteurPartie dp = new DirecteurPartie();
            dp.definirMonteur(new MonteurNvllePartie());
            PartieImp partie = dp.creerPartie(AbstractWindow.j1, AbstractWindow.j2, carte, AbstractWindow.p1, AbstractWindow.p2);
            GameWindow gw = new GameWindow(partie);
            gw.Show();
            this.Close();
        }

        private void Prec(object sender, RoutedEventArgs e)
        {
            NewGame ng = new NewGame();
            ng.Show();
            this.Close();
        }
    }
}

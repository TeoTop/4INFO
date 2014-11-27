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

namespace WarFareWPF
{
    /// <summary>
    /// Logique d'interaction pour Window1.xaml
    /// </summary>
    public partial class NewGame : Window
    {
        public NewGame()
        {
            InitializeComponent();
        }

        private void Next(object sender, RoutedEventArgs e)
        {

            NewGame_Carte nc = new NewGame_Carte();
            nc.Show();
            this.Close();
        }
    }
}

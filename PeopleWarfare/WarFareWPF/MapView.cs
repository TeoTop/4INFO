using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PeopleWar;
using System.ComponentModel;
namespace WarFareWPF
{
    public class MapView : Notifier
    {
        public StrategieCarte carte { get; set; }
        public int Width
        {
            get { return (int)Columns * 69; }
        }
        public double Columns
        {
            get { return Math.Sqrt(carte.nbCase); }
        }
        private List<BoxView> _cases = new List<BoxView>();
        public List<BoxView> cases
        {
            get { return _cases; }
        }
        private BoxView selectedBox;
        public BoxView SelectedBox
        {
            get { return selectedBox; }
            set
            {
                if (selectedBox != null) selectedBox.IsSelected = false;
                selectedBox = value;
                if (selectedBox != null) selectedBox.IsSelected = true;
                RaisePropertyChanged("SelectedBox");
            }
        }
        public MapView(StrategieCarte map)
        {
            carte = map;
            int i = 0;
            foreach (var box in carte.cases)
            {
                BoxView boxview = new BoxView(carte.getX(i), carte.getY(i), box);
                _cases.Add(boxview);
                i++;
            }
        }

        public override string ToString()
        {
            String toReturn = "";
            foreach (var box in _cases)
            {
                toReturn += box.ToString() + "\n";
            }
            return toReturn;
        }

    }
}

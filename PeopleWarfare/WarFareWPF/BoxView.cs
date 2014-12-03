using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PeopleWar;
namespace WarFareWPF
{
    public class BoxView : Notifier
    {
        private CaseA box;
        private int nbUnite;
        private int joueur;
        public BoxView(int row, int column, CaseA box)
        {
            this.box = box;
            switch (box.getType())
            {
                case EnumCase.DESERT: this.Type = "Desert"; this.Src = "res/desert.png"; break;
                case EnumCase.FORET: this.Type = "Foret"; this.Src = "res/foret.png"; break;
                case EnumCase.MONTAGNE: this.Type = "Montagne"; this.Src = "res/ocean.png"; break; // à modifier
                case EnumCase.PLAINE: this.Type = "Plaine"; this.Src = "res/plaine.png"; break;
            }
            this.Row = row;
            this.Column = column;
            /*this.nbUnite = 0;
            if (row == 0 && column == 0) {
                this.nbUnite = 
            }
            this.jo*/
        }

        public string Src { get; set; }
        public String Type { get; set; }
        public int Row { get; set; }
        public int Column { get; set; }
        private bool hasUnit;
        public bool HasUnit
        {
            get { return hasUnit; }
            set
            {
                hasUnit = value;
                RaisePropertyChanged("HasUnit");
            }
        }
        private bool isSelected;
        public bool IsSelected
        {
            get { return isSelected; }
            set
            {
                isSelected = value;
                RaisePropertyChanged("IsSelected");
            }
        }
        public bool RowPair
        {
            get
            {
                return Row % 2 == 0;
            }
        }
        public bool RowPairReverse
        {
            get
            {
                return Row % 2 != 0;
            }
        }
        public override string ToString()
        {
            return "(" + Row + ", " + Column + ")" + ", Type : " + Type;
        }

    }
}

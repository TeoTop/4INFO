using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PeopleWar;

namespace WarFareWPF
{
    public class UnitView : Notifier
    {
        public UniteImp unit;

        public UnitView(UniteImp unit)
        {
            this.unit = unit;

        }
    }
}

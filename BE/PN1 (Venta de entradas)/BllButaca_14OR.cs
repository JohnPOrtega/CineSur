using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;

namespace BLL
{
    public class BllButaca_14OR
    {
        private DALButaca_14OR dal = new DALButaca_14OR();

        // le paso al form las butacas de una sala para dibujar la distribucion
        public List<Butaca_14OR> ListarPorSala_14OR(int idSala)
        {
            return dal.ListarPorSala_14OR(idSala);
        }
    }
}

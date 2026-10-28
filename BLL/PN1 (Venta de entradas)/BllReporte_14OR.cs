using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;

namespace BLL
{
    public class BllReporte_14OR
    {
        private DALReporte_14OR dal = new DALReporte_14OR();

        // RF1 - Listado de Funciones y Ocupacion de Sala
        public List<ReporteFuncionOcupacion_14OR> ListadoFuncionesOcupacion_14OR()
        {
            return dal.ListadoFuncionesOcupacion_14OR();
        }
    }
}

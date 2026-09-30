using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    
    public class ReporteFuncionOcupacion_14OR
    {
        public int IdFuncion_14OR { get; set; }
        public string Pelicula_14OR { get; set; }
        public int Sala_14OR { get; set; }
        public DateTime Fecha_14OR { get; set; }
        public DateTime Horario_14OR { get; set; }
        public int TicketsVendidos_14OR { get; set; }
        public int ButacasDisponibles_14OR { get; set; }
        public double RecaudacionParcial_14OR { get; set; }

        public ReporteFuncionOcupacion_14OR()
        {
        }
    }
}

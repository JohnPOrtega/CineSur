using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Funcion_14OR
    {
        private int _idFuncion;

        public int IdFuncion_14OR
        {
            get { return _idFuncion; }
            set { _idFuncion = value; }
        }

        private DateTime _fecha;

        public DateTime Fecha_14OR
        {
            get { return _fecha; }
            set { _fecha = value; }
        }

        private DateTime _horario;

        public DateTime Horario_14OR
        {
            get { return _horario; }
            set { _horario = value; }
        }

        private FormatoFuncion_14OR _formato;

        public FormatoFuncion_14OR Formato_14OR
        {
            get { return _formato; }
            set { _formato = value; }
        }

        private string _idioma;

        public string Idioma_14OR
        {
            get { return _idioma; }
            set { _idioma = value; }
        }

        private double _precio;

        public double Precio_14OR
        {
            get { return _precio; }
            set { _precio = value; }
        }

        public Funcion_14OR()
        {

        }

      
        public Pelicula_14OR Pelicula { get; set; }
        public Sala_14OR Sala { get; set; }
        public List<AsientoFuncion_14OR> Asientos { get; set; }
    }
}

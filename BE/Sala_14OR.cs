using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Sala_14OR
    {
        private int _idSala;

        public int IdSala_14OR
        {
            get { return _idSala; }
            set { _idSala = value; }
        }

        private int _numero;

        public int Numero_14OR
        {
            get { return _numero; }
            set { _numero = value; }
        }

        private int _capacidad;

        public int Capacidad_14OR
        {
            get { return _capacidad; }
            set { _capacidad = value; }
        }

        private string _pasillos;

        // guarda las columnas que tienen pasillo a la derecha, separadas por coma 
        // cada sala tiene su propia distribucion osea que si si aca hay vacio o null = sin pasillos
        public string Pasillos_14OR
        {
            get { return _pasillos; }
            set { _pasillos = value; }
        }

        public Sala_14OR()
        {

        }

       
        public List<Butaca_14OR> Butacas { get; set; }
    }
}

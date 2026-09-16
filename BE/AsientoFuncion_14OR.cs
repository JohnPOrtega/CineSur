using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Clase asociacion entre Funcion y Butaca (el rombo del diagrama).
    // Guarda el estado de una butaca EN una funcion puntual.
    public class AsientoFuncion_14OR
    {
        private string _estado;

        public string Estado_14OR
        {
            get { return _estado; }
            set { _estado = value; }
        }

        private bool _ingreso;

        public bool Ingreso_14OR
        {
            get { return _ingreso; }
            set { _ingreso = value; }
        }

        public AsientoFuncion_14OR()
        {

        }

        // Asociaciones del diagrama de dominio
        public Funcion_14OR Funcion { get; set; }
        public Butaca_14OR Butaca { get; set; }
    }
}

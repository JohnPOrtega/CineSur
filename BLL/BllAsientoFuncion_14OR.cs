using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;

namespace BLL
{
    public class BllAsientoFuncion_14OR
    {
        private DALAsientoFuncion_14OR dal = new DALAsientoFuncion_14OR();

        // devuelve el mapa de la funcion para dibujar.
        // si la funcion todavia no tiene asientos generados, los creo al toque (todos Libre) y despues los traigo.
        // asi funciona incluso con las funciones que ya estaban cargadas de antes.
        // idSala lo necesito por si tengo que generar (para saber de que sala saco las butacas)
        public List<AsientoFuncion_14OR> ObtenerMapa_14OR(int idFuncion, int idSala)
        {
            if (idFuncion <= 0)
                throw new Exception("Funcion invalida.");

            // primera vez que se abre esta funcion: materializo sus asientos
            if (dal.ContarAsientos_14OR(idFuncion) == 0)
                dal.GenerarParaFuncion_14OR(idFuncion, idSala);

            return dal.ObtenerMapa_14OR(idFuncion);
        }

        // cuantas butacas quedan para vender en la funcion (para mostrar en la lista de horarios)
        public int ContarLibres_14OR(int idFuncion)
        {
            return dal.ContarLibres_14OR(idFuncion);
        }

        // libres para mostrar en la lista de horarios SIN tener que generar los asientos todavia:
        // si la funcion aun no genero sus asientos, estan todas libres (= capacidad de la sala).
        // si ya los genero, cuento las que quedan libres de verdad.
        public int LibresParaMostrar_14OR(int idFuncion, int capacidadSala)
        {
            if (dal.ContarAsientos_14OR(idFuncion) == 0)
                return capacidadSala;

            return dal.ContarLibres_14OR(idFuncion);
        }
    }
}

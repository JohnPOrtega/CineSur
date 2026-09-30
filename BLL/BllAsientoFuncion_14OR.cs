using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;
using Servicios;

namespace BLL
{
    // resultado de intentar registrar el ingreso de una entrada en el control de acceso (CUN-004).
    //  Ok           = ingreso registrado, la butaca queda Utilizada.
    //  NoExiste     = la butaca no pertenece a la funcion (ticket invalido).
    //  NoVendida    = la butaca no fue vendida (Libre/Reservada/Accesible) -> no hay entrada que validar.
    //  YaUtilizada  = la entrada ya habia ingresado antes.
    public enum ResultadoIngreso_14OR { Ok, NoExiste, NoVendida, YaUtilizada }

    public class BllAsientoFuncion_14OR
    {
        private DALAsientoFuncion_14OR dal = new DALAsientoFuncion_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // devuelve el mapa de la funcion para dibujar.
        // si la funcion todavia no tiene asientos generados, los creo al toque (todos Libre) y despues los traigo.
        // asi funciona incluso con las funciones que ya estaban cargadas de antes.
        // idSala lo necesito por si tengo que generar (para saber de que sala saco las butacas)
        public List<AsientoFuncion_14OR> ObtenerMapa_14OR(int idFuncion, int idSala)
        {
            if (idFuncion <= 0)
                throw new Exception("Funcion invalida.");

            // siempre me aseguro de que la funcion tenga un asiento por cada butaca ACTUAL de la sala.
            // es idempotente (solo inserta los que falten), asi se auto-repara si la sala cambio
            // sus butacas y el mapa no queda vacio.
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

        // CUN-004 - control de acceso: valida el ticket (funcion + butaca) y registra el ingreso.
        // aplica las reglas del flujo: existe? esta vendida? ya se uso? -> recien ahi registra.
        public ResultadoIngreso_14OR RegistrarIngreso_14OR(int idFuncion, int idButaca)
        {
            if (idFuncion <= 0 || idButaca <= 0)
                return ResultadoIngreso_14OR.NoExiste;

            AsientoFuncion_14OR af = dal.ObtenerAsiento_14OR(idFuncion, idButaca);

            // el ticket apunta a una butaca que no existe en esa funcion
            if (af == null)
                return ResultadoIngreso_14OR.NoExiste;

            // ya ingreso antes (Ingreso=1 o Estado=Utilizada)
            if (af.Ingreso_14OR || af.Estado_14OR == "Utilizada")
                return ResultadoIngreso_14OR.YaUtilizada;

            // solo se puede validar ingreso de una entrada VENDIDA (Ocupada)
            if (af.Estado_14OR != "Ocupada")
                return ResultadoIngreso_14OR.NoVendida;

            // update atomico: solo pega si sigue Ocupada sin ingreso. 1 fila = ok.
            int filas = dal.RegistrarIngreso_14OR(idFuncion, idButaca);
            if (filas == 1)
            {
                bllBi.GuardarLog_43BO(Modulo_43BO.Ventas, Evento_43BO.Ingreso, 1);
                return ResultadoIngreso_14OR.Ok;
            }
            return ResultadoIngreso_14OR.YaUtilizada;
        }
    }
}

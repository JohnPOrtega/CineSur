using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;

namespace BLL
{
    // resultado de intentar reservar: o salio todo bien, o alguna butaca ya la agarro otro vendedor
    public enum ResultadoReserva_14OR { Ok, Conflicto }

    public class BllVenta_14OR
    {
        private DALAsientoFuncion_14OR dalAF = new DALAsientoFuncion_14OR();

        // reserva las butacas elegidas para una funcion. es el corazon del CUN-001.
        // reglas: al menos una butaca, maximo 8 por venta.
        // la reserva en si es atomica (la resuelve el DAL con un solo UPDATE): si alguna ya no estaba
        // libre no reserva ninguna y devuelve Conflicto, asi el vendedor refresca la sala y vuelve a elegir.
        public ResultadoReserva_14OR ReservarButacas_14OR(int idFuncion, List<Butaca_14OR> butacas)
        {
            if (idFuncion <= 0)
                throw new Exception("Funcion invalida.");

            if (butacas == null || butacas.Count == 0)
                throw new Exception("Elegi al menos una butaca.");

            if (butacas.Count > 8)
                throw new Exception("Maximo 8 butacas por venta.");

            List<int> ids = butacas.Select(b => b.IdButaca_14OR).ToList();

            bool ok = dalAF.ReservarSiLibres_14OR(idFuncion, ids);

            // aca despues enganchariamos la bitacora (registrar la reserva) como en el resto del sistema.
            // y con esto ya continuaria el CUN-002 Cobrar: agarra las Reservadas, calcula el monto y crea la Venta.

            return ok ? ResultadoReserva_14OR.Ok : ResultadoReserva_14OR.Conflicto;
        }
    }
}

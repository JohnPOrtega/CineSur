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
    public class BllPromocion_14OR
    {
        private DALPromocion_14OR dal = new DALPromocion_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // ---- ABM ----

        public List<Promocion_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }

        public int Alta_14OR(Promocion_14OR p)
        {
            Validar_14OR(p);
            int r = dal.Alta_14OR(p);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Crear, 2);
            return r;
        }

        public int Modificar_14OR(Promocion_14OR p)
        {
            if (p.IdPromocion_14OR <= 0)
                throw new Exception("No se selecciono ninguna promocion para modificar.");
            Validar_14OR(p);
            int r = dal.Modificar_14OR(p);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.modificar, 2);
            return r;
        }

        public int Baja_14OR(int idPromocion)
        {
            if (idPromocion <= 0)
                throw new Exception("No se selecciono ninguna promocion para eliminar.");
            int r = dal.Baja_14OR(idPromocion);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Desactivar, 3);
            return r;
        }

        private void Validar_14OR(Promocion_14OR p)
        {
            if (p == null)
                throw new Exception("No llegaron los datos de la promocion.");

            if (string.IsNullOrWhiteSpace(p.Nombre_14OR))
                throw new Exception("El nombre de la promocion no puede quedar vacio.");

            // el porcentaje tiene que ser un descuento razonable (1 a 100). el 2x1 no usa valor.
            if (p.Tipo_14OR == TipoPromocion_14OR.Porcentaje && (p.Valor_14OR <= 0 || p.Valor_14OR > 100))
                throw new Exception("El porcentaje de descuento tiene que estar entre 1 y 100.");

            if (p.FechaFin_14OR.Date < p.FechaInicio_14OR.Date)
                throw new Exception("La fecha de fin no puede ser anterior a la de inicio.");
        }

        // devuelve las promociones vigentes (activas y dentro de fecha) para mostrarlas en el cobro.
        // el cliente socio elige cual usar; el mismo nombre viaja GUI -> BLL -> DAL.
        public List<Promocion_14OR> ListarPVigentes_14OR()
        {
            return dal.ListarPVigentes_14OR();
        }

        // cuanto descuenta una promo puntual sobre la compra
        public double CalcularDescuento_14OR(Promocion_14OR p, int cantidadEntradas, double precioUnitario, double subtotal)
        {
            if (p.Tipo_14OR == TipoPromocion_14OR.DosPorUno)
            {
                // cada 2 entradas, una gratis
                int gratis = cantidadEntradas / 2;
                return gratis * precioUnitario;
            }

            // Porcentaje
            return subtotal * p.Valor_14OR / 100.0;
        }
    }
}

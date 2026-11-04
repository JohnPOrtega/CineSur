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
    public class BllPresupuesto_14OR
    {
        private DALPresupuesto_14OR dal = new DALPresupuesto_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // Pide una cotizacion a un proveedor por una lista de productos/cantidades.
        public int PedirPresupuesto_14OR(int idProveedor, List<DetallePresupuesto_14OR> renglones)
        {
            if (idProveedor <= 0)
                throw new Exception("Elegi un proveedor.");

            if (renglones == null || renglones.Count == 0)
                throw new Exception("Agrega al menos un producto para cotizar.");

            foreach (DetallePresupuesto_14OR d in renglones)
            {
                if (d.IdProducto_14OR <= 0)
                    throw new Exception("Hay un producto invalido en el pedido.");
                if (d.Cantidad_14OR <= 0)
                    throw new Exception("La cantidad de cada producto tiene que ser mayor a cero.");
            }

            Presupuesto_14OR pre = new Presupuesto_14OR();
            pre.IdProveedor_14OR = idProveedor;
            pre.FechaPedido_14OR = DateTime.Today;
            pre.Estado_14OR = Presupuesto_14OR.EstadoPedido_14OR;
            pre.Detalles = renglones;

            int id = dal.PedirPresupuesto_14OR(pre);
            bllBi.GuardarLog_43BO(Modulo_43BO.Compras, Evento_43BO.Crear, 2);
            return id;
        }

        // Carga los precios cotizados por el proveedor y pasa el presupuesto a "Recibido".
        public void CargarCotizacion_14OR(Presupuesto_14OR pre)
        {
            if (pre == null || pre.IdPresupuesto_14OR <= 0)
                throw new Exception("Presupuesto invalido.");

            if (pre.Detalles == null || pre.Detalles.Count == 0)
                throw new Exception("El presupuesto no tiene renglones.");

            foreach (DetallePresupuesto_14OR d in pre.Detalles)
            {
                if (d.PrecioCotizado_14OR <= 0)
                    throw new Exception("Carga un precio mayor a cero para cada producto.");
            }

            dal.CargarCotizacion_14OR(pre);
            bllBi.GuardarLog_43BO(Modulo_43BO.Compras, Evento_43BO.modificar, 2);
        }

        // Rechaza un presupuesto (no se gneera orden).
        public void Rechazar_14OR(int idPresupuesto)
        {
            if (idPresupuesto <= 0)
                throw new Exception("Presupuesto invalido.");

            dal.CambiarEstado_14OR(idPresupuesto, Presupuesto_14OR.EstadoRechazado_14OR);
            bllBi.GuardarLog_43BO(Modulo_43BO.Compras, Evento_43BO.modificar, 2);
        }

        public List<Presupuesto_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }

        public List<DetallePresupuesto_14OR> ObtenerDetalle_14OR(int idPresupuesto)
        {
            return dal.ObtenerDetalle_14OR(idPresupuesto);
        }
    }
}

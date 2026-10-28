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
    public class BllOrdenCompra_14OR
    {
        private DALOrdenCompra_14OR dal = new DALOrdenCompra_14OR();
        private DALPresupuesto_14OR dalPre = new DALPresupuesto_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // Acepta un presupuesto "Recibido" y emite la Orden de Compra "Abierta".
        // Copia los renglones del presupuesto (precio de costo = precio cotizado que aceptamos).
        // Devuelve el Id de la orden generada.
        public int GenerarDesdePresupuesto_14OR(Presupuesto_14OR pre)
        {
            if (pre == null || pre.IdPresupuesto_14OR <= 0)
                throw new Exception("Presupuesto invalido.");

            if (pre.Estado_14OR != Presupuesto_14OR.EstadoRecibido_14OR)
                throw new Exception("Solo se puede aceptar un presupuesto en estado 'Recibido' (con los precios cargados).");

            // me traigo los renglones del presupuesto desde la base (fuente de verdad de los precios)
            List<DetallePresupuesto_14OR> renglones = dalPre.ObtenerDetalle_14OR(pre.IdPresupuesto_14OR);
            if (renglones.Count == 0)
                throw new Exception("El presupuesto no tiene renglones.");

            OrdenCompra_14OR orden = new OrdenCompra_14OR();
            orden.IdProveedor_14OR = pre.IdProveedor_14OR;
            orden.IdPresupuesto_14OR = pre.IdPresupuesto_14OR;
            orden.FechaEmision_14OR = DateTime.Today;
            orden.Estado_14OR = OrdenCompra_14OR.EstadoAbierta_14OR;

            double importe = 0;
            foreach (DetallePresupuesto_14OR dp in renglones)
            {
                if (dp.PrecioCotizado_14OR <= 0)
                    throw new Exception("El presupuesto tiene renglones sin precio. Carga la cotizacion antes de aceptar.");

                DetalleOrdenCompra_14OR doc = new DetalleOrdenCompra_14OR();
                doc.IdProducto_14OR = dp.IdProducto_14OR;
                doc.NombreProducto_14OR = dp.NombreProducto_14OR;
                doc.Cantidad_14OR = dp.Cantidad_14OR;
                doc.PrecioCosto_14OR = dp.PrecioCotizado_14OR;
                orden.Detalles.Add(doc);

                importe += doc.Subtotal_14OR;
            }
            orden.Importe_14OR = importe;

            int idOrden = dal.GenerarDesdePresupuesto_14OR(orden);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Crear, 2);
            return idOrden;
        }

        public List<OrdenCompra_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }

        public List<DetalleOrdenCompra_14OR> ObtenerDetalle_14OR(int idOrden)
        {
            return dal.ObtenerDetalle_14OR(idOrden);
        }
    }
}

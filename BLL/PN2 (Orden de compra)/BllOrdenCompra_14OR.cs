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
            // el proveedor lo saco de la base, asi no depende de lo que mande la pantalla
            orden.IdProveedor_14OR = dalPre.ObtenerIdProveedor_14OR(pre.IdPresupuesto_14OR);
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
            bllBi.GuardarLog_43BO(Modulo_43BO.Compras, Evento_43BO.Crear, 2);
            return idOrden;
        }

        // pago la orden que esta abierta, le pongo la fecha de hoy
        public void PagarCompra_14OR(int idOrden)
        {
            if (idOrden <= 0)
                throw new Exception("No se selecciono ninguna orden para pagar.");

            int filas = dal.PagarCompra_14OR(idOrden, DateTime.Today);
            if (filas == 0)
                throw new Exception("Solo se puede pagar una orden en estado 'Abierta'.");

            bllBi.GuardarLog_43BO(Modulo_43BO.Compras, Evento_43BO.modificar, 2);
        }

        // registro el ingreso de la orden pagada: la cierro, guardo el remito y le sumo el stock
        // a cada producto que entro. devuelve el id de la orden
        public int RegistrarIngresoMercaderia_14OR(int idOrden, string nroRemito)
        {
            if (idOrden <= 0)
                throw new Exception("No se selecciono ninguna orden.");

            if (string.IsNullOrWhiteSpace(nroRemito))
                throw new Exception("Ingresa el numero de remito.");

            // me traigo los renglones para saber cuanto sumar al stock de cada producto
            List<DetalleOrdenCompra_14OR> renglones = dal.ObtenerDetalle_14OR(idOrden);
            if (renglones.Count == 0)
                throw new Exception("La orden no tiene renglones.");

            OrdenCompra_14OR orden = new OrdenCompra_14OR();
            orden.IdOrdenCompra_14OR = idOrden;
            orden.NumeroRemito_14OR = nroRemito.Trim();
            orden.FechaRecepcion_14OR = DateTime.Today;
            orden.Detalles = renglones;

            int id = dal.RegistrarIngresoMercaderia_14OR(orden);
            bllBi.GuardarLog_43BO(Modulo_43BO.Compras, Evento_43BO.Crear, 2);
            return id;
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

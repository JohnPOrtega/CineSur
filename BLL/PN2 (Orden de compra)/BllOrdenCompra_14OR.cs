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

        // registro el ingreso de la orden pagada: comparo lo que llego contra lo pedido, y si
        // coincide la cierro, guardo el remito y le sumo el stock a cada producto que entro.
        // recibidos = los renglones con la cantidad recibida que cargo el supervisor
        // devuelve el id de la orden
        public int RegistrarIngresoMercaderia_14OR(int idOrden, string nroRemito, List<DetalleOrdenCompra_14OR> recibidos)
        {
            if (idOrden <= 0)
                throw new Exception("No se selecciono ninguna orden.");

            if (string.IsNullOrWhiteSpace(nroRemito))
                throw new Exception("Ingresa el numero de remito.");

            // los renglones pedidos los saco de la base, no de la pantalla (fuente de verdad)
            List<DetalleOrdenCompra_14OR> renglones = dal.ObtenerDetalle_14OR(idOrden);
            if (renglones.Count == 0)
                throw new Exception("La orden no tiene renglones.");

            // aca comparo lo recibido contra la orden, si algo no cierra no registro nada
            List<string> diferencias = ValidarRecepcion_14OR(renglones, recibidos);
            if (diferencias.Count > 0)
                throw new Exception("Lo recibido no coincide con la orden de compra. Revisa:\n- "
                    + string.Join("\n- ", diferencias));

            OrdenCompra_14OR orden = new OrdenCompra_14OR();
            orden.IdOrdenCompra_14OR = idOrden;
            orden.NumeroRemito_14OR = nroRemito.Trim();
            orden.FechaRecepcion_14OR = DateTime.Today;
            orden.Detalles = renglones;

            int id = dal.RegistrarIngresoMercaderia_14OR(orden);
            bllBi.GuardarLog_43BO(Modulo_43BO.Compras, Evento_43BO.Crear, 2);
            return id;
        }

        // compara renglon por renglon la cantidad pedida contra la recibida.
        // devuelve la lista de diferencias (vacia = todo coincide). de paso le copio la
        // cantidad recibida a los renglones pedidos asi el dal guarda esa
        public List<string> ValidarRecepcion_14OR(List<DetalleOrdenCompra_14OR> pedidos, List<DetalleOrdenCompra_14OR> recibidos)
        {
            List<string> diferencias = new List<string>();
            if (recibidos == null) recibidos = new List<DetalleOrdenCompra_14OR>();

            foreach (DetalleOrdenCompra_14OR p in pedidos)
            {
                DetalleOrdenCompra_14OR r = recibidos.FirstOrDefault(x => x.IdDetalleOrdenCompra_14OR == p.IdDetalleOrdenCompra_14OR);

                if (r == null || !r.CantidadRecibida_14OR.HasValue)
                {
                    diferencias.Add(p.NombreProducto_14OR + ": falta cargar la cantidad recibida");
                    continue;
                }

                int recibida = r.CantidadRecibida_14OR.Value;
                if (recibida < 0)
                {
                    diferencias.Add(p.NombreProducto_14OR + ": la cantidad recibida no puede ser negativa");
                    continue;
                }

                if (recibida != p.Cantidad_14OR)
                    diferencias.Add(string.Format("{0}: pedido {1}, recibido {2}", p.NombreProducto_14OR, p.Cantidad_14OR, recibida));

                p.CantidadRecibida_14OR = recibida;
            }

            return diferencias;
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

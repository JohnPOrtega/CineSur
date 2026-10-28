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
    public class BllVentaCandy_14OR
    {
        private DALVentaCandy_14OR dal = new DALVentaCandy_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // Confirma la venta del candy. Valida el carrito y el metodo de pago, arma la venta
        // con sus renglones y la manda a la DAL (que descuenta stock de forma atomica).
        // Devuelve el numero/Id de la venta generada.
        public int ConfirmarVenta_14OR(List<DetalleVentaCandy_14OR> carrito, string metodoPago, double montoTotal)
        {
            if (carrito == null || carrito.Count == 0)
                throw new Exception("No hay productos en el pedido.");

            if (string.IsNullOrWhiteSpace(metodoPago))
                throw new Exception("Elegi un metodo de pago.");

            if (montoTotal < 0)
                throw new Exception("El monto no puede ser negativo.");

            foreach (DetalleVentaCandy_14OR d in carrito)
            {
                if (d.IdProducto_14OR <= 0)
                    throw new Exception("Hay un producto invalido en el pedido.");
                if (d.Cantidad_14OR <= 0)
                    throw new Exception("La cantidad de cada producto tiene que ser mayor a cero.");
            }

            VentaCandy_14OR v = new VentaCandy_14OR();
            v.Fecha_14OR = DateTime.Today;
            v.Hora_14OR = DateTime.Now;
            v.MetodoPago_14OR = metodoPago;
            v.MontoTotal_14OR = montoTotal;
            v.Detalles = carrito;

            int idVenta = dal.ConfirmarVenta_14OR(v);

            // queda auditada la venta del candy
            bllBi.GuardarLog_43BO(Modulo_43BO.Ventas, Evento_43BO.Cobro, 2);

            return idVenta;
        }

        // historial de ventas del candy (para un reporte futuro)
        public List<VentaCandy_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }
    }
}

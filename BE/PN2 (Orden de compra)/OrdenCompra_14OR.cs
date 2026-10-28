using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Orden de Compra: la cmopra formal a un proveedor, que nace de un presupuesto aceptado.
    // Ciclo del estado: "Abierta" (emitida, falta pagar) -> "Pagada" (se pago) ->
    // "Cerrada" (llego la mercaderia y se sumo al stock).
    // Los campos de pago y recepcion quedan vacios hasta las tandas B (pago) y C (recepcion).
    public class OrdenCompra_14OR
    {
        public const string EstadoAbierta_14OR = "Abierta";
        public const string EstadoPagada_14OR = "Pagada";
        public const string EstadoCerrada_14OR = "Cerrada";

        private int _idOrden;

        public int IdOrdenCompra_14OR
        {
            get { return _idOrden; }
            set { _idOrden = value; }
        }

        private int _numeroOrden;

        public int NumeroOrden_14OR
        {
            get { return _numeroOrden; }
            set { _numeroOrden = value; }
        }

        private int _idProveedor;

        public int IdProveedor_14OR
        {
            get { return _idProveedor; }
            set { _idProveedor = value; }
        }

        private string _nombreProveedor;

        public string NombreProveedor_14OR
        {
            get { return _nombreProveedor; }
            set { _nombreProveedor = value; }
        }

        // de que presupuesto salio esta orden
        private int _idPresupuesto;

        public int IdPresupuesto_14OR
        {
            get { return _idPresupuesto; }
            set { _idPresupuesto = value; }
        }

        private DateTime _fechaEmision;

        public DateTime FechaEmision_14OR
        {
            get { return _fechaEmision; }
            set { _fechaEmision = value; }
        }

        private string _estado;

        public string Estado_14OR
        {
            get { return _estado; }
            set { _estado = value; }
        }

        private double _importe;

        // total de la orden (suma de los renglones)
        public double Importe_14OR
        {
            get { return _importe; }
            set { _importe = value; }
        }

        // --- pago (tanda B) ---
        private DateTime? _fechaPago;

        public DateTime? FechaPago_14OR
        {
            get { return _fechaPago; }
            set { _fechaPago = value; }
        }

        // --- recepcion (tanda C) ---
        private string _numeroRemito;

        public string NumeroRemito_14OR
        {
            get { return _numeroRemito; }
            set { _numeroRemito = value; }
        }

        private DateTime? _fechaRecepcion;

        public DateTime? FechaRecepcion_14OR
        {
            get { return _fechaRecepcion; }
            set { _fechaRecepcion = value; }
        }

        public List<DetalleOrdenCompra_14OR> Detalles { get; set; }

        public OrdenCompra_14OR()
        {
            Detalles = new List<DetalleOrdenCompra_14OR>();
            _estado = EstadoAbierta_14OR;
        }
    }
}

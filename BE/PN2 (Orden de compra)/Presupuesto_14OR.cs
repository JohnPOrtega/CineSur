using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Presupuesto (cotizacion) que el Supervisor de compras le pide a UN proveedor.
    // Ciclo del estado: "Pedido" (se lo pedimos) -> "Recibido" (cargamos los precios que cotizo)
    // -> "Aceptado" (lo aceptamos y se genera la Orden de Compra) o "Rechazado".
    // Cada presupuesto tiene uno o varios renglones (DetallePresupuesto_14OR).
    public class Presupuesto_14OR
    {
        // nombres de estado (los dejo como constantes asi no hay strings sueltos por todos lados)
        public const string EstadoPedido_14OR = "Pedido";
        public const string EstadoRecibido_14OR = "Recibido";
        public const string EstadoAceptado_14OR = "Aceptado";
        public const string EstadoRechazado_14OR = "Rechazado";

        private int _idPresupuesto;

        public int IdPresupuesto_14OR
        {
            get { return _idPresupuesto; }
            set { _idPresupuesto = value; }
        }

        private int _numeroPresupuesto;

        public int NumeroPresupuesto_14OR
        {
            get { return _numeroPresupuesto; }
            set { _numeroPresupuesto = value; }
        }

        private int _idProveedor;

        public int IdProveedor_14OR
        {
            get { return _idProveedor; }
            set { _idProveedor = value; }
        }

        // nombre del proveedor, solo para mostrar en la grilla (lo trae el join de la DAL)
        private string _nombreProveedor;

        public string NombreProveedor_14OR
        {
            get { return _nombreProveedor; }
            set { _nombreProveedor = value; }
        }

        private DateTime _fechaPedido;

        public DateTime FechaPedido_14OR
        {
            get { return _fechaPedido; }
            set { _fechaPedido = value; }
        }

        private string _estado;

        public string Estado_14OR
        {
            get { return _estado; }
            set { _estado = value; }
        }

        public List<DetallePresupuesto_14OR> Detalles { get; set; }

        public Presupuesto_14OR()
        {
            Detalles = new List<DetallePresupuesto_14OR>();
            _estado = EstadoPedido_14OR;
        }
    }
}

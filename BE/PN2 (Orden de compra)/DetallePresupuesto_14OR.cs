using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Un renglon de un presupuesto: un producto, la cantidad que pedimos cotizar y el precio
    // que el proveedor cotizo (arranca en 0 hasta que cragamos lo que respondio).
    public class DetallePresupuesto_14OR
    {
        private int _idDetalle;

        public int IdDetallePresupuesto_14OR
        {
            get { return _idDetalle; }
            set { _idDetalle = value; }
        }

        private int _idPresupuesto;

        public int IdPresupuesto_14OR
        {
            get { return _idPresupuesto; }
            set { _idPresupuesto = value; }
        }

        private int _idProducto;

        public int IdProducto_14OR
        {
            get { return _idProducto; }
            set { _idProducto = value; }
        }

        private string _nombreProducto;

        public string NombreProducto_14OR
        {
            get { return _nombreProducto; }
            set { _nombreProducto = value; }
        }

        private int _cantidad;

        public int Cantidad_14OR
        {
            get { return _cantidad; }
            set { _cantidad = value; }
        }

        private double _precioCotizado;

        // lo que cotizo el proveedor por unidda (0 mientras el presupuesto esta en "Pedido")
        public double PrecioCotizado_14OR
        {
            get { return _precioCotizado; }
            set { _precioCotizado = value; }
        }

        // cantidad * precio cotizado, para mostrar el subtotal del renglon
        public double Subtotal_14OR
        {
            get { return _cantidad * _precioCotizado; }
        }

        public DetallePresupuesto_14OR()
        {
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Un renglon de una orden de compra: un producto, la cantidad pedida y el precio de costo
    // (el que acepto el Supervisor del presupuesto). Al recibir la mercaderia se carga la
    // cantidad recibida, se compara contra la pedida y esa es la que se suma al stock.
    public class DetalleOrdenCompra_14OR
    {
        private int _idDetalle;

        public int IdDetalleOrdenCompra_14OR
        {
            get { return _idDetalle; }
            set { _idDetalle = value; }
        }

        private int _idOrden;

        public int IdOrdenCompra_14OR
        {
            get { return _idOrden; }
            set { _idOrden = value; }
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

        private double _precioCosto;

        public double PrecioCosto_14OR
        {
            get { return _precioCosto; }
            set { _precioCosto = value; }
        }

        // lo que realmente llego segun el remito. null = todavia no se recibio
        private int? _cantidadRecibida;

        public int? CantidadRecibida_14OR
        {
            get { return _cantidadRecibida; }
            set { _cantidadRecibida = value; }
        }

        public double Subtotal_14OR
        {
            get { return _cantidad * _precioCosto; }
        }

        public DetalleOrdenCompra_14OR()
        {
        }
    }
}

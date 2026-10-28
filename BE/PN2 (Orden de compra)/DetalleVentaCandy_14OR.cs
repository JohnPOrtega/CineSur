using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Un renglon de una venta del Candy Bar: un producto, su cantidad y el precio al que se vendio.
    // Guardo el nombre y el precio unitario como "foto" del momento de la venta, asi el historico
    // no cambia aunque despues se modifique o se de de baja el producto.
    public class DetalleVentaCandy_14OR
    {
        private int _idDetalle;

        public int IdDetalleVentaCandy_14OR
        {
            get { return _idDetalle; }
            set { _idDetalle = value; }
        }

        private int _idVentaCandy;

        public int IdVentaCandy_14OR
        {
            get { return _idVentaCandy; }
            set { _idVentaCandy = value; }
        }

        private int _idProducto;

        public int IdProducto_14OR
        {
            get { return _idProducto; }
            set { _idProducto = value; }
        }

        private string _nombreProducto;

        // nombre del producto al momento de la venta (foto del historico)
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

        private double _precioUnitario;

        public double PrecioUnitario_14OR
        {
            get { return _precioUnitario; }
            set { _precioUnitario = value; }
        }

        // cantidad * precio unitario. lo calculo en el momento asi la grilla lo muestra directo.
        public double Subtotal_14OR
        {
            get { return _cantidad * _precioUnitario; }
        }

        public DetalleVentaCandy_14OR()
        {
        }
    }
}

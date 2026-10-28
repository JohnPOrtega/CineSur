using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Producto del Candy Bar (pochoclos, gaseosas, combos).
    // Es lo que se vende en la confiteria y lo que se repone con las compras del PN2.
    // Cada venta del candy descuenta Stock_14OR; cuando queda por debajo de StockCritico_14OR
    // hay que reponer (ahi arranca la compra a proveedores).
    public class Producto_14OR
    {
        private int _idProducto;

        public int IdProducto_14OR
        {
            get { return _idProducto; }
            set { _idProducto = value; }
        }

        private string _nombre;

        public string Nombre_14OR
        {
            get { return _nombre; }
            set { _nombre = value; }
        }

        private double _precioVenta;

        // precio al que se le vende al cliente en el candy bar
        public double PrecioVenta_14OR
        {
            get { return _precioVenta; }
            set { _precioVenta = value; }
        }

        private int _stock;

        // cantidad disponible ahora en el candy bar
        public int Stock_14OR
        {
            get { return _stock; }
            set { _stock = value; }
        }

        private int _stockCritico;

        // limite minimo: si el stock queda en o por debajo de esto hay que reponer
        public int StockCritico_14OR
        {
            get { return _stockCritico; }
            set { _stockCritico = value; }
        }

        private bool _activo;

        // baja logica: si esta en false el producto no se muetra ni se vende
        public bool Activo_14OR
        {
            get { return _activo; }
            set { _activo = value; }
        }

        private string _imagen;

        // nobmre del archivo de imagen del producto (se guarda en la carpeta ProductosCandy
        // al lado del exe). lo uso para mostrar las tarjetas con foto en la venta del candy.
        public string Imagen_14OR
        {
            get { return _imagen; }
            set { _imagen = value; }
        }

        private double _precioCosto;

        // precio de costo de referencia: lo que (aprox) nos cuesta comprarle este producto al
        // proveedor. Se usa para autocompletar la cotizacion del presupuesto con un valor con sentido.
        // Deberia ser menor al PrecioVenta_14OR.
        public double PrecioCosto_14OR
        {
            get { return _precioCosto; }
            set { _precioCosto = value; }
        }

        public Producto_14OR()
        {
            // por defecto un producto nuevo arranca activo
            _activo = true;
        }
    }
}

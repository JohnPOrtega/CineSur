using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Venta de productos del Candy Bar (confiteria). Es paralela a Venta_14OR (que es la de
    // entradas): esta guarda lo que se vende en el candy y descuenta stock. Cada venta tiene
    // uno o varios renglones (DetalleVentaCandy_14OR).
    public class VentaCandy_14OR
    {
        private int _idVentaCandy;

        public int IdVentaCandy_14OR
        {
            get { return _idVentaCandy; }
            set { _idVentaCandy = value; }
        }

        private int _numeroVenta;

        public int NumeroVenta_14OR
        {
            get { return _numeroVenta; }
            set { _numeroVenta = value; }
        }

        private DateTime _fecha;

        public DateTime Fecha_14OR
        {
            get { return _fecha; }
            set { _fecha = value; }
        }

        private DateTime _hora;

        public DateTime Hora_14OR
        {
            get { return _hora; }
            set { _hora = value; }
        }

        private string _metodoPago;

        public string MetodoPago_14OR
        {
            get { return _metodoPago; }
            set { _metodoPago = value; }
        }

        private double _montoTotal;

        public double MontoTotal_14OR
        {
            get { return _montoTotal; }
            set { _montoTotal = value; }
        }

        // los renglones de la venta (un producto + cantidad cada uno)
        public List<DetalleVentaCandy_14OR> Detalles { get; set; }

        public VentaCandy_14OR()
        {
            Detalles = new List<DetalleVentaCandy_14OR>();
        }
    }
}

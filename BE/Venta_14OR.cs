using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Venta_14OR
    {
        private int _idVenta;

        public int IdVenta_14OR
        {
            get { return _idVenta; }
            set { _idVenta = value; }
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

        private string _estado;

        public string Estado_14OR
        {
            get { return _estado; }
            set { _estado = value; }
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

        public Venta_14OR()
        {

        }

        // Asociaciones del diagrama de dominio
        public Cliente_14OR Cliente { get; set; }
        public List<AsientoFuncion_14OR> Asientos { get; set; }
    }
}

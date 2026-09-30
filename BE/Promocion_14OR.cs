using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // una promocion del cine. se administra en el ABM de Master y se aplica sola en la venta
    // (a los clientes suscriptores). todas son sobre entradas.
    public class Promocion_14OR
    {
        private int _idPromocion;

        public int IdPromocion_14OR
        {
            get { return _idPromocion; }
            set { _idPromocion = value; }
        }

        private string _nombre;

        public string Nombre_14OR
        {
            get { return _nombre; }
            set { _nombre = value; }
        }

        private TipoPromocion_14OR _tipo;

        public TipoPromocion_14OR Tipo_14OR
        {
            get { return _tipo; }
            set { _tipo = value; }
        }

        private double _valor;

        // para Porcentaje = el % de descuento (ej 10). para 2x1 no se usa.
        public double Valor_14OR
        {
            get { return _valor; }
            set { _valor = value; }
        }

        private DateTime _fechaInicio;

        public DateTime FechaInicio_14OR
        {
            get { return _fechaInicio; }
            set { _fechaInicio = value; }
        }

        private DateTime _fechaFin;

        public DateTime FechaFin_14OR
        {
            get { return _fechaFin; }
            set { _fechaFin = value; }
        }

        private bool _activa;

        public bool Activa_14OR
        {
            get { return _activa; }
            set { _activa = value; }
        }

        public Promocion_14OR()
        {

        }
    }
}

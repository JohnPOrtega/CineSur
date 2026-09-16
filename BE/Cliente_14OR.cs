using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Cliente_14OR
    {
        private int _idCliente;

        public int IdCliente_14OR
        {
            get { return _idCliente; }
            set { _idCliente = value; }
        }

        private string _nombre;

        public string Nombre_14OR
        {
            get { return _nombre; }
            set { _nombre = value; }
        }

        private string _apellido;

        public string Apellido_14OR
        {
            get { return _apellido; }
            set { _apellido = value; }
        }

        private int _dni;

        public int DNI_14OR
        {
            get { return _dni; }
            set { _dni = value; }
        }

        private string _email;

        public string Email_14OR
        {
            get { return _email; }
            set { _email = value; }
        }

        private string _telefono;

        public string Telefono_14OR
        {
            get { return _telefono; }
            set { _telefono = value; }
        }

        private bool _suscriptor;

        public bool Suscriptor_14OR
        {
            get { return _suscriptor; }
            set { _suscriptor = value; }
        }

        public Cliente_14OR()
        {

        }
    }
}

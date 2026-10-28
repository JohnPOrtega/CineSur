using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Proveedor al que el Supervisor de compras le pide presupuesto y le compra
    // los insumos del Candy Bar (PN2). Por ahora alcanza con los datos de contacto;
    // la relacion con los productos/ordenes la vamos a armar en las tandas siguientes.
    public class Proveedor_14OR
    {
        private int _idProveedor;

        public int IdProveedor_14OR
        {
            get { return _idProveedor; }
            set { _idProveedor = value; }
        }

        private string _nombre;

        // razon social o nombre del proveedor
        public string Nombre_14OR
        {
            get { return _nombre; }
            set { _nombre = value; }
        }

        private string _telefono;

        public string Telefono_14OR
        {
            get { return _telefono; }
            set { _telefono = value; }
        }

        private string _email;

        public string Email_14OR
        {
            get { return _email; }
            set { _email = value; }
        }

        private bool _activo;

        // baja logica, igual que el producto
        public bool Activo_14OR
        {
            get { return _activo; }
            set { _activo = value; }
        }

        public Proveedor_14OR()
        {
            _activo = true;
        }
    }
}

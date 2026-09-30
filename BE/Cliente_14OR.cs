using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace BE
{
    // [Serializable] + atributos XML para la Serializacion (TP).
    // No son obligatorios (XmlSerializer serializa las propiedades publicas igual),
    // pero los dejamos explicitos para que el XML salga prolijo y quede documentado
    // que esta clase es la que se serializa/des-serializa.
    [Serializable]
    [XmlRoot("Cliente")]
    [XmlType("Cliente")]
    public class Cliente_14OR
    {
        private int _idCliente;

        [XmlElement("IdCliente")]
        public int IdCliente_14OR
        {
            get { return _idCliente; }
            set { _idCliente = value; }
        }

        private string _nombre;

        [XmlElement("Nombre")]
        public string Nombre_14OR
        {
            get { return _nombre; }
            set { _nombre = value; }
        }

        private string _apellido;

        [XmlElement("Apellido")]
        public string Apellido_14OR
        {
            get { return _apellido; }
            set { _apellido = value; }
        }

        private int _dni;

        [XmlElement("DNI")]
        public int DNI_14OR
        {
            get { return _dni; }
            set { _dni = value; }
        }

        private string _email;

        [XmlElement("Email")]
        public string Email_14OR
        {
            get { return _email; }
            set { _email = value; }
        }

        private string _telefono;

        [XmlElement("Telefono")]
        public string Telefono_14OR
        {
            get { return _telefono; }
            set { _telefono = value; }
        }

        private bool _suscriptor;

        [XmlElement("Suscriptor")]
        public bool Suscriptor_14OR
        {
            get { return _suscriptor; }
            set { _suscriptor = value; }
        }

        // borrado logico (virtual): el cliente no se borra fisicamente porque tiene ventas
        // asociadas (historial). Eliminado = true lo saca de las listas pero conserva sus ventas.
        private bool _eliminado;

        [XmlIgnore]
        public bool Eliminado_14OR
        {
            get { return _eliminado; }
            set { _eliminado = value; }
        }

        public Cliente_14OR()
        {

        }
    }
}

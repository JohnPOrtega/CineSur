using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace BE
{
  
    [XmlRoot("Clientes")]
    public class ClientesXml_14OR
    {
        [XmlElement("Cliente")]
        public List<Cliente_14OR> Clientes_14OR { get; set; }

        public ClientesXml_14OR()
        {
            Clientes_14OR = new List<Cliente_14OR>();
        }
    }
}

using BE;
using DAL;
using Servicios;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace BLL
{
    public class BllCliente_14OR
    {
        private DALCliente_14OR dal = new DALCliente_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // ---- ABM (para el maestro de Clientes) ----

        public List<Cliente_14OR> Listar_14OR()
        {
            // La DAL trae los datos de la BD (con el email cifrado)
            List<Cliente_14OR> lista = dal.Listar_14OR();
            // La BLL se encarga de desencriptar los emails para que la capa superior los vea legibles
            return DesencriptarLista_14OR(lista);
        }

        public int Alta_14OR(Cliente_14OR c)
        {
            Validar_14OR(c);

            // No puede haber dos clientes con el mismo DNI
            Cliente_14OR existente = BuscarPorDniParaNegocio_14OR(c.DNI_14OR);
            if (existente != null)
                throw new Exception("Ya existe un cliente con ese DNI.");

            // Preparamos el cliente cifrando el email antes de mandarlo a la DAL
            Cliente_14OR clienteParaGuardar = PrepararClienteParaGuardar_14OR(c);

            int r = dal.Alta_14OR(clienteParaGuardar);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Crear, 2);
            return r;
        }

        public int Modificar_14OR(Cliente_14OR c)
        {
            if (c.IdCliente_14OR <= 0)
                throw new Exception("No se selecciono ningun cliente para modificar.");

            Validar_14OR(c);

            // Si cambio el DNI, controlo que no choque con otro cliente
            Cliente_14OR existente = BuscarPorDniParaNegocio_14OR(c.DNI_14OR);
            if (existente != null && existente.IdCliente_14OR != c.IdCliente_14OR)
                throw new Exception("Ya existe otro cliente con ese DNI.");

            // Preparamos el cliente cifrando el email antes de mandarlo a la DAL
            Cliente_14OR clienteParaGuardar = PrepararClienteParaGuardar_14OR(c);

            int r = dal.Modificar_14OR(clienteParaGuardar);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.modificar, 2);
            return r;
        }

        public int Baja_14OR(int idCliente)
        {
            if (idCliente <= 0)
                throw new Exception("No se selecciono ningun cliente para eliminar.");
            int r = dal.Baja_14OR(idCliente);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Desactivar, 3);
            return r;
        }

        // Busca el cliente por DNI y lo desencripta. Devuelve null si no existe.
        public Cliente_14OR BuscarPorDni_14OR(int dni)
        {
            if (dni <= 0)
                throw new Exception("Ingresa un DNI valido.");

            Cliente_14OR c = dal.BuscarPorDni_14OR(dni);
            return DesencriptarCliente_14OR(c);
        }

        // Método interno auxiliar para buscar sin romper la recursividad de desencriptación si fuera necesario
        private Cliente_14OR BuscarPorDniParaNegocio_14OR(int dni)
        {
            return dal.BuscarPorDni_14OR(dni); // Sin desencriptar para validaciones internas si no hace falta
        }

        // Marca a un cliente existente como socio.
        public void Suscribir_14OR(int idCliente)
        {
            if (idCliente <= 0)
                throw new Exception("Cliente invalido.");
            dal.Suscribir_14OR(idCliente, true);
            bllBi.GuardarLog_43BO(Modulo_43BO.Ventas, Evento_43BO.Suscripcion, 2);
        }

        public Cliente_14OR AltaSocioRapido_14OR(Cliente_14OR c)
        {
            c.Suscriptor_14OR = true;
            int id = Alta_14OR(c);
            c.IdCliente_14OR = id;
            return c;
        }

        // ---- seguridad  y helpers ----

        private Cliente_14OR PrepararClienteParaGuardar_14OR(Cliente_14OR c)
        {
            // Creamos un clon/copia temporal para no modificar el objeto original que maneja la UI
            Cliente_14OR cDb = new Cliente_14OR();
            cDb.IdCliente_14OR = c.IdCliente_14OR;
            cDb.DNI_14OR = c.DNI_14OR;
            cDb.Nombre_14OR = c.Nombre_14OR;
            cDb.Apellido_14OR = c.Apellido_14OR;
            cDb.Telefono_14OR = c.Telefono_14OR;
            cDb.Suscriptor_14OR = c.Suscriptor_14OR;

            // Encriptamos el email antes de enviarlo a la DAL
            if (!string.IsNullOrWhiteSpace(c.Email_14OR))
            {
                cDb.Email_14OR = CriptoManager_43BO.Encriptar_43BO(c.Email_14OR);
            }
            else
            {
                cDb.Email_14OR = null;
            }

            return cDb;
        }

        private Cliente_14OR DesencriptarCliente_14OR(Cliente_14OR c)
        {
            if (c != null && !string.IsNullOrWhiteSpace(c.Email_14OR))
            {
                try
                {
                    c.Email_14OR = CriptoManager_43BO.Desencriptar_43BO(c.Email_14OR);
                }
                catch
                {
                    // Si falla al desencriptar (ej. texto plano viejo), lo dejamos como está
                }
            }
            return c;
        }

        private List<Cliente_14OR> DesencriptarLista_14OR(List<Cliente_14OR> lista)
        {
            foreach (Cliente_14OR c in lista)
            {
                DesencriptarCliente_14OR(c);
            }
            return lista;
        }

        // ---- VALIDACIÓN COMÚN ----

        private void Validar_14OR(Cliente_14OR c)
        {
            if (c == null)
                throw new Exception("No llegaron los datos del cliente.");

            if (string.IsNullOrWhiteSpace(c.Nombre_14OR))
                throw new Exception("El nombre no puede quedar vacio.");

            if (string.IsNullOrWhiteSpace(c.Apellido_14OR))
                throw new Exception("El apellido no puede quedar vacio.");

            if (c.DNI_14OR <= 0)
                throw new Exception("El DNI tiene que ser un numero valido.");
        }

        // ---- SERIALIZACIÓN XML ----

        public void SerializarXml_14OR(List<Cliente_14OR> clientes, string ruta)
        {
            if (clientes == null)
                throw new Exception("No hay clientes para serializar.");
            if (string.IsNullOrWhiteSpace(ruta))
                throw new Exception("Elegi la ubicacion del archivo XML.");

            ClientesXml_14OR contenedor = new ClientesXml_14OR();
            contenedor.Clientes_14OR = clientes;

            XmlSerializer serializador = new XmlSerializer(typeof(ClientesXml_14OR));
            using (StreamWriter writer = new StreamWriter(ruta, false, Encoding.UTF8))
            {
                serializador.Serialize(writer, contenedor);
            }
        }

        public List<Cliente_14OR> DeserializarXml_14OR(string ruta)
        {
            if (string.IsNullOrWhiteSpace(ruta) || !File.Exists(ruta))
                throw new Exception("No se encontro el archivo XML seleccionado.");

            XmlSerializer serializador = new XmlSerializer(typeof(ClientesXml_14OR));
            using (StreamReader reader = new StreamReader(ruta))
            {
                ClientesXml_14OR contenedor = serializador.Deserialize(reader) as ClientesXml_14OR;
                if (contenedor == null || contenedor.Clientes_14OR == null)
                    throw new Exception("El archivo XML no tiene el formato de clientes esperado.");
                return contenedor.Clientes_14OR;
            }
        }
    }
}
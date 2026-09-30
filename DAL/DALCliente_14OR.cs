using BE;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class DALCliente_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        public List<Cliente_14OR> Listar_14OR()
        {
            // solo clientes NO eliminados (borrado logico)
            string query = @"SELECT IdCliente_14OR, DNI_14OR, Nombre_14OR, Apellido_14OR,
                                    Email_14OR, Telefono_14OR, Suscriptor_14OR
                             FROM Cliente_14OR
                             WHERE Eliminado_14OR = 0";
            return MapearLista_14OR(acceso.Leer_43BO(query));
        }

        public Cliente_14OR BuscarPorDni_14OR(int dni)
        {
            string query = @"SELECT IdCliente_14OR, DNI_14OR, Nombre_14OR, Apellido_14OR,
                                    Email_14OR, Telefono_14OR, Suscriptor_14OR
                             FROM Cliente_14OR
                             WHERE DNI_14OR = @dni AND Eliminado_14OR = 0";
            SqlParameter[] p = { new SqlParameter("@dni", dni) };
            List<Cliente_14OR> lista = MapearLista_14OR(acceso.Leer_43BO(query, p));
            return lista.Count > 0 ? lista[0] : null;
        }

        public int Alta_14OR(Cliente_14OR c)
        {
            string query = @"INSERT INTO Cliente_14OR
                                (DNI_14OR, Nombre_14OR, Apellido_14OR, Email_14OR, Telefono_14OR, Suscriptor_14OR)
                             VALUES (@dni, @nom, @ape, @mail, @tel, @sus);
                             SELECT CAST(SCOPE_IDENTITY() AS int);";
            return acceso.EjecutarScalar_43BO(query, ArmarParametros_14OR(c));
        }

        public int Modificar_14OR(Cliente_14OR c)
        {
            string query = @"UPDATE Cliente_14OR SET
                                DNI_14OR = @dni, Nombre_14OR = @nom, Apellido_14OR = @ape,
                                Email_14OR = @mail, Telefono_14OR = @tel, Suscriptor_14OR = @sus
                             WHERE IdCliente_14OR = @id";
            List<SqlParameter> ps = new List<SqlParameter>(ArmarParametros_14OR(c));
            ps.Add(new SqlParameter("@id", c.IdCliente_14OR));
            return acceso.Escribir_43BO(query, ps.ToArray());
        }

        // baja LOGICA: no borro fisicamente (el cliente puede tener ventas asociadas -> FK).
        // marco Eliminado_14OR = 1 y deja de aparecer en las listas, pero se conserva el historial.
        public int Baja_14OR(int idCliente)
        {
            string query = "UPDATE Cliente_14OR SET Eliminado_14OR = 1 WHERE IdCliente_14OR = @id";
            SqlParameter[] p = { new SqlParameter("@id", idCliente) };
            return acceso.Escribir_43BO(query, p);
        }

        public int Suscribir_14OR(int idCliente, bool suscriptor)
        {
            string query = "UPDATE Cliente_14OR SET Suscriptor_14OR = @sus WHERE IdCliente_14OR = @id";
            SqlParameter[] p = {
                new SqlParameter("@sus", suscriptor),
                new SqlParameter("@id", idCliente)
            };
            return acceso.Escribir_43BO(query, p);
        }

        // ---- HELPERS ----

        private SqlParameter[] ArmarParametros_14OR(Cliente_14OR c)
        {
            return new SqlParameter[] {
                new SqlParameter("@dni", c.DNI_14OR),
                new SqlParameter("@nom", c.Nombre_14OR),
                new SqlParameter("@ape", c.Apellido_14OR),
                // El email ya llega encriptado desde la BLL
                new SqlParameter("@mail", string.IsNullOrWhiteSpace(c.Email_14OR) ? (object)DBNull.Value : c.Email_14OR),
                new SqlParameter("@tel", string.IsNullOrWhiteSpace(c.Telefono_14OR) ? (object)DBNull.Value : c.Telefono_14OR),
                new SqlParameter("@sus", c.Suscriptor_14OR)
            };
        }

        private List<Cliente_14OR> MapearLista_14OR(DataTable tabla)
        {
            List<Cliente_14OR> lista = new List<Cliente_14OR>();
            foreach (DataRow fila in tabla.Rows)
            {
                Cliente_14OR c = new Cliente_14OR();
                c.IdCliente_14OR = Convert.ToInt32(fila["IdCliente_14OR"]);
                c.DNI_14OR = Convert.ToInt32(fila["DNI_14OR"]);
                c.Nombre_14OR = fila["Nombre_14OR"].ToString();
                c.Apellido_14OR = fila["Apellido_14OR"].ToString();
                // La DAL ya no desencripta: devuelve el texto crudo (cifrado) tal cual viene de la BD
                c.Email_14OR = fila["Email_14OR"] == DBNull.Value ? "" : fila["Email_14OR"].ToString();
                c.Telefono_14OR = fila["Telefono_14OR"] == DBNull.Value ? "" : fila["Telefono_14OR"].ToString();
                c.Suscriptor_14OR = Convert.ToBoolean(fila["Suscriptor_14OR"]);
                lista.Add(c);
            }
            return lista;
        }
    }
}
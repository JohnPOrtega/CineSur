using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;

namespace DAL
{
    public class DALProveedor_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // proveedores acitvos
        public List<Proveedor_14OR> ListarProveedor_14OR()
        {
            List<Proveedor_14OR> lista = new List<Proveedor_14OR>();

            string query = @"SELECT IdProveedor_14OR, Nombre_14OR, Cuit_14OR, Telefono_14OR, Email_14OR, Activo_14OR
                             FROM Proveedor_14OR
                             WHERE Activo_14OR = 1
                             ORDER BY Nombre_14OR";

            DataTable tabla = acceso.Leer_43BO(query);

            foreach (DataRow fila in tabla.Rows)
            {
                lista.Add(MapearProveedor_14OR(fila));
            }

            return lista;
        }

        public int AltaProveedor_14OR(Proveedor_14OR pr)
        {
            string query = @"INSERT INTO Proveedor_14OR
                                (Nombre_14OR, Cuit_14OR, Telefono_14OR, Email_14OR, Activo_14OR)
                             VALUES (@nombre, @cuit, @tel, @mail, 1)";

            SqlParameter[] parametros = {
                new SqlParameter("@nombre", pr.Nombre_14OR),
                new SqlParameter("@cuit", pr.Cuit_14OR),
                new SqlParameter("@tel", string.IsNullOrEmpty(pr.Telefono_14OR) ? (object)DBNull.Value : pr.Telefono_14OR),
                new SqlParameter("@mail", string.IsNullOrEmpty(pr.Email_14OR) ? (object)DBNull.Value : pr.Email_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        public int ModificarProveedor_14OR(Proveedor_14OR pr)
        {
            string query = @"UPDATE Proveedor_14OR
                             SET Nombre_14OR = @nombre, Cuit_14OR = @cuit, Telefono_14OR = @tel, Email_14OR = @mail
                             WHERE IdProveedor_14OR = @id";

            SqlParameter[] parametros = {
                new SqlParameter("@id", pr.IdProveedor_14OR),
                new SqlParameter("@nombre", pr.Nombre_14OR),
                new SqlParameter("@cuit", pr.Cuit_14OR),
                new SqlParameter("@tel", string.IsNullOrEmpty(pr.Telefono_14OR) ? (object)DBNull.Value : pr.Telefono_14OR),
                new SqlParameter("@mail", string.IsNullOrEmpty(pr.Email_14OR) ? (object)DBNull.Value : pr.Email_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        // baja logica, igual que producto. Si ya estaba de baja no toca ninguna fila y devuelve 0
        public int BajaProveedor_14OR(int idProveedor)
        {
            string query = "UPDATE Proveedor_14OR SET Activo_14OR = 0 WHERE IdProveedor_14OR = @id AND Activo_14OR = 1";

            SqlParameter[] parametros = { new SqlParameter("@id", idProveedor) };

            return acceso.Escribir_43BO(query, parametros);
        }

        // busca el cuit entre los activos, sin contar al mismo proveedor cuando se modifica.
        // uso Leer y no EjecutarScalar xq ese recalcula el dv y aca solo estoy leyendo
        public bool ExisteCuit_14OR(string cuit, int idExcluir)
        {
            string query = @"SELECT COUNT(*) FROM Proveedor_14OR
                             WHERE Cuit_14OR = @cuit AND Activo_14OR = 1 AND IdProveedor_14OR <> @id";

            SqlParameter[] parametros = {
                new SqlParameter("@cuit", cuit),
                new SqlParameter("@id", idExcluir)
            };

            return Convert.ToInt32(acceso.Leer_43BO(query, parametros).Rows[0][0]) > 0;
        }

        // presupuestos sin resolver u ordenes sin cerrar, con eso no se puede dar de baja
        public bool TieneDocumentosAbiertos_14OR(int idProveedor)
        {
            string query = @"SELECT
                                (SELECT COUNT(*) FROM Presupuesto_14OR
                                 WHERE IdProveedor_14OR = @id AND Estado_14OR IN (@pedido, @recibido))
                              + (SELECT COUNT(*) FROM OrdenCompra_14OR
                                 WHERE IdProveedor_14OR = @id AND Estado_14OR IN (@abierta, @pagada))";

            SqlParameter[] parametros = {
                new SqlParameter("@id", idProveedor),
                new SqlParameter("@pedido", Presupuesto_14OR.EstadoPedido_14OR),
                new SqlParameter("@recibido", Presupuesto_14OR.EstadoRecibido_14OR),
                new SqlParameter("@abierta", OrdenCompra_14OR.EstadoAbierta_14OR),
                new SqlParameter("@pagada", OrdenCompra_14OR.EstadoPagada_14OR)
            };

            return Convert.ToInt32(acceso.Leer_43BO(query, parametros).Rows[0][0]) > 0;
        }

        private Proveedor_14OR MapearProveedor_14OR(DataRow fila)
        {
            Proveedor_14OR pr = new Proveedor_14OR();
            pr.IdProveedor_14OR = Convert.ToInt32(fila["IdProveedor_14OR"]);
            pr.Nombre_14OR = fila["Nombre_14OR"].ToString();
            pr.Cuit_14OR = fila["Cuit_14OR"] != DBNull.Value ? fila["Cuit_14OR"].ToString() : "";
            pr.Telefono_14OR = fila["Telefono_14OR"] != DBNull.Value ? fila["Telefono_14OR"].ToString() : "";
            pr.Email_14OR = fila["Email_14OR"] != DBNull.Value ? fila["Email_14OR"].ToString() : "";
            pr.Activo_14OR = Convert.ToBoolean(fila["Activo_14OR"]);
            return pr;
        }
    }
}

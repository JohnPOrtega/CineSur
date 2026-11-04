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
    public class DALPresupuesto_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // Pide un presupuesto a un proveedor: inserta la cabecera (estado "Pedido") y sus renglones
        // (con precio cotizado en 0, porque todavia no lo respondio). Todo atomico. Devuelve el Id.
        public int PedirPresupuesto_14OR(Presupuesto_14OR pre)
        {
            using (SqlConnection con = new SqlConnection(AccesoBD_43BO.ConnectionString))
            {
                con.Open();
                using (SqlTransaction tran = con.BeginTransaction())
                {
                    try
                    {
                        int idPre;
                        string qCab = @"INSERT INTO Presupuesto_14OR
                                            (NumeroPresupuesto_14OR, IdProveedor_14OR, FechaPedido_14OR, Estado_14OR)
                                        VALUES (0, @prov, @fecha, @estado);
                                        SELECT CAST(SCOPE_IDENTITY() AS int);";
                        using (SqlCommand cm = new SqlCommand(qCab, con, tran))
                        {
                            cm.Parameters.AddWithValue("@prov", pre.IdProveedor_14OR);
                            cm.Parameters.AddWithValue("@fecha", pre.FechaPedido_14OR);
                            cm.Parameters.AddWithValue("@estado", pre.Estado_14OR);
                            idPre = Convert.ToInt32(cm.ExecuteScalar());
                        }

                        using (SqlCommand cm = new SqlCommand(
                            "UPDATE Presupuesto_14OR SET NumeroPresupuesto_14OR = @id WHERE IdPresupuesto_14OR = @id", con, tran))
                        {
                            cm.Parameters.AddWithValue("@id", idPre);
                            cm.ExecuteNonQuery();
                        }

                        foreach (DetallePresupuesto_14OR d in pre.Detalles)
                        {
                            using (SqlCommand cm = new SqlCommand(
                                @"INSERT INTO DetallePresupuesto_14OR
                                      (IdPresupuesto_14OR, IdProducto_14OR, NombreProducto_14OR, Cantidad_14OR, PrecioCotizado_14OR)
                                  VALUES (@idpre, @idprod, @nombre, @cant, @precio)", con, tran))
                            {
                                cm.Parameters.AddWithValue("@idpre", idPre);
                                cm.Parameters.AddWithValue("@idprod", d.IdProducto_14OR);
                                cm.Parameters.AddWithValue("@nombre", d.NombreProducto_14OR ?? "");
                                cm.Parameters.AddWithValue("@cant", d.Cantidad_14OR);
                                cm.Parameters.AddWithValue("@precio", (decimal)d.PrecioCotizado_14OR);
                                cm.ExecuteNonQuery();
                            }
                        }

                        tran.Commit();
                        DALdv_43BO.RecalcularTrasPersistencia_43BO();
                        return idPre;
                    }
                    catch
                    {
                        try { tran.Rollback(); } catch { }
                        throw;
                    }
                }
            }
        }

        // Carga los precios que cotizo el proveedor y pasa el presupuesto a "Recibido".
        public void CargarCotizacion_14OR(Presupuesto_14OR pre)
        {
            using (SqlConnection con = new SqlConnection(AccesoBD_43BO.ConnectionString))
            {
                con.Open();
                using (SqlTransaction tran = con.BeginTransaction())
                {
                    try
                    {
                        foreach (DetallePresupuesto_14OR d in pre.Detalles)
                        {
                            using (SqlCommand cm = new SqlCommand(
                                "UPDATE DetallePresupuesto_14OR SET PrecioCotizado_14OR = @precio WHERE IdDetallePresupuesto_14OR = @id", con, tran))
                            {
                                cm.Parameters.AddWithValue("@precio", (decimal)d.PrecioCotizado_14OR);
                                cm.Parameters.AddWithValue("@id", d.IdDetallePresupuesto_14OR);
                                cm.ExecuteNonQuery();
                            }
                        }

                        using (SqlCommand cm = new SqlCommand(
                            "UPDATE Presupuesto_14OR SET Estado_14OR = @estado WHERE IdPresupuesto_14OR = @id", con, tran))
                        {
                            cm.Parameters.AddWithValue("@estado", Presupuesto_14OR.EstadoRecibido_14OR);
                            cm.Parameters.AddWithValue("@id", pre.IdPresupuesto_14OR);
                            cm.ExecuteNonQuery();
                        }

                        tran.Commit();
                        DALdv_43BO.RecalcularTrasPersistencia_43BO();
                    }
                    catch
                    {
                        try { tran.Rollback(); } catch { }
                        throw;
                    }
                }
            }
        }

        // cambia solo el estado (lo uso para "Rechazado"; "Aceptado" lo hace la orden de compra).
        public int CambiarEstado_14OR(int idPresupuesto, string nuevoEstado)
        {
            SqlParameter[] p = {
                new SqlParameter("@estado", nuevoEstado),
                new SqlParameter("@id", idPresupuesto)
            };
            return acceso.Escribir_43BO(
                "UPDATE Presupuesto_14OR SET Estado_14OR = @estado WHERE IdPresupuesto_14OR = @id", p);
        }

        // lista de cabeceras con el nombre del proveedor (para la grilla)
        public List<Presupuesto_14OR> Listar_14OR()
        {
            List<Presupuesto_14OR> lista = new List<Presupuesto_14OR>();

            string query = @"SELECT pr.IdPresupuesto_14OR, pr.NumeroPresupuesto_14OR, pr.IdProveedor_14OR,
                                    pv.Nombre_14OR AS NombreProveedor, pr.FechaPedido_14OR, pr.Estado_14OR
                             FROM Presupuesto_14OR pr
                             INNER JOIN Proveedor_14OR pv ON pv.IdProveedor_14OR = pr.IdProveedor_14OR
                             ORDER BY pr.IdPresupuesto_14OR DESC";

            DataTable tabla = acceso.Leer_43BO(query);

            foreach (DataRow f in tabla.Rows)
            {
                Presupuesto_14OR pre = new Presupuesto_14OR();
                pre.IdPresupuesto_14OR = Convert.ToInt32(f["IdPresupuesto_14OR"]);
                pre.NumeroPresupuesto_14OR = Convert.ToInt32(f["NumeroPresupuesto_14OR"]);
                pre.IdProveedor_14OR = Convert.ToInt32(f["IdProveedor_14OR"]);
                pre.NombreProveedor_14OR = f["NombreProveedor"].ToString();
                pre.FechaPedido_14OR = Convert.ToDateTime(f["FechaPedido_14OR"]);
                pre.Estado_14OR = f["Estado_14OR"].ToString();
                lista.Add(pre);
            }

            return lista;
        }

        public int ObtenerIdProveedor_14OR(int idPresupuesto)
        {
            SqlParameter[] p = { new SqlParameter("@id", idPresupuesto) };
            DataTable tabla = acceso.Leer_43BO(
                "SELECT IdProveedor_14OR FROM Presupuesto_14OR WHERE IdPresupuesto_14OR = @id", p);

            return tabla.Rows.Count > 0 ? Convert.ToInt32(tabla.Rows[0][0]) : 0;
        }

        // renglones de un presupuesto
        public List<DetallePresupuesto_14OR> ObtenerDetalle_14OR(int idPresupuesto)
        {
            List<DetallePresupuesto_14OR> lista = new List<DetallePresupuesto_14OR>();

            SqlParameter[] p = { new SqlParameter("@id", idPresupuesto) };
            DataTable tabla = acceso.Leer_43BO(
                @"SELECT IdDetallePresupuesto_14OR, IdPresupuesto_14OR, IdProducto_14OR,
                         NombreProducto_14OR, Cantidad_14OR, PrecioCotizado_14OR
                  FROM DetallePresupuesto_14OR
                  WHERE IdPresupuesto_14OR = @id", p);

            foreach (DataRow f in tabla.Rows)
            {
                DetallePresupuesto_14OR d = new DetallePresupuesto_14OR();
                d.IdDetallePresupuesto_14OR = Convert.ToInt32(f["IdDetallePresupuesto_14OR"]);
                d.IdPresupuesto_14OR = Convert.ToInt32(f["IdPresupuesto_14OR"]);
                d.IdProducto_14OR = Convert.ToInt32(f["IdProducto_14OR"]);
                d.NombreProducto_14OR = f["NombreProducto_14OR"].ToString();
                d.Cantidad_14OR = Convert.ToInt32(f["Cantidad_14OR"]);
                d.PrecioCotizado_14OR = Convert.ToDouble(f["PrecioCotizado_14OR"]);
                lista.Add(d);
            }

            return lista;
        }
    }
}

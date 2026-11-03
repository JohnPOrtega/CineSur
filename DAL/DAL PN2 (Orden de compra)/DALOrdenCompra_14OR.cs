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
    public class DALOrdenCompra_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // Genera la Orden de Compra "Abierta" a partir de un presupuesto aceptado, de forma atomica:
        //   1) inserta la cabecera de la orden,
        //   2) inserta sus renglones (precio de costo = el cotizado que aceptamos)
        //   3) marca el presupuesto de origen como "Aceptado".
        // Devuelve el Id de la orden generada
        public int GenerarDesdePresupuesto_14OR(OrdenCompra_14OR orden)
        {
            using (SqlConnection con = new SqlConnection(AccesoBD_43BO.ConnectionString))
            {
                con.Open();
                using (SqlTransaction tran = con.BeginTransaction())
                {
                    try
                    {
                        int idOrden;
                        string qCab = @"INSERT INTO OrdenCompra_14OR
                                            (NumeroOrden_14OR, IdProveedor_14OR, IdPresupuesto_14OR,
                                             FechaEmision_14OR, Estado_14OR, Importe_14OR)
                                        VALUES (0, @prov, @pre, @fecha, @estado, @importe);
                                        SELECT CAST(SCOPE_IDENTITY() AS int);";
                        using (SqlCommand cm = new SqlCommand(qCab, con, tran))
                        {
                            cm.Parameters.AddWithValue("@prov", orden.IdProveedor_14OR);
                            cm.Parameters.AddWithValue("@pre", orden.IdPresupuesto_14OR);
                            cm.Parameters.AddWithValue("@fecha", orden.FechaEmision_14OR);
                            cm.Parameters.AddWithValue("@estado", orden.Estado_14OR);
                            cm.Parameters.AddWithValue("@importe", (decimal)orden.Importe_14OR);
                            idOrden = Convert.ToInt32(cm.ExecuteScalar());
                        }

                        using (SqlCommand cm = new SqlCommand(
                            "UPDATE OrdenCompra_14OR SET NumeroOrden_14OR = @id WHERE IdOrdenCompra_14OR = @id", con, tran))
                        {
                            cm.Parameters.AddWithValue("@id", idOrden);
                            cm.ExecuteNonQuery();
                        }

                        foreach (DetalleOrdenCompra_14OR d in orden.Detalles)
                        {
                            using (SqlCommand cm = new SqlCommand(
                                @"INSERT INTO DetalleOrdenCompra_14OR
                                      (IdOrdenCompra_14OR, IdProducto_14OR, NombreProducto_14OR, Cantidad_14OR, PrecioCosto_14OR)
                                  VALUES (@idorden, @idprod, @nombre, @cant, @precio)", con, tran))
                            {
                                cm.Parameters.AddWithValue("@idorden", idOrden);
                                cm.Parameters.AddWithValue("@idprod", d.IdProducto_14OR);
                                cm.Parameters.AddWithValue("@nombre", d.NombreProducto_14OR ?? "");
                                cm.Parameters.AddWithValue("@cant", d.Cantidad_14OR);
                                cm.Parameters.AddWithValue("@precio", (decimal)d.PrecioCosto_14OR);
                                cm.ExecuteNonQuery();
                            }
                        }

                        // marco el presupuesto de origen como aceptado (en la misma transaccion)
                        using (SqlCommand cm = new SqlCommand(
                            "UPDATE Presupuesto_14OR SET Estado_14OR = @estado WHERE IdPresupuesto_14OR = @id", con, tran))
                        {
                            cm.Parameters.AddWithValue("@estado", Presupuesto_14OR.EstadoAceptado_14OR);
                            cm.Parameters.AddWithValue("@id", orden.IdPresupuesto_14OR);
                            cm.ExecuteNonQuery();
                        }

                        tran.Commit();
                        DALdv_43BO.RecalcularTrasPersistencia_43BO();
                        return idOrden;
                    }
                    catch
                    {
                        try { tran.Rollback(); } catch { }
                        throw;
                    }
                }
            }
        }

        // lista de ordenes con el nombre del proveedor (para la grilla)
        public List<OrdenCompra_14OR> Listar_14OR()
        {
            List<OrdenCompra_14OR> lista = new List<OrdenCompra_14OR>();

            string query = @"SELECT oc.IdOrdenCompra_14OR, oc.NumeroOrden_14OR, oc.IdProveedor_14OR,
                                    pv.Nombre_14OR AS NombreProveedor, oc.IdPresupuesto_14OR,
                                    oc.FechaEmision_14OR, oc.Estado_14OR, oc.Importe_14OR,
                                    oc.FechaPago_14OR, oc.NumeroRemito_14OR, oc.FechaRecepcion_14OR
                             FROM OrdenCompra_14OR oc
                             INNER JOIN Proveedor_14OR pv ON pv.IdProveedor_14OR = oc.IdProveedor_14OR
                             ORDER BY oc.IdOrdenCompra_14OR DESC";

            DataTable tabla = acceso.Leer_43BO(query);

            foreach (DataRow f in tabla.Rows)
            {
                OrdenCompra_14OR oc = new OrdenCompra_14OR();
                oc.IdOrdenCompra_14OR = Convert.ToInt32(f["IdOrdenCompra_14OR"]);
                oc.NumeroOrden_14OR = Convert.ToInt32(f["NumeroOrden_14OR"]);
                oc.IdProveedor_14OR = Convert.ToInt32(f["IdProveedor_14OR"]);
                oc.NombreProveedor_14OR = f["NombreProveedor"].ToString();
                oc.IdPresupuesto_14OR = Convert.ToInt32(f["IdPresupuesto_14OR"]);
                oc.FechaEmision_14OR = Convert.ToDateTime(f["FechaEmision_14OR"]);
                oc.Estado_14OR = f["Estado_14OR"].ToString();
                oc.Importe_14OR = Convert.ToDouble(f["Importe_14OR"]);
                oc.FechaPago_14OR = f["FechaPago_14OR"] != DBNull.Value ? (DateTime?)Convert.ToDateTime(f["FechaPago_14OR"]) : null;
                oc.NumeroRemito_14OR = f["NumeroRemito_14OR"] != DBNull.Value ? f["NumeroRemito_14OR"].ToString() : "";
                oc.FechaRecepcion_14OR = f["FechaRecepcion_14OR"] != DBNull.Value ? (DateTime?)Convert.ToDateTime(f["FechaRecepcion_14OR"]) : null;
                lista.Add(oc);
            }

            return lista;
        }

        // renglones de una orden
        public List<DetalleOrdenCompra_14OR> ObtenerDetalle_14OR(int idOrden)
        {
            List<DetalleOrdenCompra_14OR> lista = new List<DetalleOrdenCompra_14OR>();

            SqlParameter[] p = { new SqlParameter("@id", idOrden) };
            DataTable tabla = acceso.Leer_43BO(
                @"SELECT IdDetalleOrdenCompra_14OR, IdOrdenCompra_14OR, IdProducto_14OR,
                         NombreProducto_14OR, Cantidad_14OR, PrecioCosto_14OR
                  FROM DetalleOrdenCompra_14OR
                  WHERE IdOrdenCompra_14OR = @id", p);

            foreach (DataRow f in tabla.Rows)
            {
                DetalleOrdenCompra_14OR d = new DetalleOrdenCompra_14OR();
                d.IdDetalleOrdenCompra_14OR = Convert.ToInt32(f["IdDetalleOrdenCompra_14OR"]);
                d.IdOrdenCompra_14OR = Convert.ToInt32(f["IdOrdenCompra_14OR"]);
                d.IdProducto_14OR = Convert.ToInt32(f["IdProducto_14OR"]);
                d.NombreProducto_14OR = f["NombreProducto_14OR"].ToString();
                d.Cantidad_14OR = Convert.ToInt32(f["Cantidad_14OR"]);
                d.PrecioCosto_14OR = Convert.ToDouble(f["PrecioCosto_14OR"]);
                lista.Add(d);
            }

            return lista;
        }

        // pago la orden: la paso de "Abierta" a "Pagada" y le guardo la fecha de pago.
        // el AND estado='Abierta' me cubre pa no pagar dos veces la misma orden
        // devuelve las filas tocadas (0 si no estaba abierta)
        public int PagarCompra_14OR(int idOrden, DateTime fechaPago)
        {
            string query = @"UPDATE OrdenCompra_14OR
                             SET Estado_14OR = @estado, FechaPago_14OR = @fecha
                             WHERE IdOrdenCompra_14OR = @id AND Estado_14OR = @abierta";

            SqlParameter[] parametros = {
                new SqlParameter("@estado", OrdenCompra_14OR.EstadoPagada_14OR),
                new SqlParameter("@fecha", fechaPago),
                new SqlParameter("@id", idOrden),
                new SqlParameter("@abierta", OrdenCompra_14OR.EstadoAbierta_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        // registro la recepcion de la mercaderia todo junto en una transaccion: paso la orden
        // de "Pagada" a "Cerrada", le guardo el remito y la fecha, y le sumo el stock a cada
        // producto que vino. si la orden no estaba pagada no toco anda y aviso. devuelve el id
        public int RegistrarIngresoMercaderia_14OR(OrdenCompra_14OR orden)
        {
            using (SqlConnection con = new SqlConnection(AccesoBD_43BO.ConnectionString))
            {
                con.Open();
                using (SqlTransaction tran = con.BeginTransaction())
                {
                    try
                    {
                        int filas;
                        using (SqlCommand cm = new SqlCommand(
                            @"UPDATE OrdenCompra_14OR
                                 SET Estado_14OR = @estado, NumeroRemito_14OR = @remito, FechaRecepcion_14OR = @fecha
                               WHERE IdOrdenCompra_14OR = @id AND Estado_14OR = @pagada", con, tran))
                        {
                            cm.Parameters.AddWithValue("@estado", OrdenCompra_14OR.EstadoCerrada_14OR);
                            cm.Parameters.AddWithValue("@remito", orden.NumeroRemito_14OR ?? "");
                            cm.Parameters.AddWithValue("@fecha",
                                orden.FechaRecepcion_14OR.HasValue ? (object)orden.FechaRecepcion_14OR.Value : DateTime.Today);
                            cm.Parameters.AddWithValue("@id", orden.IdOrdenCompra_14OR);
                            cm.Parameters.AddWithValue("@pagada", OrdenCompra_14OR.EstadoPagada_14OR);
                            filas = cm.ExecuteNonQuery();
                        }

                        if (filas == 0)
                            throw new Exception("La orden no esta en estado 'Pagada' (no se puede recibir).");

                        foreach (DetalleOrdenCompra_14OR d in orden.Detalles)
                        {
                            using (SqlCommand cm = new SqlCommand(
                                @"UPDATE Producto_14OR SET Stock_14OR = Stock_14OR + @cant
                                  WHERE IdProducto_14OR = @idprod", con, tran))
                            {
                                cm.Parameters.AddWithValue("@cant", d.Cantidad_14OR);
                                cm.Parameters.AddWithValue("@idprod", d.IdProducto_14OR);
                                cm.ExecuteNonQuery();
                            }
                        }

                        tran.Commit();
                        DALdv_43BO.RecalcularTrasPersistencia_43BO();
                        return orden.IdOrdenCompra_14OR;
                    }
                    catch
                    {
                        try { tran.Rollback(); } catch { }
                        throw;
                    }
                }
            }
        }
    }
}

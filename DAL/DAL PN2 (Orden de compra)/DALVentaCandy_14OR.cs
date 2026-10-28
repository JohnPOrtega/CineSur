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
    public class DALVentaCandy_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // Confirma la venta del candy de forma ATOMICA (otdo o nada):
        //   1) inserta la cabecera VentaCandy_14OR,
        //   2) por cada renglon inserta el detalle y descuenta el stock del producto
        //      controlando que haya stock suficiente (UPDATE ... WHERE Stock >= cantidad).
        // Si algun producto no tiene stock, se cae toda la operacion (rollback) y no queda
        // ni la venta ni descuentos a medias. Devuelve el Id de la venta gneerada.
        public int ConfirmarVenta_14OR(VentaCandy_14OR v)
        {
            using (SqlConnection con = new SqlConnection(AccesoBD_43BO.ConnectionString))
            {
                con.Open();
                using (SqlTransaction tran = con.BeginTransaction())
                {
                    try
                    {
                        // 1) cabecera: inserto con NumeroVenta provisorio 0 y me quedo con el id nuevo
                        int idVenta;
                        string qCab = @"INSERT INTO VentaCandy_14OR
                                            (NumeroVenta_14OR, Fecha_14OR, Hora_14OR, MetodoPago_14OR, MontoTotal_14OR)
                                        VALUES (0, @fecha, @hora, @metodo, @monto);
                                        SELECT CAST(SCOPE_IDENTITY() AS int);";
                        using (SqlCommand cm = new SqlCommand(qCab, con, tran))
                        {
                            cm.Parameters.AddWithValue("@fecha", v.Fecha_14OR);
                            cm.Parameters.AddWithValue("@hora", v.Hora_14OR);
                            cm.Parameters.AddWithValue("@metodo", v.MetodoPago_14OR);
                            cm.Parameters.AddWithValue("@monto", (decimal)v.MontoTotal_14OR);
                            idVenta = Convert.ToInt32(cm.ExecuteScalar());
                        }

                        // dejo el NumeroVenta igual al id (mismo criterio que la venta de entradas)
                        using (SqlCommand cm = new SqlCommand(
                            "UPDATE VentaCandy_14OR SET NumeroVenta_14OR = @id WHERE IdVentaCandy_14OR = @id", con, tran))
                        {
                            cm.Parameters.AddWithValue("@id", idVenta);
                            cm.ExecuteNonQuery();
                        }

                        // 2) por cada renglon: detalle + descuento de stock con control
                        foreach (DetalleVentaCandy_14OR d in v.Detalles)
                        {
                            // descuento de stock controlado: solo si alcanza
                            using (SqlCommand cm = new SqlCommand(
                                @"UPDATE Producto_14OR
                                  SET Stock_14OR = Stock_14OR - @cant
                                  WHERE IdProducto_14OR = @idprod AND Stock_14OR >= @cant", con, tran))
                            {
                                cm.Parameters.AddWithValue("@cant", d.Cantidad_14OR);
                                cm.Parameters.AddWithValue("@idprod", d.IdProducto_14OR);
                                int filas = cm.ExecuteNonQuery();
                                if (filas == 0)
                                {
                                    // no habia stock suficiente: tiro la clave de mensaje traducible
                                    // (la UI la traduce; no se muestra SQL crudo)
                                    throw new Exception("candy_msg_sinstock|" + d.NombreProducto_14OR);
                                }
                            }

                            // detalle (guardo nombre y precio como foto del momento)
                            using (SqlCommand cm = new SqlCommand(
                                @"INSERT INTO DetalleVentaCandy_14OR
                                      (IdVentaCandy_14OR, IdProducto_14OR, NombreProducto_14OR, Cantidad_14OR, PrecioUnitario_14OR, Subtotal_14OR)
                                  VALUES (@idventa, @idprod, @nombre, @cant, @precio, @subtotal)", con, tran))
                            {
                                cm.Parameters.AddWithValue("@idventa", idVenta);
                                cm.Parameters.AddWithValue("@idprod", d.IdProducto_14OR);
                                cm.Parameters.AddWithValue("@nombre", d.NombreProducto_14OR ?? "");
                                cm.Parameters.AddWithValue("@cant", d.Cantidad_14OR);
                                cm.Parameters.AddWithValue("@precio", (decimal)d.PrecioUnitario_14OR);
                                cm.Parameters.AddWithValue("@subtotal", (decimal)d.Subtotal_14OR);
                                cm.ExecuteNonQuery();
                            }
                        }

                        tran.Commit();

                        // como escribi por fuera de AccesoBD.Escribir_43BO, recalculo el DV a mano
                        // (una sola vez, al final, con todo ya confirmado)
                        DALdv_43BO.RecalcularTrasPersistencia_43BO();

                        return idVenta;
                    }
                    catch
                    {
                        // cualquier problema: deshago todo
                        try { tran.Rollback(); } catch { }
                        throw;
                    }
                }
            }
        }

        // Historial de ventas del candy (cabeceras), por si despues armamos un reporte.
        public List<VentaCandy_14OR> Listar_14OR()
        {
            List<VentaCandy_14OR> lista = new List<VentaCandy_14OR>();

            string query = @"SELECT IdVentaCandy_14OR, NumeroVenta_14OR, Fecha_14OR, Hora_14OR,
                                    MetodoPago_14OR, MontoTotal_14OR
                             FROM VentaCandy_14OR
                             ORDER BY IdVentaCandy_14OR DESC";

            DataTable tabla = acceso.Leer_43BO(query);

            foreach (DataRow fila in tabla.Rows)
            {
                VentaCandy_14OR v = new VentaCandy_14OR();
                v.IdVentaCandy_14OR = Convert.ToInt32(fila["IdVentaCandy_14OR"]);
                v.NumeroVenta_14OR = Convert.ToInt32(fila["NumeroVenta_14OR"]);
                v.Fecha_14OR = Convert.ToDateTime(fila["Fecha_14OR"]);
                v.Hora_14OR = Convert.ToDateTime(fila["Hora_14OR"]);
                v.MetodoPago_14OR = fila["MetodoPago_14OR"].ToString();
                v.MontoTotal_14OR = Convert.ToDouble(fila["MontoTotal_14OR"]);
                lista.Add(v);
            }

            return lista;
        }
    }
}

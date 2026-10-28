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
    public class DALProducto_14OR
    {
        // mismo acceso a datos que el resto del sistema
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // traigo los productos activos (los dados de baja logica quedan afuera)
        public List<Producto_14OR> Listar_14OR()
        {
            List<Producto_14OR> lista = new List<Producto_14OR>();

            string query = @"SELECT IdProducto_14OR, Nombre_14OR, PrecioVenta_14OR,
                                    Stock_14OR, StockCritico_14OR, Activo_14OR, Imagen_14OR, PrecioCosto_14OR
                             FROM Producto_14OR
                             WHERE Activo_14OR = 1
                             ORDER BY Nombre_14OR";

            DataTable tabla = acceso.Leer_43BO(query);

            foreach (DataRow fila in tabla.Rows)
            {
                lista.Add(MapearProducto_14OR(fila));
            }

            return lista;
        }

        // productos que estan en o por debajo del stock critico (para avisar que hay que reponer)
        public List<Producto_14OR> ListarEnCritico_14OR()
        {
            List<Producto_14OR> lista = new List<Producto_14OR>();

            string query = @"SELECT IdProducto_14OR, Nombre_14OR, PrecioVenta_14OR,
                                    Stock_14OR, StockCritico_14OR, Activo_14OR, Imagen_14OR, PrecioCosto_14OR
                             FROM Producto_14OR
                             WHERE Activo_14OR = 1 AND Stock_14OR <= StockCritico_14OR
                             ORDER BY Nombre_14OR";

            DataTable tabla = acceso.Leer_43BO(query);

            foreach (DataRow fila in tabla.Rows)
            {
                lista.Add(MapearProducto_14OR(fila));
            }

            return lista;
        }

        // inserto un producto nuevo. el id lo pone la base (identity)
        public int Alta_14OR(Producto_14OR p)
        {
            string query = @"INSERT INTO Producto_14OR
                                (Nombre_14OR, PrecioVenta_14OR, Stock_14OR, StockCritico_14OR, Activo_14OR, Imagen_14OR, PrecioCosto_14OR)
                             VALUES (@nombre, @precio, @stock, @critico, 1, @imagen, @costo)";

            SqlParameter[] parametros = {
                new SqlParameter("@nombre", p.Nombre_14OR),
                new SqlParameter("@precio", p.PrecioVenta_14OR),
                new SqlParameter("@stock", p.Stock_14OR),
                new SqlParameter("@critico", p.StockCritico_14OR),
                // si no eligio imagen mando null a la base
                new SqlParameter("@imagen", string.IsNullOrEmpty(p.Imagen_14OR) ? (object)DBNull.Value : p.Imagen_14OR),
                new SqlParameter("@costo", p.PrecioCosto_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        // modifico los datos del producto buscandolo por id
        public int Modificar_14OR(Producto_14OR p)
        {
            string query = @"UPDATE Producto_14OR
                             SET Nombre_14OR = @nombre, PrecioVenta_14OR = @precio,
                                 Stock_14OR = @stock, StockCritico_14OR = @critico, Imagen_14OR = @imagen,
                                 PrecioCosto_14OR = @costo
                             WHERE IdProducto_14OR = @id";

            SqlParameter[] parametros = {
                new SqlParameter("@id", p.IdProducto_14OR),
                new SqlParameter("@nombre", p.Nombre_14OR),
                new SqlParameter("@precio", p.PrecioVenta_14OR),
                new SqlParameter("@stock", p.Stock_14OR),
                new SqlParameter("@critico", p.StockCritico_14OR),
                new SqlParameter("@imagen", string.IsNullOrEmpty(p.Imagen_14OR) ? (object)DBNull.Value : p.Imagen_14OR),
                new SqlParameter("@costo", p.PrecioCosto_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        // baja LOGICA: no borro la fila, solo la marco como inactiva.
        // asi no rompo las ordenes de compra que mas adelante van a apuntar al producto.
        public int Baja_14OR(int idProducto)
        {
            string query = "UPDATE Producto_14OR SET Activo_14OR = 0 WHERE IdProducto_14OR = @id";

            SqlParameter[] parametros = { new SqlParameter("@id", idProducto) };

            return acceso.Escribir_43BO(query, parametros);
        }

        // arma un Producto_14OR a partir de una fila de la abse
        private Producto_14OR MapearProducto_14OR(DataRow fila)
        {
            Producto_14OR p = new Producto_14OR();
            p.IdProducto_14OR = Convert.ToInt32(fila["IdProducto_14OR"]);
            p.Nombre_14OR = fila["Nombre_14OR"].ToString();
            p.PrecioVenta_14OR = Convert.ToDouble(fila["PrecioVenta_14OR"]);
            p.Stock_14OR = Convert.ToInt32(fila["Stock_14OR"]);
            p.StockCritico_14OR = Convert.ToInt32(fila["StockCritico_14OR"]);
            p.Activo_14OR = Convert.ToBoolean(fila["Activo_14OR"]);
            // la imagen puede venir null si el producto no tiene foto
            p.Imagen_14OR = (fila.Table.Columns.Contains("Imagen_14OR") && fila["Imagen_14OR"] != DBNull.Value)
                ? fila["Imagen_14OR"].ToString() : "";
            p.PrecioCosto_14OR = (fila.Table.Columns.Contains("PrecioCosto_14OR") && fila["PrecioCosto_14OR"] != DBNull.Value)
                ? Convert.ToDouble(fila["PrecioCosto_14OR"]) : 0;
            return p;
        }
    }
}

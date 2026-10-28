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
    public class DALVenta_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        
        // si hay cliente lo guarda sinoi  manda null consumidar final que no deseo suscribisre.
        // si hubo promo aplicada guarda el IdPromocion y el monto descontado.
        public int ConfirmarVenta_14OR(Venta_14OR v)
        {
            string query = @"INSERT INTO Venta_14OR
                                (NumeroVenta_14OR, IdCliente_14OR, IdPromocion_14OR, Fecha_14OR, Hora_14OR,
                                 Estado_14OR, MetodoPago_14OR, MontoTotal_14OR, MontoDescuento_14OR)
                             VALUES (0, @cli, @promo, @fecha, @hora, @estado, @metodo, @monto, @descuento);
                             DECLARE @id INT = CAST(SCOPE_IDENTITY() AS int);
                             UPDATE Venta_14OR SET NumeroVenta_14OR = @id WHERE IdVenta_14OR = @id;
                             SELECT @id;";

            SqlParameter[] p = {
                // si no hay cliente (consumidor final) mando null a la base
                new SqlParameter("@cli", (v.Cliente != null && v.Cliente.IdCliente_14OR > 0) ? (object)v.Cliente.IdCliente_14OR : DBNull.Value),
                // idem la promo: solo si realmente se aplico una
                new SqlParameter("@promo", (v.Promocion != null && v.Promocion.IdPromocion_14OR > 0) ? (object)v.Promocion.IdPromocion_14OR : DBNull.Value),
                new SqlParameter("@fecha", v.Fecha_14OR),
                new SqlParameter("@hora", v.Hora_14OR),
                new SqlParameter("@estado", v.Estado_14OR),
                new SqlParameter("@metodo", v.MetodoPago_14OR),
                new SqlParameter("@monto", (decimal)v.MontoTotal_14OR),
                new SqlParameter("@descuento", (decimal)v.MontoDescuento_14OR)
            };

            return acceso.EjecutarScalar_43BO(query, p);
        }
    }
}

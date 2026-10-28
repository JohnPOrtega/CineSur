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
    public class DALButaca_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // trae todas las butacas de una sala, ordenadas por fila y asiento.
        // lo uso para dibujar la distribucion de la sala
        public List<Butaca_14OR> ListarPorSala_14OR(int idSala)
        {
            List<Butaca_14OR> lista = new List<Butaca_14OR>();

            string query = @"SELECT IdButaca_14OR, IdSala_14OR, NumeroFila_14OR, NumeroAsiento_14OR
                             FROM Butaca_14OR
                             WHERE IdSala_14OR = @id
                             ORDER BY NumeroFila_14OR, NumeroAsiento_14OR";

            SqlParameter[] parametros = { new SqlParameter("@id", idSala) };

            DataTable tabla = acceso.Leer_43BO(query, parametros);

            foreach (DataRow fila in tabla.Rows)
            {
                Butaca_14OR b = new Butaca_14OR();
                b.IdButaca_14OR = Convert.ToInt32(fila["IdButaca_14OR"]);
                b.NumeroFila_14OR = Convert.ToInt32(fila["NumeroFila_14OR"]);
                b.NumeroAsiento_14OR = Convert.ToInt32(fila["NumeroAsiento_14OR"]);
                lista.Add(b);
            }

            return lista;
        }
    }
}

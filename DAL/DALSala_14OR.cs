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
    public class DALSala_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // traigo todas las salas para la grilla y para el combo de funciones
        public List<Sala_14OR> Listar_14OR()
        {
            List<Sala_14OR> lista = new List<Sala_14OR>();

            string query = "SELECT IdSala_14OR, Numero_14OR, Capacidad_14OR, Pasillos_14OR FROM Sala_14OR";

            DataTable tabla = acceso.Leer_43BO(query);

            foreach (DataRow fila in tabla.Rows)
            {
                Sala_14OR s = new Sala_14OR();
                s.IdSala_14OR = Convert.ToInt32(fila["IdSala_14OR"]);
                s.Numero_14OR = Convert.ToInt32(fila["Numero_14OR"]);
                s.Capacidad_14OR = Convert.ToInt32(fila["Capacidad_14OR"]);
                // los pasillos pueden venir en null si la sala no tiene
                s.Pasillos_14OR = fila["Pasillos_14OR"] != DBNull.Value ? fila["Pasillos_14OR"].ToString() : "";
                lista.Add(s);
            }

            return lista;
        }

        // doy de alta la sala y genero todas sus butacas de una.
        // devuelvo el id que genero la base asi despues las butacas quedan bien enganchadas.
        public int Alta_14OR(Sala_14OR s, int filas, int asientosPorFila)
        {
            // primero inserto la sala y me traigo el id nuevo (identity) con SCOPE_IDENTITY
            string qSala = "INSERT INTO Sala_14OR (Numero_14OR, Capacidad_14OR, Pasillos_14OR) VALUES (@num, @cap, @pas); " +
                           "SELECT CAST(SCOPE_IDENTITY() AS int);";
            SqlParameter[] pSala = {
                new SqlParameter("@num", s.Numero_14OR),
                new SqlParameter("@cap", s.Capacidad_14OR),
                new SqlParameter("@pas", string.IsNullOrEmpty(s.Pasillos_14OR) ? (object)DBNull.Value : s.Pasillos_14OR)
            };
            int idSala = acceso.EjecutarScalar_43BO(qSala, pSala);

            // ahora genero la grilla completa de butacas para esa sala
            GenerarButacas_14OR(idSala, filas, asientosPorFila);

            return idSala;
        }

        // arma UN solo insert con todas las butacas (fila 1..filas, asiento 1..asientosPorFila).
        // lo hago en un solo comando asi no dispara mil veces el recalculo del digito verificador
        private void GenerarButacas_14OR(int idSala, int filas, int asientosPorFila)
        {
            StringBuilder valores = new StringBuilder();
            List<SqlParameter> parametros = new List<SqlParameter>();
            int i = 0;

            for (int f = 1; f <= filas; f++)
            {
                for (int a = 1; a <= asientosPorFila; a++)
                {
                    if (i > 0) valores.Append(",");
                    valores.Append("(@s" + i + ",@f" + i + ",@a" + i + ")");
                    parametros.Add(new SqlParameter("@s" + i, idSala));
                    parametros.Add(new SqlParameter("@f" + i, f));
                    parametros.Add(new SqlParameter("@a" + i, a));
                    i++;
                }
            }

            string query = "INSERT INTO Butaca_14OR (IdSala_14OR, NumeroFila_14OR, NumeroAsiento_14OR) VALUES " +
                           valores.ToString();

            acceso.Escribir_43BO(query, parametros.ToArray());
        }

        // en la modificacion solo dejo cambiar el numero de sala (no la grilla, que ya tiene butacas usadas)
        public int Modificar_14OR(Sala_14OR s)
        {
            string query = "UPDATE Sala_14OR SET Numero_14OR = @num, Pasillos_14OR = @pas WHERE IdSala_14OR = @id";
            SqlParameter[] parametros = {
                new SqlParameter("@id", s.IdSala_14OR),
                new SqlParameter("@num", s.Numero_14OR),
                new SqlParameter("@pas", string.IsNullOrEmpty(s.Pasillos_14OR) ? (object)DBNull.Value : s.Pasillos_14OR)
            };
            return acceso.Escribir_43BO(query, parametros);
        }

        // borro primero las butacas y despues la sala.
        // si alguna butaca esta usada por una funcion, la fk lo frena (es lo esperado)
        public int Baja_14OR(int idSala)
        {
            acceso.Escribir_43BO("DELETE FROM Butaca_14OR WHERE IdSala_14OR = @id",
                new SqlParameter[] { new SqlParameter("@id", idSala) });

            return acceso.Escribir_43BO("DELETE FROM Sala_14OR WHERE IdSala_14OR = @id",
                new SqlParameter[] { new SqlParameter("@id", idSala) });
        }
    }
}

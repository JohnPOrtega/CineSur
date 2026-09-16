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
    public class DALAsientoFuncion_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // cuantos asientos tiene ya generados una funcion. lo uso para saber si hace falta
        // "materializar" (crear todas las filas Libre) la primera vez que abro el mapa
        public int ContarAsientos_14OR(int idFuncion)
        {
            string query = "SELECT COUNT(*) FROM AsientoFuncion_14OR WHERE IdFuncion_14OR = @f";
            SqlParameter[] p = { new SqlParameter("@f", idFuncion) };
            return acceso.EjecutarScalar_43BO(query, p);
        }

        // genera de una todos los asientos de la funcion, uno por cada butaca de la sala, en Libre.
        // es el paso que casi todos se saltan: sin esto el mapa no tiene de donde leer los estados.
        // lo hago con un INSERT ... SELECT asi es un solo comando
        public int GenerarParaFuncion_14OR(int idFuncion, int idSala)
        {
            string query = @"INSERT INTO AsientoFuncion_14OR (IdFuncion_14OR, IdButaca_14OR, Estado_14OR, Ingreso_14OR)
                             SELECT @f, b.IdButaca_14OR, 'Libre', 0
                             FROM Butaca_14OR b
                             WHERE b.IdSala_14OR = @s";
            SqlParameter[] p = {
                new SqlParameter("@f", idFuncion),
                new SqlParameter("@s", idSala)
            };
            return acceso.Escribir_43BO(query, p);
        }

        // trae el mapa de la funcion: cada butaca con su fila/asiento y el estado que tiene en esta funcion.
        // ordenado por fila y asiento asi el dibujo sale prolijo
        public List<AsientoFuncion_14OR> ObtenerMapa_14OR(int idFuncion)
        {
            string query = @"SELECT AF.Estado_14OR, AF.Ingreso_14OR,
                                    B.IdButaca_14OR, B.NumeroFila_14OR, B.NumeroAsiento_14OR
                             FROM AsientoFuncion_14OR AF
                             INNER JOIN Butaca_14OR B ON AF.IdButaca_14OR = B.IdButaca_14OR
                             WHERE AF.IdFuncion_14OR = @f
                             ORDER BY B.NumeroFila_14OR, B.NumeroAsiento_14OR";
            SqlParameter[] p = { new SqlParameter("@f", idFuncion) };

            DataTable tabla = acceso.Leer_43BO(query, p);
            List<AsientoFuncion_14OR> lista = new List<AsientoFuncion_14OR>();

            foreach (DataRow fila in tabla.Rows)
            {
                AsientoFuncion_14OR af = new AsientoFuncion_14OR();
                af.Estado_14OR = fila["Estado_14OR"].ToString();
                af.Ingreso_14OR = Convert.ToBoolean(fila["Ingreso_14OR"]);

                af.Butaca = new Butaca_14OR();
                af.Butaca.IdButaca_14OR = Convert.ToInt32(fila["IdButaca_14OR"]);
                af.Butaca.NumeroFila_14OR = Convert.ToInt32(fila["NumeroFila_14OR"]);
                af.Butaca.NumeroAsiento_14OR = Convert.ToInt32(fila["NumeroAsiento_14OR"]);

                lista.Add(af);
            }

            return lista;
        }

        // cuantas butacas quedan para vender (libres o accesibles). lo uso en la lista de funciones
        public int ContarLibres_14OR(int idFuncion)
        {
            string query = @"SELECT COUNT(*) FROM AsientoFuncion_14OR
                             WHERE IdFuncion_14OR = @f AND Estado_14OR IN ('Libre','Accesible')";
            SqlParameter[] p = { new SqlParameter("@f", idFuncion) };
            return acceso.EjecutarScalar_43BO(query, p);
        }

        // EL metodo importante del CUN-001: reservar sin pisarse con otro vendedor.
        // no leo-y-despues-marco (entre esos dos pasos otro me la roba), lo hago en UN solo UPDATE
        // que cambia SOLO las que siguen Libres, y cuento cuantas filas toco.
        // si toque las mismas que pedi -> todas estaban libres -> reserva ok (true).
        // si toque menos -> alguna ya no estaba libre -> aviso conflicto (false).
        public bool ReservarSiLibres_14OR(int idFuncion, List<int> idsButacas)
        {
            if (idsButacas == null || idsButacas.Count == 0) return false;

            // armo el IN (@b0,@b1,...) con parametros, NUNCA concatenando ids (inyeccion)
            List<string> nombres = new List<string>();
            List<SqlParameter> parametros = new List<SqlParameter>();
            parametros.Add(new SqlParameter("@f", idFuncion));

            for (int i = 0; i < idsButacas.Count; i++)
            {
                string nom = "@b" + i;
                nombres.Add(nom);
                parametros.Add(new SqlParameter(nom, idsButacas[i]));
            }

            string query = @"UPDATE AsientoFuncion_14OR
                             SET Estado_14OR = 'Reservada'
                             WHERE IdFuncion_14OR = @f
                               AND Estado_14OR = 'Libre'
                               AND IdButaca_14OR IN (" + string.Join(",", nombres) + ")";

            int filas = acceso.Escribir_43BO(query, parametros.ToArray());

            // solo es exito si todas las que pedi estaban libres y quedaron reservadas
            return filas == idsButacas.Count;
        }
    }
}

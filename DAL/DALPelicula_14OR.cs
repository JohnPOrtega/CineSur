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
    public class DALPelicula_14OR
    {
        // uso el mismo acceso a datos que el resto del sistema
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // aca traigo todas las pelis de la base para mostrar en la grilla
        public List<Pelicula_14OR> Listar_14OR()
        {
            List<Pelicula_14OR> lista = new List<Pelicula_14OR>();

            string query = "SELECT IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR FROM Pelicula_14OR";

            DataTable tabla = acceso.Leer_43BO(query);

            foreach (DataRow fila in tabla.Rows)
            {
                Pelicula_14OR p = new Pelicula_14OR();
                p.IdPelicula_14OR = Convert.ToInt32(fila["IdPelicula_14OR"]);
                p.Titulo_14OR = fila["Titulo_14OR"].ToString();
                p.Genero_14OR = fila["Genero_14OR"].ToString();
                p.Duracion_14OR = Convert.ToInt32(fila["Duracion_14OR"]);
                // el poster puede venir en null si la peli no tiene afiche todavia
                p.Poster_14OR = fila["Poster_14OR"] != DBNull.Value ? fila["Poster_14OR"].ToString() : "";
                lista.Add(p);
            }

            return lista;
        }

        // pelis que estan EN CARTELERA = las que tienen al menos una funcion de hoy en adelante.
        // es lo que se muestra en la primera pantalla del CUN-001 (el catalogo con afiches).
        public List<Pelicula_14OR> ListarEnCartelera_14OR()
        {
            List<Pelicula_14OR> lista = new List<Pelicula_14OR>();

            string query = @"SELECT DISTINCT P.IdPelicula_14OR, P.Titulo_14OR, P.Genero_14OR,
                                    P.Duracion_14OR, P.Poster_14OR
                             FROM Pelicula_14OR P
                             INNER JOIN Funcion_14OR F ON F.IdPelicula_14OR = P.IdPelicula_14OR
                             WHERE F.Fecha_14OR >= @hoy
                             ORDER BY P.Titulo_14OR";

            SqlParameter[] parametros = { new SqlParameter("@hoy", DateTime.Today) };

            DataTable tabla = acceso.Leer_43BO(query, parametros);

            foreach (DataRow fila in tabla.Rows)
            {
                Pelicula_14OR p = new Pelicula_14OR();
                p.IdPelicula_14OR = Convert.ToInt32(fila["IdPelicula_14OR"]);
                p.Titulo_14OR = fila["Titulo_14OR"].ToString();
                p.Genero_14OR = fila["Genero_14OR"].ToString();
                p.Duracion_14OR = Convert.ToInt32(fila["Duracion_14OR"]);
                p.Poster_14OR = fila["Poster_14OR"] != DBNull.Value ? fila["Poster_14OR"].ToString() : "";
                lista.Add(p);
            }

            return lista;
        }

        // inserto una peli nueva. el id lo pone la base sola (identity), asi que no lo mando
        public int Alta_14OR(Pelicula_14OR p)
        {
            string query = "INSERT INTO Pelicula_14OR (Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR) " +
                           "VALUES (@titulo, @genero, @duracion, @poster)";

            SqlParameter[] parametros = {
                new SqlParameter("@titulo", p.Titulo_14OR),
                new SqlParameter("@genero", p.Genero_14OR),
                new SqlParameter("@duracion", p.Duracion_14OR),
                // si no eligio poster mando null a la base
                new SqlParameter("@poster", string.IsNullOrEmpty(p.Poster_14OR) ? (object)DBNull.Value : p.Poster_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        // modifico los datos de una peli que ya existe, buscandola por su id
        public int Modificar_14OR(Pelicula_14OR p)
        {
            string query = "UPDATE Pelicula_14OR SET Titulo_14OR = @titulo, Genero_14OR = @genero, " +
                           "Duracion_14OR = @duracion, Poster_14OR = @poster WHERE IdPelicula_14OR = @id";

            SqlParameter[] parametros = {
                new SqlParameter("@id", p.IdPelicula_14OR),
                new SqlParameter("@titulo", p.Titulo_14OR),
                new SqlParameter("@genero", p.Genero_14OR),
                new SqlParameter("@duracion", p.Duracion_14OR),
                new SqlParameter("@poster", string.IsNullOrEmpty(p.Poster_14OR) ? (object)DBNull.Value : p.Poster_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        // borro la peli por id. ojo: si tiene funciones cargadas va a saltar el error de la fk
        public int Baja_14OR(int idPelicula)
        {
            string query = "DELETE FROM Pelicula_14OR WHERE IdPelicula_14OR = @id";

            SqlParameter[] parametros = { new SqlParameter("@id", idPelicula) };

            return acceso.Escribir_43BO(query, parametros);
        }
    }
}

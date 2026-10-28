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
    public class DALPeliculaCambio_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // Lista el historico de cambios, con filtros opcionales (cualquiera puede venir en null).
        public List<PeliculaCambio_14OR> Filtrar_14OR(int? idPelicula, string titulo, DateTime? desde, DateTime? hasta)
        {
            List<PeliculaCambio_14OR> lista = new List<PeliculaCambio_14OR>();

            string query = @"SELECT IdCambio_14OR, IdPelicula_14OR, Titulo_14OR, Genero_14OR,
                                    Duracion_14OR, Poster_14OR, Act_14OR, TipoCambio_14OR, FechaHora_14OR
                             FROM Pelicula_C_14OR
                             WHERE (@idpel IS NULL OR IdPelicula_14OR = @idpel)
                               AND (@titulo IS NULL OR Titulo_14OR LIKE '%' + @titulo + '%')
                               AND (@desde IS NULL OR FechaHora_14OR >= @desde)
                               AND (@hasta IS NULL OR FechaHora_14OR < DATEADD(DAY, 1, @hasta))
                             ORDER BY IdPelicula_14OR ASC, IdCambio_14OR DESC";

            SqlParameter[] p = {
                new SqlParameter("@idpel", (idPelicula.HasValue && idPelicula.Value > 0) ? (object)idPelicula.Value : DBNull.Value),
                new SqlParameter("@titulo", string.IsNullOrWhiteSpace(titulo) ? (object)DBNull.Value : titulo.Trim()),
                new SqlParameter("@desde", desde.HasValue ? (object)desde.Value.Date : DBNull.Value),
                new SqlParameter("@hasta", hasta.HasValue ? (object)hasta.Value.Date : DBNull.Value)
            };

            DataTable tabla = acceso.Leer_43BO(query, p);

            foreach (DataRow f in tabla.Rows)
            {
                PeliculaCambio_14OR c = new PeliculaCambio_14OR();
                c.IdCambio_14OR = Convert.ToInt32(f["IdCambio_14OR"]);
                c.IdPelicula_14OR = Convert.ToInt32(f["IdPelicula_14OR"]);
                c.Titulo_14OR = f["Titulo_14OR"] != DBNull.Value ? f["Titulo_14OR"].ToString() : "";
                c.Genero_14OR = f["Genero_14OR"] != DBNull.Value ? f["Genero_14OR"].ToString() : "";
                c.Duracion_14OR = f["Duracion_14OR"] != DBNull.Value ? Convert.ToInt32(f["Duracion_14OR"]) : 0;
                c.Poster_14OR = f["Poster_14OR"] != DBNull.Value ? f["Poster_14OR"].ToString() : "";
                c.Act_14OR = Convert.ToBoolean(f["Act_14OR"]);
                c.TipoCambio_14OR = f["TipoCambio_14OR"].ToString();
                c.FechaHora_14OR = Convert.ToDateTime(f["FechaHora_14OR"]);
                lista.Add(c);
            }

            return lista;
        }

        // reactivo  una vesrion historica como vigente (rollback), via el stored procedure.
        public void Rollback_14OR(int idCambio)
        {
            SqlParameter[] p = { new SqlParameter("@IdCambio_14OR", idCambio) };
            acceso.Escribir_43BO("sp_RollbackPelicula_14OR", p, CommandType.StoredProcedure);
        }
    }
}

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
    public class DALFuncion_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // aca traigo las funciones con el titulo de la peli y el numero de sala de una
        // asi la grilla ya muestra los nombres y no los numeritos de id
        public List<Funcion_14OR> Listar_14OR()
        {
            string query = @"SELECT F.IdFuncion_14OR, F.Fecha_14OR, F.Horario_14OR, F.Formato_14OR,
                                    F.Idioma_14OR, F.Precio_14OR,
                                    P.IdPelicula_14OR, P.Titulo_14OR, P.Duracion_14OR,
                                    S.IdSala_14OR, S.Numero_14OR, S.Capacidad_14OR
                             FROM Funcion_14OR F
                             INNER JOIN Pelicula_14OR P ON F.IdPelicula_14OR = P.IdPelicula_14OR
                             INNER JOIN Sala_14OR S ON F.IdSala_14OR = S.IdSala_14OR";

            return MapearLista_14OR(acceso.Leer_43BO(query));
        }

        // esto lo uso para la regla de los 30 min: me traigo solo las funciones de esa sala
        // con la duracion de cada peli, asi puedo fijarme que no se pisen
        public List<Funcion_14OR> ListarPorSala_14OR(int idSala)
        {
            string query = @"SELECT F.IdFuncion_14OR, F.Fecha_14OR, F.Horario_14OR, F.Formato_14OR,
                                    F.Idioma_14OR, F.Precio_14OR,
                                    P.IdPelicula_14OR, P.Titulo_14OR, P.Duracion_14OR,
                                    S.IdSala_14OR, S.Numero_14OR, S.Capacidad_14OR
                             FROM Funcion_14OR F
                             INNER JOIN Pelicula_14OR P ON F.IdPelicula_14OR = P.IdPelicula_14OR
                             INNER JOIN Sala_14OR S ON F.IdSala_14OR = S.IdSala_14OR
                             WHERE F.IdSala_14OR = @idSala";

            SqlParameter[] parametros = { new SqlParameter("@idSala", idSala) };

            return MapearLista_14OR(acceso.Leer_43BO(query, parametros));
        }

        // funciones FUTURAS de una peli (de hoy en adelante), para la pantalla de horarios del CUN-001.
        // ordenadas por fecha y hora asi aparecen en orden
        public List<Funcion_14OR> ListarPorPelicula_14OR(int idPelicula)
        {
            string query = @"SELECT F.IdFuncion_14OR, F.Fecha_14OR, F.Horario_14OR, F.Formato_14OR,
                                    F.Idioma_14OR, F.Precio_14OR,
                                    P.IdPelicula_14OR, P.Titulo_14OR, P.Duracion_14OR,
                                    S.IdSala_14OR, S.Numero_14OR, S.Capacidad_14OR
                             FROM Funcion_14OR F
                             INNER JOIN Pelicula_14OR P ON F.IdPelicula_14OR = P.IdPelicula_14OR
                             INNER JOIN Sala_14OR S ON F.IdSala_14OR = S.IdSala_14OR
                             WHERE F.IdPelicula_14OR = @idPeli AND F.Fecha_14OR >= @hoy
                             ORDER BY F.Fecha_14OR, F.Horario_14OR";

            SqlParameter[] parametros = {
                new SqlParameter("@idPeli", idPelicula),
                new SqlParameter("@hoy", DateTime.Today)
            };

            return MapearLista_14OR(acceso.Leer_43BO(query, parametros));
        }

        public int Alta_14OR(Funcion_14OR f)
        {
            string query = @"INSERT INTO Funcion_14OR
                             (IdPelicula_14OR, IdSala_14OR, Fecha_14OR, Horario_14OR, Formato_14OR, Idioma_14OR, Precio_14OR)
                             VALUES (@idPeli, @idSala, @fecha, @horario, @formato, @idioma, @precio)";

            SqlParameter[] parametros = {
                new SqlParameter("@idPeli", f.Pelicula.IdPelicula_14OR),
                new SqlParameter("@idSala", f.Sala.IdSala_14OR),
                new SqlParameter("@fecha", f.Fecha_14OR),
                new SqlParameter("@horario", f.Horario_14OR),
                new SqlParameter("@formato", FormatoATexto_14OR(f.Formato_14OR)),
                new SqlParameter("@idioma", f.Idioma_14OR),
                new SqlParameter("@precio", (decimal)f.Precio_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        public int Modificar_14OR(Funcion_14OR f)
        {
            string query = @"UPDATE Funcion_14OR SET
                                IdPelicula_14OR = @idPeli, IdSala_14OR = @idSala, Fecha_14OR = @fecha,
                                Horario_14OR = @horario, Formato_14OR = @formato, Idioma_14OR = @idioma,
                                Precio_14OR = @precio
                             WHERE IdFuncion_14OR = @id";

            SqlParameter[] parametros = {
                new SqlParameter("@id", f.IdFuncion_14OR),
                new SqlParameter("@idPeli", f.Pelicula.IdPelicula_14OR),
                new SqlParameter("@idSala", f.Sala.IdSala_14OR),
                new SqlParameter("@fecha", f.Fecha_14OR),
                new SqlParameter("@horario", f.Horario_14OR),
                new SqlParameter("@formato", FormatoATexto_14OR(f.Formato_14OR)),
                new SqlParameter("@idioma", f.Idioma_14OR),
                new SqlParameter("@precio", (decimal)f.Precio_14OR)
            };

            return acceso.Escribir_43BO(query, parametros);
        }

        // borro la funcion. si ya tiene asientos generados va a saltar la fk, es lo esperado
        public int Baja_14OR(int idFuncion)
        {
            string query = "DELETE FROM Funcion_14OR WHERE IdFuncion_14OR = @id";
            SqlParameter[] parametros = { new SqlParameter("@id", idFuncion) };
            return acceso.Escribir_43BO(query, parametros);
        }

        // ---- helpers internos ----

        // paso de la tabla a la lista de objetos, cargando la peli y la sala adentro de la funcion
        private List<Funcion_14OR> MapearLista_14OR(DataTable tabla)
        {
            List<Funcion_14OR> lista = new List<Funcion_14OR>();

            foreach (DataRow fila in tabla.Rows)
            {
                Funcion_14OR f = new Funcion_14OR();
                f.IdFuncion_14OR = Convert.ToInt32(fila["IdFuncion_14OR"]);
                f.Fecha_14OR = Convert.ToDateTime(fila["Fecha_14OR"]);
                f.Horario_14OR = Convert.ToDateTime(fila["Horario_14OR"]);
                f.Formato_14OR = TextoAFormato_14OR(fila["Formato_14OR"].ToString());
                f.Idioma_14OR = fila["Idioma_14OR"].ToString();
                f.Precio_14OR = Convert.ToDouble(fila["Precio_14OR"]);

                // relleno la peli asociada (con la duracion que me sirve para la regla de los 30 min)
                f.Pelicula = new Pelicula_14OR();
                f.Pelicula.IdPelicula_14OR = Convert.ToInt32(fila["IdPelicula_14OR"]);
                f.Pelicula.Titulo_14OR = fila["Titulo_14OR"].ToString();
                f.Pelicula.Duracion_14OR = Convert.ToInt32(fila["Duracion_14OR"]);

                // relleno la sala asociada
                f.Sala = new Sala_14OR();
                f.Sala.IdSala_14OR = Convert.ToInt32(fila["IdSala_14OR"]);
                f.Sala.Numero_14OR = Convert.ToInt32(fila["Numero_14OR"]);
                f.Sala.Capacidad_14OR = Convert.ToInt32(fila["Capacidad_14OR"]);

                lista.Add(f);
            }

            return lista;
        }

        // en la base guardo el formato como texto (2D/3D/4DX), aca lo paso desde el enum
        private string FormatoATexto_14OR(FormatoFuncion_14OR formato)
        {
            if (formato == FormatoFuncion_14OR.DosD) return "2D";
            if (formato == FormatoFuncion_14OR.TresD) return "3D";
            return "4DX";
        }

        // y aca al reves, del texto de la base al enum
        private FormatoFuncion_14OR TextoAFormato_14OR(string texto)
        {
            if (texto == "3D") return FormatoFuncion_14OR.TresD;
            if (texto == "4DX") return FormatoFuncion_14OR.CuatroDX;
            return FormatoFuncion_14OR.DosD;
        }
    }
}

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
    public class DALReporte_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // RF1 - Listado de Funciones y Ocupacion de Sala.
        // Por cada funcion trae: pelicula, sala, fecha/hora, tickets vendidos, butacas disponibles
        // y recaudacion parcial (suma real de las ventas de esa funcion).
        //  - Vendidos     = asientos en 'Ocupada' o 'Utilizada' (Utilizada es el que ya ingreso).
        //  - Disponibles  = capacidad de la sala menos los vendidos (asi es correcto aunque la
        //                   funcion todavia no haya "materializado" sus asientos).
        //  - Recaudacion  = suma de MontoTotal de las ventas ligadas a esa funcion.
        public List<ReporteFuncionOcupacion_14OR> ListadoFuncionesOcupacion_14OR()
        {
            string query = @"
                SELECT
                    F.IdFuncion_14OR,
                    P.Titulo_14OR,
                    S.Numero_14OR,
                    F.Fecha_14OR,
                    F.Horario_14OR,
                    S.Capacidad_14OR,
                    (SELECT COUNT(*) FROM AsientoFuncion_14OR af
                       WHERE af.IdFuncion_14OR = F.IdFuncion_14OR
                         AND af.Estado_14OR IN ('Ocupada','Utilizada')) AS Vendidos,
                    ISNULL((SELECT SUM(v.MontoTotal_14OR)
                            FROM Venta_14OR v
                            WHERE v.IdVenta_14OR IN (
                                SELECT DISTINCT af2.IdVenta_14OR
                                FROM AsientoFuncion_14OR af2
                                WHERE af2.IdFuncion_14OR = F.IdFuncion_14OR
                                  AND af2.IdVenta_14OR IS NOT NULL)), 0) AS Recaudacion
                FROM Funcion_14OR F
                INNER JOIN Pelicula_14OR P ON F.IdPelicula_14OR = P.IdPelicula_14OR
                INNER JOIN Sala_14OR S ON F.IdSala_14OR = S.IdSala_14OR
                ORDER BY F.Fecha_14OR, F.Horario_14OR";

            DataTable tabla = acceso.Leer_43BO(query);
            List<ReporteFuncionOcupacion_14OR> lista = new List<ReporteFuncionOcupacion_14OR>();

            foreach (DataRow fila in tabla.Rows)
            {
                int capacidad = Convert.ToInt32(fila["Capacidad_14OR"]);
                int vendidos = Convert.ToInt32(fila["Vendidos"]);

                ReporteFuncionOcupacion_14OR r = new ReporteFuncionOcupacion_14OR();
                r.IdFuncion_14OR = Convert.ToInt32(fila["IdFuncion_14OR"]);
                r.Pelicula_14OR = fila["Titulo_14OR"].ToString();
                r.Sala_14OR = Convert.ToInt32(fila["Numero_14OR"]);
                r.Fecha_14OR = Convert.ToDateTime(fila["Fecha_14OR"]);
                r.Horario_14OR = Convert.ToDateTime(fila["Horario_14OR"]);
                r.TicketsVendidos_14OR = vendidos;
                r.ButacasDisponibles_14OR = capacidad - vendidos;
                r.RecaudacionParcial_14OR = Convert.ToDouble(fila["Recaudacion"]);
                lista.Add(r);
            }

            return lista;
        }
    }
}

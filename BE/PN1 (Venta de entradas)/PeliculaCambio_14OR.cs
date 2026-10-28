using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // Una fila de la bitacora de CAMBIOS de peliculas (tabla espejo Pelicula_C_14OR).
    // Es una "foto" de como estaab una pelicula en un momento dado. Act_14OR marca si es la
    // version vigente. Lo generan los triggers; la UI de Auditoria lo lee y puede reactivar
    // una version historica (rollback).
    public class PeliculaCambio_14OR
    {
        public int IdCambio_14OR { get; set; }
        public int IdPelicula_14OR { get; set; }
        public string Titulo_14OR { get; set; }
        public string Genero_14OR { get; set; }
        public int Duracion_14OR { get; set; }
        public string Poster_14OR { get; set; }

        // true = version vigente (Act = 1). Solo una por pelicula.
        public bool Act_14OR { get; set; }

        // Alta / Modificacion / Baja
        public string TipoCambio_14OR { get; set; }

        public DateTime FechaHora_14OR { get; set; }

        public PeliculaCambio_14OR()
        {
        }
    }
}

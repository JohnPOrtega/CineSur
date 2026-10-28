using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;
using Servicios;

namespace BLL
{
    public class BllPeliculaCambio_14OR
    {
        private DALPeliculaCambio_14OR dal = new DALPeliculaCambio_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // trae TODO el historico de cambios (sin filtrar). La UI lo carga una vez y despues
        // filtra en memoria con FiltrarEnMemoria_14OR (buscador en vivo).
        public List<PeliculaCambio_14OR> Listar_14OR()
        {
            return dal.Filtrar_14OR(null, null, null, null);
        }

        // Filtro en memoria con LINQ (toda la logica de filtrado vive aca, no en la UI):
        // - texto: busca en el titulo, sin importar mayusculas; cuantas mas letras, mas afina.
        // - desde / hasta: acotan por fecha del cambio (inclusive).
        public List<PeliculaCambio_14OR> FiltrarEnMemoria_14OR(
            List<PeliculaCambio_14OR> todos, string texto, DateTime? desde, DateTime? hasta)
        {
            if (todos == null) return new List<PeliculaCambio_14OR>();

            IEnumerable<PeliculaCambio_14OR> q = todos;

            if (!string.IsNullOrWhiteSpace(texto))
            {
                string t = texto.Trim().ToLower();
                q = q.Where(c => (c.Titulo_14OR ?? "").ToLower().Contains(t));
            }

            if (desde.HasValue)
                q = q.Where(c => c.FechaHora_14OR.Date >= desde.Value.Date);

            if (hasta.HasValue)
                q = q.Where(c => c.FechaHora_14OR.Date <= hasta.Value.Date);

            return q.OrderBy(c => c.IdPelicula_14OR)
                    .ThenByDescending(c => c.IdCambio_14OR)
                    .ToList();
        }

        // historico con filtros resueltos en la base (lo dejo por si hace falta filtrar en el servidor)
        public List<PeliculaCambio_14OR> Filtrar_14OR(int? idPelicula, string titulo, DateTime? desde, DateTime? hasta)
        {
            return dal.Filtrar_14OR(idPelicula, titulo, desde, hasta);
        }

        // reactiva una version historica como vigente (rollback)
        public void Rollback_14OR(int idCambio)
        {
            if (idCambio <= 0)
                throw new Exception("Selecciona una version del historico para reactivar.");

            dal.Rollback_14OR(idCambio);

            // el rollback es un cambio administrativo: queda en la bitacora de EVENTOS tambien
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.modificar, 3);
        }
    }
}

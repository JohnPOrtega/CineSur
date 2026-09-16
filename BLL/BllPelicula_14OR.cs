using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;

namespace BLL
{
    public class BllPelicula_14OR
    {
        private DALPelicula_14OR dal = new DALPelicula_14OR();

        // le paso la lista al formulario para la grilla
        public List<Pelicula_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }

        // pelis en cartelera (con funciones futuras), para el catalogo del CUN-001
        public List<Pelicula_14OR> ListarEnCartelera_14OR()
        {
            return dal.ListarEnCartelera_14OR();
        }

        // antes de dar de alta valido que no falte nada y que la duracion tenga sentido
        public int Alta_14OR(Pelicula_14OR p)
        {
            ValidarPelicula_14OR(p);
            return dal.Alta_14OR(p);
        }

        public int Modificar_14OR(Pelicula_14OR p)
        {
            // aca ademas de lo comun chequeo que venga el id sino no se a cual modificar
            if (p.IdPelicula_14OR <= 0)
                throw new Exception("No se selecciono ninguna pelicula para modificar.");

            ValidarPelicula_14OR(p);
            return dal.Modificar_14OR(p);
        }

        public int Baja_14OR(int idPelicula)
        {
            if (idPelicula <= 0)
                throw new Exception("No se selecciono ninguna pelicula para eliminar.");

            return dal.Baja_14OR(idPelicula);
        }

        // validaciones comunes al alta y a la modificacion, asi no repito codigo
        private void ValidarPelicula_14OR(Pelicula_14OR p)
        {
            if (p == null)
                throw new Exception("No llegaron los datos de la pelicula.");

            if (string.IsNullOrWhiteSpace(p.Titulo_14OR))
                throw new Exception("El titulo no puede quedar vacio.");

            if (string.IsNullOrWhiteSpace(p.Genero_14OR))
                throw new Exception("El genero no puede quedar vacio.");

            if (p.Duracion_14OR <= 0)
                throw new Exception("La duracion tiene que ser mayor a cero.");
        }
    }
}

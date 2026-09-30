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
    public class BllPelicula_14OR
    {
        private DALPelicula_14OR dal = new DALPelicula_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // le paso la lista al formulario para la grilla
        public List<Pelicula_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }

        // pelis en cartelera (con funciones futuras), para el catalogo del CUN-001
        public List<Pelicula_14OR>  ListarEnCartelera_14OR()
        {
            return dal.ListarEnCartelera_14OR();
        }

        // antes de dar de alta valido que no falte nada y que la duracion tenga sentido
        public int Alta_14OR(Pelicula_14OR p)
        {
            ValidarPelicula_14OR(p);
            int r = dal.Alta_14OR(p);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Crear, 2);
            return r;
        }

        public int Modificar_14OR(Pelicula_14OR p)
        {
            // aca ademas de lo comun chequeo que venga el id sino no se a cual modificar
            if (p.IdPelicula_14OR <= 0)
                throw new Exception("No se selecciono ninguna pelicula para modificar.");

            ValidarPelicula_14OR(p);
            int r = dal.Modificar_14OR(p);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.modificar, 2);
            return r;
        }

        public int Baja_14OR(int idPelicula)
        {
            if (idPelicula <= 0)
                throw new Exception("No se selecciono ninguna pelicula para eliminar.");

            try
            {
                int r = dal.Baja_14OR(idPelicula);
                bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Desactivar, 3);
                return r;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                // 547 = violacion de clave foranea: la peli esta programada en una o mas funciones.
                // no dejo salir el mensaje crudo de SQL: lanzo una clave de mensaje traducible.
                if (ex.Number == 547)
                    throw new Exception("error_pelicula_en_funciones");
                throw new Exception("error_no_se_pudo_eliminar");
            }
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

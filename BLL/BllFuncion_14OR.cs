using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;

namespace BLL
{
    public class BllFuncion_14OR
    {
        private DALFuncion_14OR dal = new DALFuncion_14OR();

        //PARTE FUNDAMENTAL, segun lo que vi el tiempo de mantemiento es si o si entre 10-5 minutos mas el tiepo de egreso e ingreso de las funciones 
        private const int MINUTOS_MANTENIMIENTO_14OR = 30;

        // recargos que se le suman al rprecio  base segun el formato y el idioma.
        // los dejo aca como constantes asi se me ahce mas facil cambiarlos despues
        private const double RECARGO_3D_14OR = 1500;   // 
        private const double RECARGO_4DX_14OR = 3000;  //
        private const double RECARGO_ORIGINAL_14OR = 800; // 

        public List<Funcion_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }

        // funciones futuras de una peli, para la pantalla de horarios 
        public List<Funcion_14OR> ListarPorPelicula_14OR(int idPelicula)
        {
            return dal.ListarPorPelicula_14OR(idPelicula);
        }

        public int Alta_14OR(Funcion_14OR f)
        {
            ValidarFuncion_14OR(f);

            // en el alta todavia no tiene id, asi que le paso 0 para que compare contra todas
            ValidarMantenimiento_14OR(f, 0);

            return dal.Alta_14OR(f);
        }

        public int Modificar_14OR(Funcion_14OR f)
        {
            if (f.IdFuncion_14OR <= 0)
                throw new Exception("No se selecciono ninguna funcion para modificar.");

            ValidarFuncion_14OR(f);

            // aca me salteo la propia funcion asi no se choca consigo misma
            ValidarMantenimiento_14OR(f, f.IdFuncion_14OR);

            return dal.Modificar_14OR(f);
        }

        public int Baja_14OR(int idFuncion)
        {
            if (idFuncion <= 0)
                throw new Exception("No se selecciono ninguna funcion para eliminar.");

            return dal.Baja_14OR(idFuncion);
        }

        // chequeo que esten cargados los datos minimos antes de tocar la base
        private void ValidarFuncion_14OR(Funcion_14OR f)
        {
            if (f == null)
                throw new Exception("No llegaron los datos de la funcion.");

            if (f.Pelicula == null || f.Pelicula.IdPelicula_14OR <= 0)
                throw new Exception("Tenes que elegir una pelicula.");

            if (f.Sala == null || f.Sala.IdSala_14OR <= 0)
                throw new Exception("Tenes que elegir una sala.");

            if (string.IsNullOrWhiteSpace(f.Idioma_14OR))
                throw new Exception("Tenes que elegir el idioma.");

            if (f.Precio_14OR <= 0)
                throw new Exception("El precio tiene que ser mayor a cero.");

            // vuelvo a poner validacion para que no se muestren fechas que ya pasaron 
            if (f.Fecha_14OR.Date < DateTime.Today)
                throw new Exception("No se puede poner una funcion en una fecha anterior a hoy.");
        }

        // calcula el precio final sumandole al precio base los recargos que se le fueron ageregando, podria haber usado decorator
        // pero quiero amntenerlo simple, si veo que funnciona y tengo timepo veo como acoplarlo al decorator 
        public double CalcularPrecioFinal_14OR(Funcion_14OR f)
        {
            double precioFinal = f.Precio_14OR;

            // recargo por formato (es uno solo, no se apilan)
            if (f.Formato_14OR == FormatoFuncion_14OR.TresD)
                precioFinal += RECARGO_3D_14OR;
            else if (f.Formato_14OR == FormatoFuncion_14OR.CuatroDX)
                precioFinal += RECARGO_4DX_14OR;

            // recargo por idioma (solo la version original suma, doblada y subtitulada van igual)
            if (f.Idioma_14OR == "Original")
                precioFinal += RECARGO_ORIGINAL_14OR;

            return precioFinal;
        }

        // esta es la regla importante: en una misma sala las funciones no se pueden pisar
        // y ademas tiene que haber 30 min libres entre el fin de una peli y el arranque de la otra
        private void ValidarMantenimiento_14OR(Funcion_14OR nueva, int idExcluir)
        {
            // validacion para poder tener tiempo de limpieza entre funciones, puede acoplarse 
            DateTime inicioNueva = nueva.Horario_14OR;
            DateTime finNueva = inicioNueva.AddMinutes(nueva.Pelicula.Duracion_14OR + MINUTOS_MANTENIMIENTO_14OR);

            // me traigo las funciones que ya estan en esa sala
            List<Funcion_14OR> deLaSala = dal.ListarPorSala_14OR(nueva.Sala.IdSala_14OR);

            foreach (Funcion_14OR ex in deLaSala)
            {
                // si es la misma funcion que estoy modificando la salteo
                if (ex.IdFuncion_14OR == idExcluir) continue;

                DateTime inicioEx = ex.Horario_14OR;
                DateTime finEx = inicioEx.AddMinutes(ex.Pelicula.Duracion_14OR + MINUTOS_MANTENIMIENTO_14OR);

                // si los dos bloques se pisan, no se puede
                bool sePisan = inicioNueva < finEx && inicioEx < finNueva;
                if (sePisan)
                {
                    throw new Exception(
                        "No se puede: la sala " + nueva.Sala.Numero_14OR + " ya tiene la funcion de las " +
                        inicioEx.ToString("HH:mm") + ". deben de haber al menos " + MINUTOS_MANTENIMIENTO_14OR +
                        " min de limpieza entre funcion y funcion.");
                }
            }
        }
    }
}

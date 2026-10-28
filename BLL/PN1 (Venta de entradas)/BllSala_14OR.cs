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
    public class BllSala_14OR
    {
        private DALSala_14OR dal = new DALSala_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // lo uso para la grilla del abm y para el combo de salas en funciones
        public List<Sala_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }

        // alta de sala: valido, calculo la capacidad sola y mando a generar las butacas
        public int Alta_14OR(Sala_14OR s, int filas, int asientosPorFila)
        {
            if (s == null)
                throw new Exception("No llegaron los datos de la sala.");

            if (s.Numero_14OR <= 0)
                throw new Exception("El numero de sala tiene que ser mayor a cero.");

            if (filas <= 0 || asientosPorFila <= 0)
                throw new Exception("Las filas y los asientos por fila tienen que ser mayores a cero.");

            // tope realista: una sala de cine no tiene mas de 12 filas ni mas de 20 asientos por fila
            if (filas > 12)
                throw new Exception("El maximo de filas es 12.");

            if (asientosPorFila > 20)
                throw new Exception("El maximo de asientos por fila es 20.");

            // no dejo repetir el numero de sala
            if (ExisteNumero_14OR(s.Numero_14OR, 0))
                throw new Exception("Ya existe una sala con ese numero.");

            // la capacidad no se carga a mano, sale de multiplicar filas por asientos
            s.Capacidad_14OR = filas * asientosPorFila;

            int r = dal.Alta_14OR(s, filas, asientosPorFila);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Crear, 2);
            return r;
        }

        // por ahora la modificacion solo cambia el numero de sala, no la grilla de butacas
        public int Modificar_14OR(Sala_14OR s)
        {
            if (s.IdSala_14OR <= 0)
                throw new Exception("No se selecciono ninguna sala para modificar.");

            if (s.Numero_14OR <= 0)
                throw new Exception("El numero de sala tiene que ser mayor a cero.");

            // mismo chequeo de numero repetido, pero dejando afuera la sala que estoy editando
            if (ExisteNumero_14OR(s.Numero_14OR, s.IdSala_14OR))
                throw new Exception("Ya existe otra sala con ese numero.");

            int r = dal.Modificar_14OR(s);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.modificar, 2);
            return r;
        }

        // devuelve true si ya hay una sala con ese numero.
        // idExcluir sirve para la modificacion: ignora la propia sala (le paso 0 en el alta)
        private bool ExisteNumero_14OR(int numero, int idExcluir)
        {
            return dal.Listar_14OR().Any(x => x.Numero_14OR == numero && x.IdSala_14OR != idExcluir);
        }

        public int Baja_14OR(int idSala)
        {
            if (idSala <= 0)
                throw new Exception("No se selecciono ninguna sala para eliminar.");

            try
            {
                int r = dal.Baja_14OR(idSala);
                bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Desactivar, 3);
                return r;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                // 547 = FK: la sala esta siendo usada por una o mas funciones.
                if (ex.Number == 547)
                    throw new Exception("error_sala_en_funciones");
                throw new Exception("error_no_se_pudo_eliminar");
            }
        }
    }
}

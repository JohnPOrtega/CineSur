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
    public class BllProveedor_14OR
    {
        private DALProveedor_14OR dal = new DALProveedor_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        public List<Proveedor_14OR> Listar_14OR()
        {
            return dal.Listar_14OR();
        }

        public int Alta_14OR(Proveedor_14OR pr)
        {
            ValidarProveedor_14OR(pr);
            int r = dal.Alta_14OR(pr);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Crear, 2);
            return r;
        }

        public int Modificar_14OR(Proveedor_14OR pr)
        {
            if (pr.IdProveedor_14OR <= 0)
                throw new Exception("No se selecciono ningun proveedor para modificar.");

            ValidarProveedor_14OR(pr);
            int r = dal.Modificar_14OR(pr);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.modificar, 2);
            return r;
        }

        public int Baja_14OR(int idProveedor)
        {
            if (idProveedor <= 0)
                throw new Exception("No se selecciono ningun proveedor para eliminar.");

            int r = dal.Baja_14OR(idProveedor);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Desactivar, 3);
            return r;
        }

        private void ValidarProveedor_14OR(Proveedor_14OR pr)
        {
            if (pr == null)
                throw new Exception("No llegaron los datos del proveedor.");

            if (string.IsNullOrWhiteSpace(pr.Nombre_14OR))
                throw new Exception("El nombre del proveedor no puede quedar vacio.");

            // el mail es opcional, pero si lo cargan controlo que tenga pinta de mail
            if (!string.IsNullOrWhiteSpace(pr.Email_14OR) && !pr.Email_14OR.Contains("@"))
                throw new Exception("El email del proveedor no parece valido.");
        }
    }
}

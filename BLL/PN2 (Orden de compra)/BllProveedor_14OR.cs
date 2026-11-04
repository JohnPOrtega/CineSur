using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
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

        public List<Proveedor_14OR> ListarProveedor_14OR()
        {
            return dal.ListarProveedor_14OR();
        }

        public int AltaProveedor_14OR(Proveedor_14OR pr)
        {
            ValidarProveedor_14OR(pr);
            int r = dal.AltaProveedor_14OR(pr);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Crear, 2);
            return r;
        }

        public int ModificarProveedor_14OR(Proveedor_14OR pr)
        {
            if (pr.IdProveedor_14OR <= 0)
                throw new Exception("No se selecciono ningun proveedor para modificar.");

            ValidarProveedor_14OR(pr);
            int r = dal.ModificarProveedor_14OR(pr);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.modificar, 2);
            return r;
        }

        public int BajaProveedor_14OR(int idProveedor)
        {
            if (idProveedor <= 0)
                throw new Exception("No se selecciono ningun proveedor para eliminar.");

            // con cosas pendientes no se puede, despues nadie lo encuentra para cerrarlas
            if (dal.TieneDocumentosAbiertos_14OR(idProveedor))
                throw new Exception("El proveedor tiene presupuestos u ordenes de compra abiertos. Cerralos antes de darlo de baja.");

            int r = dal.BajaProveedor_14OR(idProveedor);
            if (r == 0)
                throw new Exception("El proveedor no existe o ya fue dado de baja.");

            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Desactivar, 3);
            return r;
        }

        private void ValidarProveedor_14OR(Proveedor_14OR pr)
        {
            if (pr == null)
                throw new Exception("No llegaron los datos del proveedor.");

            if (string.IsNullOrWhiteSpace(pr.Nombre_14OR))
                throw new Exception("La razon social del proveedor no puede quedar vacia.");

            pr.Cuit_14OR = NormalizarCuit_14OR(pr.Cuit_14OR);

            // en alta el id viene en 0, en modif se excluye a si mismo
            if (dal.ExisteCuit_14OR(pr.Cuit_14OR, pr.IdProveedor_14OR))
                throw new Exception("Ya existe un proveedor activo con ese CUIT.");

            // el mail es opcional, pero si lo cargan controlo que tenga pinta de mail
            if (!string.IsNullOrWhiteSpace(pr.Email_14OR) && !Regex.IsMatch(pr.Email_14OR, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
                throw new Exception("El email del proveedor no parece valido.");
        }

        // lo dejo en 11 digitos pelados asi 20-12345678-6 y 20123456786 son el mismo apra la base
        private string NormalizarCuit_14OR(string cuit)
        {
            if (string.IsNullOrWhiteSpace(cuit))
                throw new Exception("El CUIT del proveedor es obligatorio.");

            string limpio = new string(cuit.Where(c => c != '-' && c != ' ' && c != '.').ToArray());

            if (limpio.Length != 11 || !limpio.All(c => c >= '0' && c <= '9'))
                throw new Exception("El CUIT debe tener 11 digitos.");

            // digito verificador del cuit: modulo 11 con estos pesos
            int[] pesos = { 5, 4, 3, 2, 7, 6, 5, 4, 3, 2 };
            int suma = 0;
            for (int i = 0; i < pesos.Length; i++)
                suma += (limpio[i] - '0') * pesos[i];

            int digito = 11 - (suma % 11);
            if (digito == 11) digito = 0;

            // si da 10 no hay digito posible, ese numero no sirve
            if (digito == 10 || digito != limpio[10] - '0')
                throw new Exception("El CUIT no es valido.");

            return limpio;
        }
    }
}

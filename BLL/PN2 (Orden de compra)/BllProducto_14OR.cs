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
    public class BllProducto_14OR
    {
        private DALProducto_14OR dal = new DALProducto_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        // lista para la grilla del abm (solo activos)
        public List<Producto_14OR> ListarProducto_14OR()
        {
            return dal.ListarProducto_14OR();
        }

        // productos que llegaron al stock critico, pra avisar que hay que reponer
        public List<Producto_14OR> ListarEnCritico_14OR()
        {
            return dal.ListarEnCritico_14OR();
        }

        public int AltaProducto_14OR(Producto_14OR p)
        {
            ValidarProducto_14OR(p);
            int r = dal.AltaProducto_14OR(p);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Crear, 2);
            return r;
        }

        public int ModificarProducto_14OR(Producto_14OR p)
        {
            if (p.IdProducto_14OR <= 0)
                throw new Exception("No se selecciono ningun producto para modificar.");

            ValidarProducto_14OR(p);
            int r = dal.ModificarProducto_14OR(p);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.modificar, 2);
            return r;
        }

        // baja logica: no se borra, se marca inactivo
        public int BajaProducto_14OR(int idProducto)
        {
            if (idProducto <= 0)
                throw new Exception("No se selecciono ningun producto para eliminar.");

            int r = dal.BajaProducto_14OR(idProducto);
            bllBi.GuardarLog_43BO(Modulo_43BO.Maestro, Evento_43BO.Desactivar, 3);
            return r;
        }

        // validaciones comunes al alta y a la modificacion
        private void ValidarProducto_14OR(Producto_14OR p)
        {
            if (p == null)
                throw new Exception("No llegaron los datos del producto.");

            if (string.IsNullOrWhiteSpace(p.Nombre_14OR))
                throw new Exception("El nombre del producto no puede quedar vacio.");

            if (p.PrecioVenta_14OR <= 0)
                throw new Exception("El precio de venta tiene que ser mayor a cero.");

            if (p.Stock_14OR < 0)
                throw new Exception("El stock no puede ser negativo.");

            if (p.StockCritico_14OR < 0)
                throw new Exception("El stock critico no puede ser negativo.");
        }
    }
}

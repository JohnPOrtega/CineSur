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
    public class DALPromocion_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // todas las promos, para la grilla del ABM
        public List<Promocion_14OR> Listar_14OR()
        {
            string query = @"SELECT IdPromocion_14OR, Nombre_14OR, Tipo_14OR, Valor_14OR,
                                    FechaInicio_14OR, FechaFin_14OR, Activa_14OR
                             FROM Promocion_14OR";
            return MapearLista_14OR(acceso.Leer_43BO(query));
        }

        // las que se pueden aplicar HOY: activas y con la fecha de hoy adentro del periodo.
        // esto lo usa la venta para elegir el mejor descuento del socio.
        public List<Promocion_14OR> ListarPVigentes_14OR()
        {
            string query = @"SELECT IdPromocion_14OR, Nombre_14OR, Tipo_14OR, Valor_14OR,
                                    FechaInicio_14OR, FechaFin_14OR, Activa_14OR
                             FROM Promocion_14OR
                             WHERE Activa_14OR = 1
                               AND @hoy >= FechaInicio_14OR
                               AND @hoy <= FechaFin_14OR";
            SqlParameter[] p = { new SqlParameter("@hoy", DateTime.Today) };
            return MapearLista_14OR(acceso.Leer_43BO(query, p));
        }

        public int Alta_14OR(Promocion_14OR p)
        {
            string query = @"INSERT INTO Promocion_14OR
                                (Nombre_14OR, Tipo_14OR, Valor_14OR, FechaInicio_14OR, FechaFin_14OR, Activa_14OR)
                             VALUES (@nom, @tipo, @val, @ini, @fin, @act)";
            return acceso.Escribir_43BO(query, ArmarParametros_14OR(p));
        }

        public int Modificar_14OR(Promocion_14OR p)
        {
            string query = @"UPDATE Promocion_14OR SET
                                Nombre_14OR = @nom, Tipo_14OR = @tipo, Valor_14OR = @val,
                                FechaInicio_14OR = @ini, FechaFin_14OR = @fin, Activa_14OR = @act
                             WHERE IdPromocion_14OR = @id";
            List<SqlParameter> ps = new List<SqlParameter>(ArmarParametros_14OR(p));
            ps.Add(new SqlParameter("@id", p.IdPromocion_14OR));
            return acceso.Escribir_43BO(query, ps.ToArray());
        }

        // borro la promo. si alguna venta ya la uso, la fk lo frena (es lo esperado);
        // para "desactivar" sin borrar esta el campo Activa.
        public int Baja_14OR(int idPromocion)
        {
            string query = "DELETE FROM Promocion_14OR WHERE IdPromocion_14OR = @id";
            SqlParameter[] p = { new SqlParameter("@id", idPromocion) };
            return acceso.Escribir_43BO(query, p);
        }

        // ---- helpers ----

        private SqlParameter[] ArmarParametros_14OR(Promocion_14OR p)
        {
            return new SqlParameter[] {
                new SqlParameter("@nom", p.Nombre_14OR),
                new SqlParameter("@tipo", TipoATexto_14OR(p.Tipo_14OR)),
                new SqlParameter("@val", (decimal)p.Valor_14OR),
                new SqlParameter("@ini", p.FechaInicio_14OR),
                new SqlParameter("@fin", p.FechaFin_14OR),
                new SqlParameter("@act", p.Activa_14OR)
            };
        }

        private List<Promocion_14OR> MapearLista_14OR(DataTable tabla)
        {
            List<Promocion_14OR> lista = new List<Promocion_14OR>();
            foreach (DataRow fila in tabla.Rows)
            {
                Promocion_14OR p = new Promocion_14OR();
                p.IdPromocion_14OR = Convert.ToInt32(fila["IdPromocion_14OR"]);
                p.Nombre_14OR = fila["Nombre_14OR"].ToString();
                p.Tipo_14OR = TextoATipo_14OR(fila["Tipo_14OR"].ToString());
                p.Valor_14OR = Convert.ToDouble(fila["Valor_14OR"]);
                p.FechaInicio_14OR = Convert.ToDateTime(fila["FechaInicio_14OR"]);
                p.FechaFin_14OR = Convert.ToDateTime(fila["FechaFin_14OR"]);
                p.Activa_14OR = Convert.ToBoolean(fila["Activa_14OR"]);
                lista.Add(p);
            }
            return lista;
        }

        // el tipo lo guardo como texto en la base (mas legible que un numero)
        private string TipoATexto_14OR(TipoPromocion_14OR tipo)
        {
            if (tipo == TipoPromocion_14OR.DosPorUno) return "2x1";
            return "Porcentaje";
        }

        private TipoPromocion_14OR TextoATipo_14OR(string texto)
        {
            if (texto == "2x1") return TipoPromocion_14OR.DosPorUno;
            return TipoPromocion_14OR.Porcentaje;
        }
    }
}

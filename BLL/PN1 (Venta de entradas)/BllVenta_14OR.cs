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
    // resultado de intentar reservar: o salio todo bien, o alguna butaca ya la agarro otro vendedor
    public enum ResultadoReserva_14OR { Ok, Conflicto }

    public class BllVenta_14OR
    {
        //DAl de asiento funcion
        private DALAsientoFuncion_14OR dalAF = new DALAsientoFuncion_14OR();
        private DALVenta_14OR dalVenta = new DALVenta_14OR();
        private BLLBitacora_43BO bllBi = new BLLBitacora_43BO();

        public ResultadoReserva_14OR ReservarButacas_14OR(int idFuncion, List<Butaca_14OR> butacas)
        {
            if (idFuncion <= 0)
                throw new Exception("Funcion invalida.");

            if (butacas == null || butacas.Count == 0)
                throw new Exception("Elegi al menos una butaca.");

            // sin limite de butacas por venta: el unico tope real es la capacidad de la sala.

            List<int> ids = butacas.Select(b => b.IdButaca_14OR).ToList();

            bool ok = dalAF.ReservarSiLibres_14OR(idFuncion, ids);

            return ok ? ResultadoReserva_14OR.Ok : ResultadoReserva_14OR.Conflicto;
        }

        // confirmar venta
        public int ConfirmarVenta_14OR(int idFuncion, List<Butaca_14OR> butacas, string metodoPago,
                                       double montoTotal, Cliente_14OR cliente, Promocion_14OR promo, double montoDescuento)
        {
            if (idFuncion <= 0)
                throw new Exception("Funcion invalida.");

            if (butacas == null || butacas.Count == 0)
                throw new Exception("No hay butacas para cobrar.");

            if (string.IsNullOrWhiteSpace(metodoPago))
                throw new Exception("Elegi un metodo de pago.");

            if (montoTotal < 0)
                throw new Exception("El monto no puede ser negativo.");

            // armo la venta con el cliente y la promo (si los hay)
            Venta_14OR v = new Venta_14OR();
            v.Fecha_14OR = DateTime.Today;
            v.Hora_14OR = DateTime.Now;
            v.Estado_14OR = "Pagada";
            v.MetodoPago_14OR = metodoPago;
            v.MontoTotal_14OR = montoTotal;
            v.MontoDescuento_14OR = montoDescuento;
            v.Cliente = cliente;
            v.Promocion = promo;

            int idVenta = dalVenta.ConfirmarVenta_14OR(v);

            // paso las butacas de Reservada a Ocupada y las asocio a la venta
            List<int> ids = butacas.Select(b => b.IdButaca_14OR).ToList();
            dalAF.OcuparYAsociar_14OR(idFuncion, ids, idVenta);

            // queda auditada la venta cobrada
            bllBi.GuardarLog_43BO(Modulo_43BO.Ventas, Evento_43BO.Cobro, 2);

            return idVenta;
        }

        // si se cancela el cobro, suelto la reserva asi las butacas vuelven a estar libres
        public void LiberarReserva_14OR(int idFuncion, List<Butaca_14OR> butacas)
        {
            if (butacas == null || butacas.Count == 0) return;
            List<int> ids = butacas.Select(b => b.IdButaca_14OR).ToList();
            dalAF.LiberarReserva_14OR(idFuncion, ids);
        }


        public void ValidarTarjeta_14OR(string numeroTarjeta, string vencimiento, string cvv)
        {
            string numero = (numeroTarjeta ?? "").Replace(" ", "").Replace("-", "");
            if (!LuhnValido_14OR(numero))
                throw new Exception("cobro_msg_tarjetanumero");

            if (!VencimientoValido_14OR(vencimiento))
                throw new Exception("cobro_msg_tarjetavenc");

            string cvvLimpio = (cvv ?? "").Trim();
            if (cvvLimpio.Length != 3 || !cvvLimpio.All(char.IsDigit))
                throw new Exception("cobro_msg_tarjetacvv");
        }

        public bool LuhnValido_14OR(string numero)
        {
            if (string.IsNullOrEmpty(numero) || numero.Length < 13 || numero.Length > 19) return false;
            if (!numero.All(char.IsDigit)) return false;

            int suma = 0;
            bool alterna = false;
            for (int i = numero.Length - 1; i >= 0; i--)
            {
                int d = numero[i] - '0';
                if (alterna)
                {
                    d *= 2;
                    if (d > 9) d -= 9;
                }
                suma += d;
                alterna = !alterna;
            }
            return suma % 10 == 0;
        }

        public bool VencimientoValido_14OR(string venc)
        {
            if (string.IsNullOrWhiteSpace(venc)) return false;
            venc = venc.Trim();

            string[] partes = venc.Split('/');
            if (partes.Length != 2) return false;

            int mes, año;
            if (!int.TryParse(partes[0], out mes) || !int.TryParse(partes[1], out año)) return false;
            if (mes < 1 || mes > 12) return false;

            año += 2000; 
            int ultimoDia = DateTime.DaysInMonth(año, mes);
            DateTime fin = new DateTime(año, mes, ultimoDia);
            return fin >= DateTime.Today;
        }
    }
}


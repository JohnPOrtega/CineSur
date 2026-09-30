    using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    public partial class Cobro : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllVenta_14OR bllVenta = new BllVenta_14OR();
        private BllPromocion_14OR bllPromo = new BllPromocion_14OR();
        private BllCliente_14OR bllCliente = new BllCliente_14OR();

        private Funcion_14OR funcion;
        private List<Butaca_14OR> butacas;
        private double precioUnit;
        private double subtotal;
        private double totalActual;

        private Cliente_14OR clienteActual = null;
        private Promocion_14OR promoActual = null;
        private double montoDescuentoActual = 0;
        private string modoAsociar = "";
        private int dniBuscado = 0;
        private bool socioConDescuento = false;
        private List<Promocion_14OR> promosDisponibles = new List<Promocion_14OR>();

        public Cobro(Funcion_14OR funcion, List<Butaca_14OR> butacas, double precioUnit)
        {
            this.funcion = funcion;
            this.butacas = butacas;
            this.precioUnit = precioUnit;
            this.subtotal = butacas.Count * precioUnit;

            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);

            this.Text = "Cobro - Venta";
            lblResumen.Text = funcion.Pelicula.Titulo_14OR + "  |  Sala " + funcion.Sala.Numero_14OR +
                              "  |  " + funcion.Fecha_14OR.ToString("dd/MM") + " " + funcion.Horario_14OR.ToString("HH:mm");
            lblButacas.Text = ArmarCodigos_14OR();

            lblEstadoCliente.Text = GestorIdioma_43BO.Instancia.ObtenerTexto_43BO("cobro_estado_consumidorfinal", "Consumidor final (sin descuento)");
            lblEstadoCliente.ForeColor = Color.Gainsboro;
            btnAsociar.Visible = false;

            Actualizar_14OR(null, null);
        }

        private string ArmarCodigos_14OR()
        {
            List<string> codigos = butacas
                .OrderBy(b => b.NumeroFila_14OR).ThenBy(b => b.NumeroAsiento_14OR)
                .Select(b => ((char)('A' + b.NumeroFila_14OR - 1)).ToString() + b.NumeroAsiento_14OR)
                .ToList();
            return string.Join(", ", codigos);
        }

        private void BtnBuscar_Click_14OR(object sender, EventArgs e)
        {
            var g = GestorIdioma_43BO.Instancia;
            string txt = txtDni.Text.Trim();

            if (txt == "")
            {
                clienteActual = null;
                socioConDescuento = false;
                modoAsociar = "";
                btnAsociar.Visible = false;
                OcultarPromos_14OR();
                lblEstadoCliente.Text = g.ObtenerTexto_43BO("cobro_estado_consumidorfinal", "Consumidor final (sin descuento)");
                lblEstadoCliente.ForeColor = Color.Gainsboro;
                Actualizar_14OR(null, null);
                return;
            }

            int dni;
            if (!int.TryParse(txt, out dni) || dni <= 0)
            {
                MessageBox.Show(g.ObtenerTexto_43BO("cobro_msg_dniinvalido", "Ingresa un DNI valido (solo numeros)."), "Atencion",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            dniBuscado = dni;

            try
            {
                Cliente_14OR c = bllCliente.BuscarPorDni_14OR(dni);

                if (c == null)
                {
                    clienteActual = null;
                    socioConDescuento = false;
                    modoAsociar = "alta";
                    OcultarPromos_14OR();
                    lblEstadoCliente.Text = g.ObtenerTexto_43BO("cobro_estado_alta", "No hay cliente con ese DNI. Podes darlo de alta como socio.");
                    lblEstadoCliente.ForeColor = Color.FromArgb(231, 168, 26);
                    btnAsociar.Visible = true;
                }
                else if (c.Suscriptor_14OR)
                {
                    clienteActual = c;
                    socioConDescuento = true;
                    modoAsociar = "";
                    btnAsociar.Visible = false;
                    CargarPromos_14OR();
                    lblEstadoCliente.Text = g.ObtenerTexto_43BO("cobro_estado_socio", "Socio") + ": " + c.Nombre_14OR + " " + c.Apellido_14OR + "  ✓";
                    lblEstadoCliente.ForeColor = Color.FromArgb(120, 200, 130);
                }
                else
                {
                    clienteActual = c;
                    socioConDescuento = false;
                    modoAsociar = "suscribir";
                    OcultarPromos_14OR();
                    lblEstadoCliente.Text = g.ObtenerTexto_43BO("cobro_estado_cliente", "Cliente") + ": " + c.Nombre_14OR + " " + c.Apellido_14OR +
                        " (" + g.ObtenerTexto_43BO("cobro_estado_nosocio", "no es socio") + ")";
                    lblEstadoCliente.ForeColor = Color.Gainsboro;
                    btnAsociar.Visible = true;
                }

                Actualizar_14OR(null, null);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void BtnAsociar_Click_14OR(object sender, EventArgs e)
        {
            var g = GestorIdioma_43BO.Instancia;
            try
            {
                if (modoAsociar == "suscribir" && clienteActual != null)
                {
                    if (MessageBox.Show(g.ObtenerTexto_43BO("cobro_msg_confirmarsocio", "Hacer socio a este cliente?"),
                        "Confirmar", MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes)
                        return;

                    bllCliente.Suscribir_14OR(clienteActual.IdCliente_14OR);
                    clienteActual.Suscriptor_14OR = true;

                    socioConDescuento = false;
                    modoAsociar = "";
                    btnAsociar.Visible = false;
                    OcultarPromos_14OR();
                    lblEstadoCliente.Text = g.ObtenerTexto_43BO("cobro_estado_socionuevo", "Socio nuevo") + ": " +
                        clienteActual.Nombre_14OR + " " + clienteActual.Apellido_14OR + ". " +
                        g.ObtenerTexto_43BO("cobro_estado_descproxima", "El descuento aplica desde la proxima compra.");
                    lblEstadoCliente.ForeColor = Color.FromArgb(120, 200, 130);
                    Actualizar_14OR(null, null);
                }
                else if (modoAsociar == "alta")
                {
                    using (AltaSocio_14OR dlg = new AltaSocio_14OR(dniBuscado))
                    {
                        if (dlg.ShowDialog(this) == DialogResult.OK)
                        {
                            Cliente_14OR nuevo = bllCliente.AltaSocioRapido_14OR(dlg.ClienteResultado);
                            clienteActual = nuevo;
                            socioConDescuento = false;
                            modoAsociar = "";
                            btnAsociar.Visible = false;
                            OcultarPromos_14OR();
                            lblEstadoCliente.Text = g.ObtenerTexto_43BO("cobro_estado_socionuevo", "Socio nuevo") + ": " +
                                nuevo.Nombre_14OR + " " + nuevo.Apellido_14OR + ". " +
                                g.ObtenerTexto_43BO("cobro_estado_descproxima", "El descuento aplica desde la proxima compra.");
                            lblEstadoCliente.ForeColor = Color.FromArgb(120, 200, 130);
                            Actualizar_14OR(null, null);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void CargarPromos_14OR()
        {
            var g = GestorIdioma_43BO.Instancia;
            promosDisponibles = bllPromo.ListarPVigentes_14OR();

            lstPromos.Items.Clear();
            lstPromos.Items.Add(g.ObtenerTexto_43BO("cobro_promo_sin", "Sin promocion"));
            foreach (Promocion_14OR p in promosDisponibles)
                lstPromos.Items.Add(DescripcionPromo_14OR(p));

            promoActual = null;
            montoDescuentoActual = 0;
            gbPromo.Visible = true;
            lstPromos.SelectedIndex = 0;
        }

        private void OcultarPromos_14OR()
        {
            gbPromo.Visible = false;
            lstPromos.Items.Clear();
            promosDisponibles.Clear();
            promoActual = null;
            montoDescuentoActual = 0;
        }

        private string DescripcionPromo_14OR(Promocion_14OR p)
        {
            if (p.Tipo_14OR == TipoPromocion_14OR.DosPorUno)
                return p.Nombre_14OR + " (2x1)";
            return p.Nombre_14OR + " (" + p.Valor_14OR.ToString("0") + "%)";
        }

        private void LstPromos_SelectedIndexChanged_14OR(object sender, EventArgs e)
        {
            int idx = lstPromos.SelectedIndex;
            if (idx <= 0)
            {
                promoActual = null;
                montoDescuentoActual = 0;
            }
            else
            {
                promoActual = promosDisponibles[idx - 1];
                montoDescuentoActual = bllPromo.CalcularDescuento_14OR(promoActual, butacas.Count, precioUnit, subtotal);
            }
            Actualizar_14OR(null, null);
        }

        private void Actualizar_14OR(object sender, EventArgs e)
        {
            totalActual = subtotal - montoDescuentoActual;

            lblSubtotal.Text = "$ " + subtotal.ToString("0");
            lblDescuento.Text = "- $ " + montoDescuentoActual.ToString("0");

            if (promoActual != null)
                lblPromo.Text = "Promo: " + promoActual.Nombre_14OR;
            else
                lblPromo.Text = "";

            lblTotal.Text = "Total: $ " + totalActual.ToString("0");

            panelEfectivo.Visible = rbEfectivo.Checked;
            panelTarjeta.Visible = rbTarjeta.Checked;

            if (rbEfectivo.Checked)
            {
                CalcularVuelto_14OR(); 
            }
        }
        private void CalcularVuelto_14OR()
        {
            var g = GestorIdioma_43BO.Instancia;

            // Si no encuentra la key, por lo menos en inglés tirará "Change" en lugar de "Vuelto"
            string etiquetaVuelto = g.ObtenerTexto_43BO("cobro_lbl_vuelto", "Change");

            double paga;
            if (double.TryParse(txtPaga.Text, out paga) && paga >= totalActual)
            {
                double vuelto = paga - totalActual;
                lblVuelto.Text = etiquetaVuelto + ": $ " + vuelto.ToString("0");
                lblVuelto.ForeColor = Color.FromArgb(120, 200, 130);
            }
            else
            {
                lblVuelto.Text = etiquetaVuelto + ": $ 0";
                lblVuelto.ForeColor = Color.FromArgb(200, 120, 120);
            }
        }

        private void BtnConfirmar_Click_14OR(object sender, EventArgs e)
        {
            var g = GestorIdioma_43BO.Instancia;
            string metodo = rbEfectivo.Checked ? "Efectivo" : "Tarjeta";

            if (rbEfectivo.Checked)
            {
                double paga;
                if (!double.TryParse(txtPaga.Text, out paga))
                {
                    MessageBox.Show("Ingresa con cuanto paga el cliente.", "Atencion",
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                if (paga < totalActual)
                {
                    MessageBox.Show("El monto con el que paga no alcanza para cubrir el total.", "Atencion",
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
            else
            {
                
                try
                {
                    bllVenta.ValidarTarjeta_14OR(txtNumero.Text, txtVenc.Text, txtCvv.Text);

                    MessageBox.Show(g.ObtenerTexto_43BO("cobro_msg_tarjetaok", "Pago con tarjeta aprobado."), "Tarjeta",
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception exCard)
                {
                    string mensajeTraducido = g.ObtenerTexto_43BO(exCard.Message, exCard.Message);
                    MessageBox.Show(mensajeTraducido, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }

            try
            {
                int idVenta = bllVenta.ConfirmarVenta_14OR(funcion.IdFuncion_14OR, butacas, metodo,
                    totalActual, clienteActual, promoActual, montoDescuentoActual);

                string carpeta = "";
                try
                {
                    double precioPorEntrada = butacas.Count > 0 ? totalActual / butacas.Count : totalActual;
                    carpeta = GeneradorTicket_14OR.GenerarEntradas_14OR(idVenta, funcion, butacas, precioPorEntrada, metodo);
                }
                catch (Exception exPdf)
                {
                    MessageBox.Show("La venta se registro, pero no pude generar el PDF de la entrada: " + exPdf.Message,
                        "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }

                MessageBox.Show("Venta N° " + idVenta + " registrada. Total: $ " + totalActual.ToString("0") + "." +
                    (montoDescuentoActual > 0 ? "\nDescuento aplicado: $ " + montoDescuentoActual.ToString("0") : "") +
                    (carpeta != "" ? "\nEntradas guardadas en:\n" + carpeta : ""),
                    "Venta confirmada", MessageBoxButtons.OK, MessageBoxIcon.Information);

                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void BtnCancelar_Click_14OR(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
    }
}
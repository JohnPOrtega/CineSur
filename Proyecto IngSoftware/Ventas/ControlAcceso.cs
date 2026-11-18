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

    // El estado 'Utilizada' (bordo) que deja este proceso es el que despues alimenta los reportes.
    public partial class ControlAcceso : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllAsientoFuncion_14OR bllAF = new BllAsientoFuncion_14OR();
        private BllFuncion_14OR bllFuncion = new BllFuncion_14OR();
        private BllSala_14OR bllSala = new BllSala_14OR();

        private List<Funcion_14OR> funciones = new List<Funcion_14OR>();
        private Funcion_14OR funcionActual = null;
        private List<int> pasillos = new List<int>();
        private List<CeldaMapa_14OR> celdas = new List<CeldaMapa_14OR>();

        private MapaButacas_14OR mapa;

        // para dibujar cada opcion del combo (etiqueta del dia + hora + peli + sala)
        private readonly Font fuenteEtiqueta = new Font("Segoe UI", 7.5F, FontStyle.Bold);
        private readonly Font fuenteHora = new Font("Segoe UI", 10F, FontStyle.Bold);
        private readonly Font fuenteTexto = new Font("Segoe UI", 10F);
        private readonly CultureInfo culturaEs = new CultureInfo("es-AR");

        public ControlAcceso()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);

            // el mapa se crea por codigo ) y se mete en el panel del disenador
            mapa = new MapaButacas_14OR();
            mapa.Dock = DockStyle.Fill;
            mapa.AutoScroll = true;
            mapa.BackColor = Color.FromArgb(25, 27, 34);
            mapa.ButacaClickeada += Mapa_ButacaClickeada_14OR;
            panelMapa.Controls.Add(mapa);

            CargarFunciones_14OR();
        }

        private void CargarFunciones_14OR()
        {
            try
            {
                // solo de hoy en adelante: a una funcion que ya paso no entra nadie
                funciones = bllFuncion.ListarVigentes_14OR();

                cmbFuncion.Items.Clear();
                foreach (Funcion_14OR f in funciones)
                {
                    // el texto queda por si acaso; lo que se ve lo dibuja cmbFuncion_DrawItem
                    cmbFuncion.Items.Add(f.Pelicula.Titulo_14OR + "  -  Sala " + f.Sala.Numero_14OR +
                        "  -  " + f.Fecha_14OR.ToString("dd/MM") + " " + f.Horario_14OR.ToString("HH:mm"));
                }

                if (funciones.Count == 0)
                {
                    lblEstadoIngreso.Text = "No hay funciones de hoy en adelante.";
                    return;
                }

                lblEstadoIngreso.Text = "Elegi una funcion para ver la sala.";

                // dejo elegida la proxima funcion de hoy (la que esta por empezar o la ultima que arranco)
                int proxima = funciones.FindIndex(f => f.Fecha_14OR.Date == DateTime.Today &&
                                                       f.Horario_14OR.TimeOfDay >= DateTime.Now.TimeOfDay.Add(TimeSpan.FromHours(-3)));
                if (proxima >= 0)
                    cmbFuncion.SelectedIndex = proxima;
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar las funciones: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void cmbFuncion_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i = cmbFuncion.SelectedIndex;
            if (i < 0 || i >= funciones.Count) return;

            funcionActual = funciones[i];
            lblEstadoIngreso.Text = "Toca una butaca vendida (rojo oscuro) para registrar el ingreso.";
            lblEstadoIngreso.ForeColor = Color.Gainsboro;
            CargarPasillos_14OR();
            RecargarMapa_14OR();
        }

        // los pasillos sonnon para la sals  para dibujar el mapa igual
        private void CargarPasillos_14OR()
        {
            pasillos = new List<int>();
            try
            {
                Sala_14OR sala = bllSala.Listar_14OR().FirstOrDefault(s => s.IdSala_14OR == funcionActual.Sala.IdSala_14OR);
                if (sala != null && !string.IsNullOrWhiteSpace(sala.Pasillos_14OR))
                {
                    foreach (string parte in sala.Pasillos_14OR.Split(','))
                    {
                        int n;
                        if (int.TryParse(parte.Trim(), out n) && n > 0)
                            pasillos.Add(n);
                    }
                }
            }
            catch { }
        }

        private void RecargarMapa_14OR()
        {
            if (funcionActual == null) return;

            try
            {
                List<AsientoFuncion_14OR> asientos = bllAF.ObtenerMapa_14OR(funcionActual.IdFuncion_14OR, funcionActual.Sala.IdSala_14OR);

                celdas = asientos.Select(af => new CeldaMapa_14OR
                {
                    Fila = af.Butaca.NumeroFila_14OR,
                    Asiento = af.Butaca.NumeroAsiento_14OR,
                    Estado = af.Estado_14OR,
                    Referencia = af
                }).ToList();

                // clickeable=false pero clickTodas=true: puedo tocar las butacas vendidas (rojas) para el ingreso
                mapa.Cargar_14OR(celdas, false, pasillos, false, true);

                ActualizarContadores_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar el mapa: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void ActualizarContadores_14OR()
        {
            int vendidas = celdas.Count(c => c.Estado == "Ocupada");
            int ingresadas = celdas.Count(c => c.Estado == "Utilizada");
            int reservadas = celdas.Count(c => c.Estado == "Reservada");
            int disponibles = celdas.Count(c => c.Estado == "Libre" || c.Estado == "Accesible");

            // las reservadas (rojo claro) son ventas empezadas que todavia no se cobraron:
            // las muestro aparte pa que no se confundan con las vendidas
            lblContadores.Text = "Vendidas sin ingresar: " + vendidas +
                                 "   |   Ingresadas: " + ingresadas +
                                 (reservadas > 0 ? "   |   Reservadas sin pagar: " + reservadas : "") +
                                 "   |   Disponibles: " + disponibles;
        }

        // 
        private void Mapa_ButacaClickeada_14OR(object sender, CeldaMapa_14OR celda)
        {
            if (funcionActual == null) return;

            AsientoFuncion_14OR af = celda.Referencia as AsientoFuncion_14OR;
            if (af == null) return;

            string codigo = Codigo_14OR(celda.Fila, celda.Asiento);

            ResultadoIngreso_14OR res = bllAF.RegistrarIngreso_14OR(funcionActual.IdFuncion_14OR, af.Butaca.IdButaca_14OR);

            switch (res)
            {
                case ResultadoIngreso_14OR.Ok:
                    lblEstadoIngreso.Text = "Ingreso registrado: butaca " + codigo + ". Adelante.";
                    lblEstadoIngreso.ForeColor = Color.FromArgb(120, 200, 130); // verde
                    RecargarMapa_14OR(); // la butaca pasa a bordo (Utilizada)
                    break;

                case ResultadoIngreso_14OR.YaUtilizada:
                    lblEstadoIngreso.Text = "RECHAZADO: la entrada de la butaca " + codigo + " ya fue utilizada.";
                    lblEstadoIngreso.ForeColor = Color.FromArgb(220, 100, 100); // rojo
                    break;

                case ResultadoIngreso_14OR.ReservadaSinPagar:
                    lblEstadoIngreso.Text = "RECHAZADO: la butaca " + codigo + " esta reservada pero la venta no se cobro (no hay entrada que validar).";
                    lblEstadoIngreso.ForeColor = Color.FromArgb(231, 168, 26); // ambar
                    break;

                case ResultadoIngreso_14OR.NoVendida:
                    lblEstadoIngreso.Text = "RECHAZADO: la butaca " + codigo + " no fue vendida (no hay entrada que validar).";
                    lblEstadoIngreso.ForeColor = Color.FromArgb(231, 168, 26); // ambar
                    break;

                default: // NoExiste
                    lblEstadoIngreso.Text = "RECHAZADO: la butaca " + codigo + " no corresponde a esta funcion.";
                    lblEstadoIngreso.ForeColor = Color.FromArgb(231, 168, 26);
                    break;
            }
        }

        // dibuja cada funcion del combo: [HOY 13:28] Godzilla Minus One ............ Sala 2
        private void cmbFuncion_DrawItem(object sender, DrawItemEventArgs e)
        {
            if (e.Index < 0 || e.Index >= funciones.Count) return;
            Funcion_14OR f = funciones[e.Index];

            bool enLaCaja = (e.State & DrawItemState.ComboBoxEdit) == DrawItemState.ComboBoxEdit;
            bool marcada = (e.State & DrawItemState.Selected) == DrawItemState.Selected && !enLaCaja;
            Color fondo = marcada ? Color.FromArgb(58, 114, 176) : Color.FromArgb(34, 37, 48);
            using (SolidBrush b = new SolidBrush(fondo))
                e.Graphics.FillRectangle(b, e.Bounds);

            // etiqueta del dia: HOY en verde, MANANA en ambar, el resto con el dia de la semana
            string dia;
            Color colorDia;
            if (f.Fecha_14OR.Date == DateTime.Today) { dia = "HOY"; colorDia = Color.FromArgb(70, 160, 100); }
            else if (f.Fecha_14OR.Date == DateTime.Today.AddDays(1)) { dia = "MAÑANA"; colorDia = Color.FromArgb(200, 140, 20); }
            else { dia = f.Fecha_14OR.ToString("ddd dd/MM", culturaEs).ToUpper(); colorDia = Color.FromArgb(70, 76, 96); }

            Rectangle rDia = new Rectangle(e.Bounds.X + 6, e.Bounds.Y + 4, 78, e.Bounds.Height - 8);
            using (SolidBrush b = new SolidBrush(colorDia))
                e.Graphics.FillRectangle(b, rDia);
            TextRenderer.DrawText(e.Graphics, dia, fuenteEtiqueta, rDia, Color.White,
                TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter);

            Rectangle rHora = new Rectangle(rDia.Right + 8, e.Bounds.Y, 48, e.Bounds.Height);
            TextRenderer.DrawText(e.Graphics, f.Horario_14OR.ToString("HH:mm"), fuenteHora, rHora, Color.White,
                TextFormatFlags.Left | TextFormatFlags.VerticalCenter);

            Rectangle rSala = new Rectangle(e.Bounds.Right - 70, e.Bounds.Y, 62, e.Bounds.Height);
            TextRenderer.DrawText(e.Graphics, "Sala " + f.Sala.Numero_14OR, fuenteTexto, rSala,
                marcada ? Color.White : Color.FromArgb(150, 160, 180), TextFormatFlags.Right | TextFormatFlags.VerticalCenter);

            Rectangle rPeli = new Rectangle(rHora.Right + 4, e.Bounds.Y, rSala.Left - rHora.Right - 8, e.Bounds.Height);
            TextRenderer.DrawText(e.Graphics, f.Pelicula.Titulo_14OR, fuenteTexto, rPeli, Color.White,
                TextFormatFlags.Left | TextFormatFlags.VerticalCenter | TextFormatFlags.EndEllipsis);
        }

        private string Codigo_14OR(int fila, int asiento)
        {
            char letra = (char)('A' + fila - 1);
            return letra.ToString() + asiento;
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            RecargarMapa_14OR();
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        // al cambiar idioma se llama a este metodo para actualizar los textos d ela vetnana
        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
}
}

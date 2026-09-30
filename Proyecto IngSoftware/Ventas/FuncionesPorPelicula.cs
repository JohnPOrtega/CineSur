using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
   
    public partial class FuncionesPorPelicula : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllFuncion_14OR bllFuncion = new BllFuncion_14OR();
        private BllAsientoFuncion_14OR bllAF = new BllAsientoFuncion_14OR();

        private Pelicula_14OR peli;

        public FuncionesPorPelicula(Pelicula_14OR pelicula)
        {
            this.peli = pelicula;
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);

            // el titulo de la ventana y el label grande salen del nombre de la peli (dato en runtime)
            this.Text = "Funciones - " + peli.Titulo_14OR;
            lblTitulo.Text = peli.Titulo_14OR;

            CargarFunciones_14OR();
        }

        private void CargarFunciones_14OR()
        {
            flpFunciones.Controls.Clear();

            try
            {
                List<Funcion_14OR> funciones = bllFuncion.ListarPorPelicula_14OR(peli.IdPelicula_14OR);

                if (funciones.Count == 0)
                {
                    Label vacio = new Label();
                    vacio.Text = "Esta peli no tiene funciones futuras cargadas.";
                    vacio.ForeColor = Color.Gainsboro;
                    vacio.Font = new Font("Segoe UI", 10F);
                    vacio.AutoSize = true;
                    flpFunciones.Controls.Add(vacio);
                    return;
                }

                foreach (Funcion_14OR f in funciones)
                    flpFunciones.Controls.Add(ArmarTarjeta_14OR(f));
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar las funciones: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // arma la tarjeta de una funcion. va por codigo: la cantidad depende de cuantas funciones haya
        private Panel ArmarTarjeta_14OR(Funcion_14OR f)
        {
            int libres = 0;
            try { libres = bllAF.LibresParaMostrar_14OR(f.IdFuncion_14OR, f.Sala.Capacidad_14OR); }
            catch { }

            double precio = bllFuncion.CalcularPrecioFinal_14OR(f);

            Panel card = new Panel();
            card.Size = new Size(flpFunciones.ClientSize.Width - 25, 74);
            card.Margin = new Padding(3);
            card.BackColor = Color.FromArgb(36, 39, 48);
            card.Cursor = Cursors.Hand;

            // fecha y hora bien grandes a la izquierda
            Label lblFechaHora = new Label();
            lblFechaHora.Text = f.Fecha_14OR.ToString("ddd dd/MM") + "   " + f.Horario_14OR.ToString("HH:mm");
            lblFechaHora.ForeColor = Color.White;
            lblFechaHora.Font = new Font("Segoe UI", 12F, FontStyle.Bold);
            lblFechaHora.Location = new Point(12, 12);
            lblFechaHora.AutoSize = true;
            card.Controls.Add(lblFechaHora);

            Label lblInfo = new Label();
            lblInfo.Text = "Sala " + f.Sala.Numero_14OR + "  -  " + FormatoTexto_14OR(f.Formato_14OR) + "  -  " + f.Idioma_14OR;
            lblInfo.ForeColor = Color.Gainsboro;
            lblInfo.Font = new Font("Segoe UI", 9F);
            lblInfo.Location = new Point(14, 44);
            lblInfo.AutoSize = true;
            card.Controls.Add(lblInfo);

            // precio a la derecha
            Label lblPrecio = new Label();
            lblPrecio.Text = "$ " + precio.ToString("0");
            lblPrecio.ForeColor = Color.FromArgb(120, 170, 255);
            lblPrecio.Font = new Font("Segoe UI", 13F, FontStyle.Bold);
            lblPrecio.TextAlign = ContentAlignment.MiddleRight;
            lblPrecio.Location = new Point(card.Width - 180, 12);
            lblPrecio.Size = new Size(165, 26);
            lblPrecio.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            card.Controls.Add(lblPrecio);

            Label lblLibres = new Label();
            lblLibres.Text = libres + " butacas libres";
            lblLibres.ForeColor = libres > 0 ? Color.FromArgb(120, 200, 130) : Color.FromArgb(200, 120, 120);
            lblLibres.Font = new Font("Segoe UI", 9F);
            lblLibres.TextAlign = ContentAlignment.MiddleRight;
            lblLibres.Location = new Point(card.Width - 180, 44);
            lblLibres.Size = new Size(165, 18);
            lblLibres.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            card.Controls.Add(lblLibres);

            EventHandler abrir = (s, e) => AbrirMapa_14OR(f);
            card.Click += abrir;
            foreach (Control hijo in card.Controls)
                hijo.Click += abrir;

            return card;
        }

        private void AbrirMapa_14OR(Funcion_14OR f)
        {
            using (SeleccionButacas ventana = new SeleccionButacas(f))
            {
                ventana.ShowDialog();
            }
            // al volver del mapa refresco los "libres" por si se reservaron butacas
            CargarFunciones_14OR();
        }

        private string FormatoTexto_14OR(FormatoFuncion_14OR formato)
        {
            if (formato == FormatoFuncion_14OR.TresD) return "3D";
            if (formato == FormatoFuncion_14OR.CuatroDX) return "4DX";
            return "2D";
        }
    
        // traduccion automatica: al cambiar idioma el gestor llama aca y se traducen
        // todos los controles estaticos que tengan clave en el JSON (patron observer).
        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
}
}

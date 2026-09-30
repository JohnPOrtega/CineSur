using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
   
    // muestra las pelis que tienen funciones futuras como tarjetas con afiche.
    // al hacer click en una peli se abre la pantalla de horarios (funciones).
    // el titulo y el panel 
    public partial class Cartelera : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllPelicula_14OR bllPeli = new BllPelicula_14OR();
        private BllFuncion_14OR bllFuncion = new BllFuncion_14OR();

        public Cartelera()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            CargarCartelera_14OR();
        }

        private void CargarCartelera_14OR()
        {
            flpPelis.Controls.Clear();

            try
            {
                List<Pelicula_14OR> pelis = bllPeli.ListarEnCartelera_14OR();

                if (pelis.Count == 0)
                {
                    Label vacio = new Label();
                    vacio.Text = "No hay peliculas en cartelera. Cargá funciones futuras desde Master > Funciones.";
                    vacio.ForeColor = Color.Gainsboro;
                    vacio.Font = new Font("Segoe UI", 11F);
                    vacio.AutoSize = true;
                    flpPelis.Controls.Add(vacio);
                    return;
                }

                foreach (Pelicula_14OR p in pelis)
                    flpPelis.Controls.Add(ArmarTarjeta_14OR(p));
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar la cartelera: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        //tube que agregar esto si os i apora que quede bonito al vista  amenos que haya un UC solo para las tarjetas que lleaba asm tiempo 
        private Panel ArmarTarjeta_14OR(Pelicula_14OR p)
        {
            Panel card = new Panel();
            card.Size = new Size(190, 320);
            card.Margin = new Padding(10);
            card.BackColor = Color.FromArgb(36, 39, 48);
            card.Cursor = Cursors.Hand;

            PictureBox pic = new PictureBox();
            pic.Size = new Size(190, 230);
            pic.Location = new Point(0, 0);
            pic.SizeMode = PictureBoxSizeMode.Zoom;
            pic.BackColor = Color.FromArgb(50, 54, 66);
            CargarPoster_14OR(pic, p.Poster_14OR);
            card.Controls.Add(pic);

            Label lblTit = new Label();
            lblTit.Text = p.Titulo_14OR;
            lblTit.ForeColor = Color.White;
            lblTit.Font = new Font("Segoe UI", 10F, FontStyle.Bold);
            lblTit.Location = new Point(8, 236);
            lblTit.Size = new Size(174, 38);
            card.Controls.Add(lblTit);

            Label lblSub = new Label();
            lblSub.Text = p.Genero_14OR + " - " + p.Duracion_14OR + " min";
            lblSub.ForeColor = Color.Gainsboro;
            lblSub.Font = new Font("Segoe UI", 8F);
            lblSub.Location = new Point(8, 276);
            lblSub.Size = new Size(174, 16);
            card.Controls.Add(lblSub);

            // cuantas funciones futuras tiene (para que el vendedor sepa que hay algo para vender)
            int cantFunciones = 0;
            try { cantFunciones = bllFuncion.ListarPorPelicula_14OR(p.IdPelicula_14OR).Count; }
            catch { }

            Label lblFun = new Label();
            lblFun.Text = cantFunciones + (cantFunciones == 1 ? " funcion" : " funciones");
            lblFun.ForeColor = Color.FromArgb(120, 170, 255);
            lblFun.Font = new Font("Segoe UI", 8.5F, FontStyle.Bold);
            lblFun.Location = new Point(8, 294);
            lblFun.Size = new Size(174, 16);
            card.Controls.Add(lblFun);

            // engancho el mismo click a la tarjeta y a todos sus hijos (en winforms el click no burbujea)
            EventHandler abrir = (s, e) => AbrirFunciones_14OR(p);
            card.Click += abrir;
            foreach (Control hijo in card.Controls)
                hijo.Click += abrir;

            return card;
        }

        // busco el afiche en la carpeta Posters al lado del exe. si no esta, dejo el color de fondo.
        private void CargarPoster_14OR(PictureBox pic, string archivo)
        {
            if (string.IsNullOrEmpty(archivo)) return;

            try
            {
                string ruta = Path.Combine(Application.StartupPath, "Posters", archivo);
                if (File.Exists(ruta))
                {
                    // lo cargo en memoria asi no deja el archivo tomado
                    using (var fs = new FileStream(ruta, FileMode.Open, FileAccess.Read))
                    {
                        pic.Image = Image.FromStream(fs);
                    }
                }
            }
            catch
            {
                // si el afiche esta roto no pasa nada, queda el fondo
            }
        }

        private void AbrirFunciones_14OR(Pelicula_14OR p)
        {
            using (FuncionesPorPelicula ventana = new FuncionesPorPelicula(p))
            {
                ventana.ShowDialog();
            }
            // al volver refresco por si algo cambio (nada critico, pero por las dudas)
            CargarCartelera_14OR();
        }
    
        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
}
}

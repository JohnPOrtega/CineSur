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
    public partial class Peliculas : Form
    {
        // la gui solo habla con la bll, nunca directo con la dal
         private BllPelicula_14OR bll = new BllPelicula_14OR();

        // guardo el id de la fila que esta elegida en la grilla
        private int idSeleccionado_14OR = 0;

        // modo en el que esta el form: "" (mirando), "nuevo" o "modif"
        private string modo_14OR = "";

        // me guardo la lista completa para poder sacar el poster de la peli elegida
        private List<Pelicula_14OR> peliculasActuales_14OR = new List<Pelicula_14OR>();

        // nombre del archivo del afiche que esta cargado en pantalla (ej "duna2.jpg")
        private string posterArchivo_14OR = "";

        public Peliculas()
        {
            InitializeComponent();
            EstiloGrilla_14OR();
            CargarGrilla_14OR();
            // arranco con los campos bloqueados, como en el resto de los abm
            ModoInicial_14OR();
        }

        // ---- carga y estilo de la grilla ----

        private void CargarGrilla_14OR()
        {
            try
            {
                // me guardo la lista completa (con el poster) y proyecto lo que va a la grilla
                peliculasActuales_14OR = bll.Listar_14OR();
                var lista = peliculasActuales_14OR.Select(p => new
                {
                    p.IdPelicula_14OR,
                    p.Titulo_14OR,
                    p.Genero_14OR,
                    p.Duracion_14OR
                }).ToList();

                dgvPeliculas.DataSource = lista;

                // pongo nombres lindos en los encabezados
                if (dgvPeliculas.Columns.Count > 0)
                {
                    dgvPeliculas.Columns["IdPelicula_14OR"].HeaderText = "ID";
                    dgvPeliculas.Columns["Titulo_14OR"].HeaderText = "Titulo";
                    dgvPeliculas.Columns["Genero_14OR"].HeaderText = "Genero";
                    dgvPeliculas.Columns["Duracion_14OR"].HeaderText = "Duracion";
                    dgvPeliculas.Columns["IdPelicula_14OR"].FillWeight = 40;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar las peliculas: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // aca dejo la grilla con la pinta oscura, la parte visual la hago por codigo
        private void EstiloGrilla_14OR()
        {
            dgvPeliculas.EnableHeadersVisualStyles = false;
            dgvPeliculas.BackgroundColor = Color.FromArgb(36, 36, 36);
            dgvPeliculas.BorderStyle = BorderStyle.None;
            dgvPeliculas.GridColor = Color.FromArgb(61, 61, 61);
            dgvPeliculas.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvPeliculas.MultiSelect = false;
            dgvPeliculas.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvPeliculas.RowTemplate.Height = 28;
            dgvPeliculas.ColumnHeadersHeight = 30;

            dgvPeliculas.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(46, 46, 46);
            dgvPeliculas.ColumnHeadersDefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvPeliculas.ColumnHeadersDefaultCellStyle.SelectionBackColor = Color.FromArgb(46, 46, 46);
            dgvPeliculas.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI", 9.5F, FontStyle.Bold);

            dgvPeliculas.DefaultCellStyle.BackColor = Color.FromArgb(36, 36, 36);
            dgvPeliculas.DefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvPeliculas.DefaultCellStyle.SelectionBackColor = Color.FromArgb(18, 58, 94);
            dgvPeliculas.DefaultCellStyle.SelectionForeColor = Color.White;
            dgvPeliculas.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(40, 40, 40);
        }

        // ---- manejo de los modos del form ----

        private void ModoInicial_14OR()
        {
            modo_14OR = "";
            idSeleccionado_14OR = 0;
            LimpiarCampos_14OR();
            BloquearCampos_14OR(true);
            btnNuevo.Enabled = true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            btnGuardar.Enabled = false;
            lblEstado.Text = "Selecciona una fila de la grilla, o toca NUEVO para cargar una pelicula.";
        }

        private void LimpiarCampos_14OR()
        {
            txtTitulo.Clear();
            txtGenero.Clear();
            numDuracion.Value = 90;
            // limpio tambien el afiche
            posterArchivo_14OR = "";
            pbPoster.Image = null;
        }

        private void BloquearCampos_14OR(bool bloquear)
        {
            txtTitulo.Enabled = !bloquear;
            txtGenero.Enabled = !bloquear;
            numDuracion.Enabled = !bloquear;
            btnSeleccionarImagen.Enabled = !bloquear;
        }

        // ---- eventos ----

        // cuando toco una fila cargo los datos en los campos pero los dejo bloqueados
        private void dgvPeliculas_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvPeliculas.CurrentRow == null) return;

            idSeleccionado_14OR = Convert.ToInt32(dgvPeliculas.CurrentRow.Cells["IdPelicula_14OR"].Value);

            // busco la peli completa en la lista para traer tambien el poster
            Pelicula_14OR p = peliculasActuales_14OR.FirstOrDefault(x => x.IdPelicula_14OR == idSeleccionado_14OR);
            if (p == null) return;

            txtTitulo.Text = p.Titulo_14OR;
            txtGenero.Text = p.Genero_14OR;
            numDuracion.Value = p.Duracion_14OR;
            posterArchivo_14OR = p.Poster_14OR;
            MostrarPoster_14OR(posterArchivo_14OR);

            modo_14OR = "";
            BloquearCampos_14OR(true);
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnGuardar.Enabled = false;
            btnNuevo.Enabled = true;
            lblEstado.Text = "Pelicula " + idSeleccionado_14OR + " seleccionada. Podes MODIFICAR o ELIMINAR.";
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            // limpio y desbloqueo para cargar una nueva
            modo_14OR = "nuevo";
            idSeleccionado_14OR = 0;
            LimpiarCampos_14OR();
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo ALTA: carga los datos y toca GUARDAR.";
            txtTitulo.Focus();
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            // desbloqueo para editar la fila que ya estaba elegida
            modo_14OR = "modif";
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnNuevo.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo MODIFICACION de la pelicula " + idSeleccionado_14OR + ". Cambia lo que quieras y toca GUARDAR.";
            txtTitulo.Focus();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // armo el objeto con lo que hay en los campos
                Pelicula_14OR p = new Pelicula_14OR();
                p.Titulo_14OR = txtTitulo.Text.Trim();
                p.Genero_14OR = txtGenero.Text.Trim();
                p.Duracion_14OR = (int)numDuracion.Value;
                p.Poster_14OR = posterArchivo_14OR;

                if (modo_14OR == "nuevo")
                {
                    bll.Alta_14OR(p);
                    MessageBox.Show("Pelicula dada de alta.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (modo_14OR == "modif")
                {
                    p.IdPelicula_14OR = idSeleccionado_14OR;
                    bll.Modificar_14OR(p);
                    MessageBox.Show("Pelicula modificada.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    // por las dudas, si toco guardar sin estar en alta ni modif no hago nada
                    return;
                }

                CargarGrilla_14OR();
                ModoInicial_14OR();
            }
            catch (Exception ex)
            {
                // los mensajes de validacion de la bll caen aca
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            // pido confirmacion antes de borrar, no quiero borrar de una sin querer
            DialogResult r = MessageBox.Show("Seguro que queres eliminar la pelicula " + idSeleccionado_14OR + "?",
                "Confirmar", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (r != DialogResult.Yes) return;

            try
            {
                bll.Baja_14OR(idSeleccionado_14OR);
                CargarGrilla_14OR();
                ModoInicial_14OR();
            }
            catch (Exception ex)
            {
                // si la peli tiene funciones cargadas la fk no la deja borrar, aviso lindo
                MessageBox.Show("No se pudo eliminar. Puede que la pelicula tenga funciones cargadas.\n\nDetalle: " + ex.Message,
                    "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // ---- poster / afiche ----

        // abro el explorador, copio la imagen elegida a la carpeta Posters y me guardo el nombre
        private void btnSeleccionarImagen_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() != DialogResult.OK) return;

            try
            {
                string origen = openFileDialog1.FileName;
                string nombre = Path.GetFileName(origen);
                string destino = Path.Combine(CarpetaPosters_14OR(), nombre);

                // copio la imagen a la carpeta de la app (si ya hay una con ese nombre la piso)
                if (!string.Equals(origen, destino, StringComparison.OrdinalIgnoreCase))
                    File.Copy(origen, destino, true);

                posterArchivo_14OR = nombre;
                MostrarPoster_14OR(nombre);
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude copiar la imagen: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // muestra el afiche en el picturebox leyendolo de la carpeta Posters
        private void MostrarPoster_14OR(string archivo)
        {
            pbPoster.Image = null;
            if (string.IsNullOrEmpty(archivo)) return;

            string ruta = Path.Combine(CarpetaPosters_14OR(), archivo);
            if (!File.Exists(ruta)) return;

            // leo los bytes y cargo desde memoria asi el archivo no queda bloqueado
            byte[] bytes = File.ReadAllBytes(ruta);
            pbPoster.Image = Image.FromStream(new MemoryStream(bytes));
        }

        // devuelve la carpeta Posters (al lado del exe), la crea si no existe
        private string CarpetaPosters_14OR()
        {
            string carpeta = Path.Combine(Application.StartupPath, "Posters");
            if (!Directory.Exists(carpeta)) Directory.CreateDirectory(carpeta);
            return carpeta;
        }

        // handler del boton Cancelar: agregas el boton en el disenador y le enganchas
        // este metodo en su evento Click. descarta lo que estabas cargando y vuelve al inicio.
        private void btnCancelar_Click(object sender, EventArgs e)
        {
            ModoInicial_14OR();
        }
    }
}

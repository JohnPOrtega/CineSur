using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // ABM de los productos del Candy Bar (pochoclos, gaseosas, combos).
    // Mismo patorn que el maestro de Peliculas: grilla + campos + Nuevo/Modificar/Eliminar/Guardar.
    public partial class Productos : Form
    {
        // la gui solo habla con la bll
        private BllProducto_14OR bll = new BllProducto_14OR();

        private int idSeleccionado_14OR = 0;
        private string modo_14OR = "";

        // me guardo la lista completa para poder sacar la imagen del producto elegido
        private List<Producto_14OR> productosActuales_14OR = new List<Producto_14OR>();

        // nombre del archivo de imagen cargado en pantalla (ej "combo.png")
        private string imagenArchivo_14OR = "";

        // carpeta donde se guardan las imagenes de productos (al lado del exe) la misma que lee la venta del candy
        private const string CARPETA_IMAGENES_14OR = "ProductosCandy";

        public Productos()
        {
            InitializeComponent();
            EstiloGrilla_14OR();
            CargarGrilla_14OR();
            ModoInicial_14OR();
        }

        // ---- carga y estilo de la grilla ----

        private void CargarGrilla_14OR()
        {
            try
            {
                // me guardo la lista completa (con la imagen) y proyecto lo que va a la grilla
                productosActuales_14OR = bll.ListarProducto_14OR();
                var lista = productosActuales_14OR.Select(p => new
                {
                    p.IdProducto_14OR,
                    p.Nombre_14OR,
                    p.PrecioVenta_14OR,
                    p.Stock_14OR,
                    p.StockCritico_14OR
                }).ToList();

                dgvProductos.DataSource = lista;

                if (dgvProductos.Columns.Count > 0)
                {
                    dgvProductos.Columns["IdProducto_14OR"].HeaderText = "ID";
                    dgvProductos.Columns["Nombre_14OR"].HeaderText = "Producto";
                    dgvProductos.Columns["PrecioVenta_14OR"].HeaderText = "Precio";
                    dgvProductos.Columns["Stock_14OR"].HeaderText = "Stock";
                    dgvProductos.Columns["StockCritico_14OR"].HeaderText = "Stock critico";
                    dgvProductos.Columns["IdProducto_14OR"].FillWeight = 30;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar los productos: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void EstiloGrilla_14OR()
        {
            dgvProductos.EnableHeadersVisualStyles = false;
            dgvProductos.BackgroundColor = Color.FromArgb(36, 36, 36);
            dgvProductos.BorderStyle = BorderStyle.None;
            dgvProductos.GridColor = Color.FromArgb(61, 61, 61);
            dgvProductos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvProductos.MultiSelect = false;
            dgvProductos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvProductos.RowTemplate.Height = 28;
            dgvProductos.ColumnHeadersHeight = 30;

            dgvProductos.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(46, 46, 46);
            dgvProductos.ColumnHeadersDefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvProductos.ColumnHeadersDefaultCellStyle.SelectionBackColor = Color.FromArgb(46, 46, 46);
            dgvProductos.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI", 9.5F, FontStyle.Bold);

            dgvProductos.DefaultCellStyle.BackColor = Color.FromArgb(36, 36, 36);
            dgvProductos.DefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvProductos.DefaultCellStyle.SelectionBackColor = Color.FromArgb(18, 58, 94);
            dgvProductos.DefaultCellStyle.SelectionForeColor = Color.White;
            dgvProductos.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(40, 40, 40);
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
            lblEstado.Text = "Selecciona una fila de la grilla, o toca NUEVO para cargar un producto.";
        }

        private void LimpiarCampos_14OR()
        {
            txtNombre.Clear();
            numPrecio.Value = 0;
            numCosto.Value = 0;
            numStock.Value = 0;
            numCritico.Value = 0;
            imagenArchivo_14OR = "";
            pbImagen.Image = null;
        }

        private void BloquearCampos_14OR(bool bloquear)
        {
            txtNombre.Enabled = !bloquear;
            numPrecio.Enabled = !bloquear;
            numCosto.Enabled = !bloquear;
            numStock.Enabled = !bloquear;
            numCritico.Enabled = !bloquear;
            btnImagen.Enabled = !bloquear;
        }

        // ---- eventos ----

        private void dgvProductos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvProductos.CurrentRow == null) return;

            idSeleccionado_14OR = Convert.ToInt32(dgvProductos.CurrentRow.Cells["IdProducto_14OR"].Value);

            txtNombre.Text = dgvProductos.CurrentRow.Cells["Nombre_14OR"].Value.ToString();
            numPrecio.Value = (decimal)Convert.ToDouble(dgvProductos.CurrentRow.Cells["PrecioVenta_14OR"].Value);
            numStock.Value = Convert.ToInt32(dgvProductos.CurrentRow.Cells["Stock_14OR"].Value);
            numCritico.Value = Convert.ToInt32(dgvProductos.CurrentRow.Cells["StockCritico_14OR"].Value);

            // traigo la imagen y el costo del producto desde la lista completa
            Producto_14OR prod = productosActuales_14OR.FirstOrDefault(x => x.IdProducto_14OR == idSeleccionado_14OR);
            imagenArchivo_14OR = prod != null ? prod.Imagen_14OR : "";
            numCosto.Value = prod != null ? (decimal)prod.PrecioCosto_14OR : 0;
            MostrarImagen_14OR(imagenArchivo_14OR);

            modo_14OR = "";
            BloquearCampos_14OR(true);
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnGuardar.Enabled = false;
            btnNuevo.Enabled = true;
            lblEstado.Text = "Producto " + idSeleccionado_14OR + " seleccionado. Podes MODIFICAR o ELIMINAR.";
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            modo_14OR = "nuevo";
            idSeleccionado_14OR = 0;
            LimpiarCampos_14OR();
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo ALTA: carga los datos y toca GUARDAR.";
            txtNombre.Focus();
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            modo_14OR = "modif";
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnNuevo.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo MODIFICACION del producto " + idSeleccionado_14OR + ". Cambia lo que quieras y toca GUARDAR.";
            txtNombre.Focus();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Producto_14OR p = new Producto_14OR();
                p.Nombre_14OR = txtNombre.Text.Trim();
                p.PrecioVenta_14OR = (double)numPrecio.Value;
                p.PrecioCosto_14OR = (double)numCosto.Value;
                p.Stock_14OR = (int)numStock.Value;
                p.StockCritico_14OR = (int)numCritico.Value;
                p.Imagen_14OR = imagenArchivo_14OR;

                if (modo_14OR == "nuevo")
                {
                    bll.AltaProducto_14OR(p);
                    MessageBox.Show("Producto dado de alta.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (modo_14OR == "modif")
                {
                    p.IdProducto_14OR = idSeleccionado_14OR;
                    bll.ModificarProducto_14OR(p);
                    MessageBox.Show("Producto modificado.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
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

            DialogResult r = MessageBox.Show("Seguro que queres eliminar el producto " + idSeleccionado_14OR + "?",
                "Confirmar", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (r != DialogResult.Yes) return;

            try
            {
                // es baja olgica: el producto queda inactivo pero no se borra de la base
                bll.BajaProducto_14OR(idSeleccionado_14OR);
                CargarGrilla_14OR();
                ModoInicial_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            ModoInicial_14OR();
        }

        // ---- imagen del producto ----

        // abro el explorador, copio la imagen elegida a la carpeta ProductosCandy y me guardo el nombre
        private void btnImagen_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() != DialogResult.OK) return;

            try
            {
                string origen = openFileDialog1.FileName;
                string nombre = System.IO.Path.GetFileName(origen);
                string destino = System.IO.Path.Combine(CarpetaImagenes_14OR(), nombre);

                if (!string.Equals(origen, destino, StringComparison.OrdinalIgnoreCase))
                    System.IO.File.Copy(origen, destino, true);

                imagenArchivo_14OR = nombre;
                MostrarImagen_14OR(nombre);
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude copiar la imagen: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // muestra la imagen en el picturebox leyendola de la carpeta ProductosCandy
        private void MostrarImagen_14OR(string archivo)
        {
            pbImagen.Image = null;
            if (string.IsNullOrEmpty(archivo)) return;

            string ruta = System.IO.Path.Combine(CarpetaImagenes_14OR(), archivo);
            if (!System.IO.File.Exists(ruta)) return;

            // leo los bytes y cargo desde memoria asi el archivo no queda bloqueado
            byte[] bytes = System.IO.File.ReadAllBytes(ruta);
            pbImagen.Image = Image.FromStream(new System.IO.MemoryStream(bytes));
        }

        // devuelve la carpeta ProductosCandy (al lado del exe), la crea si no existe
        private string CarpetaImagenes_14OR()
        {
            string carpeta = System.IO.Path.Combine(Application.StartupPath, CARPETA_IMAGENES_14OR);
            if (!System.IO.Directory.Exists(carpeta)) System.IO.Directory.CreateDirectory(carpeta);
            return carpeta;
        }
    }
}

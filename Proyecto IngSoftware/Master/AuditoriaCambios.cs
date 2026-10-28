using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Auditoria de la BITACORA DE CAMBIOS de peliculas: muestra el historico (tabla espejo
    // Pelicula_C_14OR), permite filtrarlo con un buscador en vivo + fechas y hacer ROLLBACK
    // (reactivar una version historica como la vigente). Vive en Maestros, solo Admin/Supervisores.
    //
    // La UI NO decide que filas pasan el filtro: carga todo el historico una vez y le pide a la
    // BLL (FiltrarEnMemoria_14OR, con LINQ) la lista ya filtrada. Toda la logica vive en la BLL.
    public partial class AuditoriaCambios : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllPeliculaCambio_14OR bll = new BllPeliculaCambio_14OR();

        // todo el historico, cargado una sola vez; el buscador filtra sobre esto en memoria
        private List<PeliculaCambio_14OR> todos_14OR = new List<PeliculaCambio_14OR>();

        public AuditoriaCambios()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            EstiloGrilla_14OR();

            // las fechas no pudeen ser posteriores a hoy
            dtpDesde.MaxDate = DateTime.Today;
            dtpHasta.MaxDate = DateTime.Today;

            CargarTodo_14OR();
        }

        // trae todo el historico desde la base (una vez, o al refrescar con APLICAR)
        private void CargarTodo_14OR()
        {
            try
            {
                todos_14OR = bll.Listar_14OR();
                Refrescar_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar el historico: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // aplica el filtro actual (buscador + fechas) pidiendoselo a la BLL y refresca la grilla
        private void Refrescar_14OR()
        {
            DateTime? desde = chkDesde.Checked ? (DateTime?)dtpDesde.Value.Date : null;
            DateTime? hasta = chkHasta.Checked ? (DateTime?)dtpHasta.Value.Date : null;

            List<PeliculaCambio_14OR> filtrado = bll.FiltrarEnMemoria_14OR(todos_14OR, txtBuscar.Text, desde, hasta);

            var vista = filtrado.Select(c => new
            {
                c.IdCambio_14OR,
                c.IdPelicula_14OR,
                c.Titulo_14OR,
                c.Genero_14OR,
                c.Duracion_14OR,
                Tipo = c.TipoCambio_14OR,
                Vigente = c.Act_14OR ? "SI" : "NO",
                Fecha = c.FechaHora_14OR.ToString("dd/MM/yyyy"),
                Hora = c.FechaHora_14OR.ToString("HH:mm")
            }).ToList();

            dgvCambios.DataSource = vista;

            if (dgvCambios.Columns.Count > 0)
            {
                dgvCambios.Columns["IdCambio_14OR"].Visible = false;
                dgvCambios.Columns["IdPelicula_14OR"].HeaderText = "Id Peli";
                dgvCambios.Columns["IdPelicula_14OR"].FillWeight = 40;
                dgvCambios.Columns["Titulo_14OR"].HeaderText = "Titulo";
                dgvCambios.Columns["Genero_14OR"].HeaderText = "Genero";
                dgvCambios.Columns["Duracion_14OR"].HeaderText = "Duracion";
                dgvCambios.Columns["Duracion_14OR"].FillWeight = 45;
                dgvCambios.Columns["Tipo"].HeaderText = "Cambio";
                dgvCambios.Columns["Tipo"].FillWeight = 55;
                dgvCambios.Columns["Vigente"].HeaderText = "Vigente";
                dgvCambios.Columns["Vigente"].FillWeight = 40;
                dgvCambios.Columns["Fecha"].FillWeight = 50;
                dgvCambios.Columns["Hora"].FillWeight = 35;
            }

            PintarVigentes_14OR();
        }

        // resalto en verde las filas vigentes (Act = 1) para que se vean de un vistazo
        private void PintarVigentes_14OR()
        {
            foreach (DataGridViewRow row in dgvCambios.Rows)
            {
                if (row.Cells["Vigente"].Value != null && row.Cells["Vigente"].Value.ToString() == "SI")
                {
                    row.DefaultCellStyle.ForeColor = Color.FromArgb(120, 200, 130);
                }
            }
        }

        // buscador en vivo: cada letra que escribis vuelve a filtrar (en memoria, via BLL)
        private void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            Refrescar_14OR();
        }

        // si cambio una fecha o su tilde, re-filtro
        private void Filtro_Changed_14OR(object sender, EventArgs e)
        {
            Refrescar_14OR();
        }

        // APLICA = vuelve a traer el historico de la base y re-filtra (util tras cambios externos)
        private void btnAplicar_Click(object sender, EventArgs e)
        {
            CargarTodo_14OR();
        }

        // LIMPIAR = borra el buscador y las fechas, y muestra todo
        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscar.Clear();
            chkDesde.Checked = false;
            chkHasta.Checked = false;
            Refrescar_14OR();
        }

        // ACTIVAR = rollback: reactiav la version historica elegida como la vigente
        private void btnActivar_Click(object sender, EventArgs e)
        {
            if (dgvCambios.CurrentRow == null)
            {
                MessageBox.Show("Elegi una fila del historico para reactivar.", "Atencion",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            int idCambio = Convert.ToInt32(dgvCambios.CurrentRow.Cells["IdCambio_14OR"].Value);
            string titulo = dgvCambios.CurrentRow.Cells["Titulo_14OR"].Value.ToString();

            if (MessageBox.Show("Reactivar esta version como la vigente?\n\n" + titulo,
                "Confirmar rollback", MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes)
                return;

            try
            {
                bll.Rollback_14OR(idCambio);
                MessageBox.Show("Version reactivada. Ahora es la vigente de esa pelicula.",
                    "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                CargarTodo_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void EstiloGrilla_14OR()
        {
            dgvCambios.EnableHeadersVisualStyles = false;
            dgvCambios.BackgroundColor = Color.FromArgb(36, 36, 36);
            dgvCambios.BorderStyle = BorderStyle.None;
            dgvCambios.GridColor = Color.FromArgb(61, 61, 61);
            dgvCambios.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvCambios.MultiSelect = false;
            dgvCambios.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvCambios.RowHeadersVisible = false;
            dgvCambios.AllowUserToAddRows = false;
            dgvCambios.ReadOnly = true;
            dgvCambios.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(46, 46, 46);
            dgvCambios.ColumnHeadersDefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvCambios.ColumnHeadersDefaultCellStyle.SelectionBackColor = Color.FromArgb(46, 46, 46);
            dgvCambios.DefaultCellStyle.BackColor = Color.FromArgb(36, 36, 36);
            dgvCambios.DefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvCambios.DefaultCellStyle.SelectionBackColor = Color.FromArgb(18, 58, 94);
            dgvCambios.DefaultCellStyle.SelectionForeColor = Color.White;
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
    }
}

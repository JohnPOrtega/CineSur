using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    public partial class Funciones_14OR : Form
    {
        // la gui solo llama a la bll
        private BllFuncion_14OR bll = new BllFuncion_14OR();
        private BllPelicula_14OR bllPeli = new BllPelicula_14OR();
        private BllSala_14OR bllSala = new BllSala_14OR();

        // me guardo las funciones que trajo la grilla para despues buscar la elegida por id
        private List<Funcion_14OR> funcionesActuales_14OR = new List<Funcion_14OR>();

        private int idSeleccionado_14OR = 0;
        private string modo_14OR = "";

        public Funciones_14OR()
        {
            InitializeComponent();
            // no dejo elegir una fecha anterior a hoy directamente desde el control
            dtpFecha.MinDate = DateTime.Today;
            EstiloGrilla_14OR();
            CargarCombos_14OR();
            CargarGrilla_14OR();
            ModoInicial_14OR();
        }

        // ---- combos ----

        private void CargarCombos_14OR()
        {
            try
            {
                // lleno el combo de pelis. cada item es un objeto Pelicula_14OR entero
                // asi despues saco la duracion para la regla de los 30 min
                cmbPelicula.DataSource = bllPeli.Listar_14OR();
                cmbPelicula.DisplayMember = "Titulo_14OR";
                cmbPelicula.ValueMember = "IdPelicula_14OR";
                cmbPelicula.SelectedIndex = -1;

                // lleno el combo de salas (todavia no tienen abm pero las listo para elegir)
                cmbSala.DataSource = bllSala.Listar_14OR();
                cmbSala.DisplayMember = "Numero_14OR";
                cmbSala.ValueMember = "IdSala_14OR";
                cmbSala.SelectedIndex = -1;
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar pelis o salas: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // ---- grilla ----

        private void CargarGrilla_14OR()
        {
            try
            {
                funcionesActuales_14OR = bll.Listar_14OR();

                // proyecto a algo lindo para mostrar (titulo en vez de idpeli, etc)
                var lista = funcionesActuales_14OR.Select(f => new
                {
                    f.IdFuncion_14OR,
                    Pelicula = f.Pelicula.Titulo_14OR,
                    Sala = f.Sala.Numero_14OR,
                    Fecha = f.Fecha_14OR.ToString("dd/MM/yyyy"),
                    Hora = f.Horario_14OR.ToString("HH:mm"),
                    Formato = FormatoATexto_14OR(f.Formato_14OR),
                    f.Idioma_14OR,
                    PrecioBase = f.Precio_14OR,
                    // el precio final ya trae sumados los recargos de formato/idioma
                    PrecioFinal = bll.CalcularPrecioFinal_14OR(f)
                }).ToList();

                dgvFunciones.DataSource = lista;

                if (dgvFunciones.Columns.Count > 0)
                {
                    dgvFunciones.Columns["IdFuncion_14OR"].HeaderText = "ID";
                    dgvFunciones.Columns["Idioma_14OR"].HeaderText = "Idioma";
                    dgvFunciones.Columns["PrecioBase"].HeaderText = "Precio base";
                    dgvFunciones.Columns["PrecioFinal"].HeaderText = "Precio final";
                    dgvFunciones.Columns["IdFuncion_14OR"].FillWeight = 40;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar las funciones: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void EstiloGrilla_14OR()
        {
            dgvFunciones.EnableHeadersVisualStyles = false;
            dgvFunciones.BackgroundColor = Color.FromArgb(36, 36, 36);
            dgvFunciones.BorderStyle = BorderStyle.None;
            dgvFunciones.GridColor = Color.FromArgb(61, 61, 61);
            dgvFunciones.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvFunciones.MultiSelect = false;
            dgvFunciones.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvFunciones.RowTemplate.Height = 28;
            dgvFunciones.ColumnHeadersHeight = 30;

            dgvFunciones.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(46, 46, 46);
            dgvFunciones.ColumnHeadersDefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvFunciones.ColumnHeadersDefaultCellStyle.SelectionBackColor = Color.FromArgb(46, 46, 46);
            dgvFunciones.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI", 9.5F, FontStyle.Bold);

            dgvFunciones.DefaultCellStyle.BackColor = Color.FromArgb(36, 36, 36);
            dgvFunciones.DefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvFunciones.DefaultCellStyle.SelectionBackColor = Color.FromArgb(18, 58, 94);
            dgvFunciones.DefaultCellStyle.SelectionForeColor = Color.White;
            dgvFunciones.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(40, 40, 40);
        }

        // ---- modos ----

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
            lblEstado.Text = "Selecciona una funcion de la grilla, o toca NUEVO para cargar una.";
        }

        private void LimpiarCampos_14OR()
        {
            cmbPelicula.SelectedIndex = -1;
            cmbSala.SelectedIndex = -1;
            cmbFormato.SelectedIndex = -1;
            cmbIdioma.SelectedIndex = -1;
            dtpFecha.Value = DateTime.Today;
            dtpHora.Value = DateTime.Now;
            numPrecio.Value = 0;
        }

        private void BloquearCampos_14OR(bool bloquear)
        {
            cmbPelicula.Enabled = !bloquear;
            cmbSala.Enabled = !bloquear;
            dtpFecha.Enabled = !bloquear;
            dtpHora.Enabled = !bloquear;
            cmbFormato.Enabled = !bloquear;
            cmbIdioma.Enabled = !bloquear;
            numPrecio.Enabled = !bloquear;
        }

        // ---- eventos ----

        private void dgvFunciones_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvFunciones.CurrentRow == null) return;

            idSeleccionado_14OR = Convert.ToInt32(dgvFunciones.CurrentRow.Cells["IdFuncion_14OR"].Value);

            // busco la funcion completa en la lista que me guarde
            Funcion_14OR f = funcionesActuales_14OR.FirstOrDefault(x => x.IdFuncion_14OR == idSeleccionado_14OR);
            if (f == null) return;

            cmbPelicula.SelectedValue = f.Pelicula.IdPelicula_14OR;
            cmbSala.SelectedValue = f.Sala.IdSala_14OR;
            // si la fecha guardada quedo antes de hoy no la puedo meter en el picker (MinDate = hoy), la dejo en hoy
            dtpFecha.Value = f.Fecha_14OR.Date < dtpFecha.MinDate ? dtpFecha.MinDate : f.Fecha_14OR;
            dtpHora.Value = f.Horario_14OR;
            cmbFormato.SelectedItem = FormatoATexto_14OR(f.Formato_14OR);
            cmbIdioma.SelectedItem = f.Idioma_14OR;
            numPrecio.Value = (decimal)f.Precio_14OR;

            modo_14OR = "";
            BloquearCampos_14OR(true);
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnGuardar.Enabled = false;
            btnNuevo.Enabled = true;
            lblEstado.Text = "Funcion " + idSeleccionado_14OR + " seleccionada. Podes MODIFICAR o ELIMINAR.";
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
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            modo_14OR = "modif";
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnNuevo.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo MODIFICACION de la funcion " + idSeleccionado_14OR + ".";
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // chequeo que hayan elegido en los combos, sino salta null feo
                if (cmbPelicula.SelectedItem == null || cmbSala.SelectedItem == null ||
                    cmbFormato.SelectedItem == null || cmbIdioma.SelectedItem == null)
                {
                    MessageBox.Show("Completa pelicula, sala, formato e idioma.", "Atencion",
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                // armo la funcion con lo que hay en pantalla
                Funcion_14OR f = new Funcion_14OR();
                f.Pelicula = (Pelicula_14OR)cmbPelicula.SelectedItem;
                f.Sala = (Sala_14OR)cmbSala.SelectedItem;
                f.Fecha_14OR = dtpFecha.Value.Date;
                // junto la fecha con la hora en un solo datetime para el horario de arranque
                f.Horario_14OR = dtpFecha.Value.Date.Add(dtpHora.Value.TimeOfDay);
                f.Formato_14OR = TextoAFormato_14OR(cmbFormato.SelectedItem.ToString());
                f.Idioma_14OR = cmbIdioma.SelectedItem.ToString();
                f.Precio_14OR = (double)numPrecio.Value;

                if (modo_14OR == "nuevo")
                {
                    bll.Alta_14OR(f);
                    MessageBox.Show("Funcion dada de alta.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (modo_14OR == "modif")
                {
                    f.IdFuncion_14OR = idSeleccionado_14OR;
                    bll.Modificar_14OR(f);
                    MessageBox.Show("Funcion modificada.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
                // aca caen las validaciones de la bll, entre ellas la de los 30 min
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            DialogResult r = MessageBox.Show("Seguro que queres eliminar la funcion " + idSeleccionado_14OR + "?",
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
                MessageBox.Show("No se pudo eliminar. Puede que la funcion tenga asientos generados.\n\nDetalle: " + ex.Message,
                    "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // ---- helpers de formato (mismo criterio que la dal) ----

        private string FormatoATexto_14OR(FormatoFuncion_14OR formato)
        {
            if (formato == FormatoFuncion_14OR.DosD) return "2D";
            if (formato == FormatoFuncion_14OR.TresD) return "3D";
            return "4DX";
        }

        private FormatoFuncion_14OR TextoAFormato_14OR(string texto)
        {
            if (texto == "3D") return FormatoFuncion_14OR.TresD;
            if (texto == "4DX") return FormatoFuncion_14OR.CuatroDX;
            return FormatoFuncion_14OR.DosD;
        }

        // handler del boton Cancelar: agregas el boton en el disenador y le enganchas
        // este metodo en su evento Click. descarta lo que estabas cargando y vuelve al inicio.
        private void btnCancelar_Click(object sender, EventArgs e)
        {
            ModoInicial_14OR();
        }
    }
}

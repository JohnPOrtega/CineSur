using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // ABM de proveedores del Candy Bar (a quienes el Supervisor de compras les pide
    // presupuesto y les compra los insumos). Mismo patron que el resto de los maestros.
    public partial class Proveedores : Form
    {
        private BllProveedor_14OR bll = new BllProveedor_14OR();

        private int idSeleccionado_14OR = 0;
        private string modo_14OR = "";

        public Proveedores()
        {
            InitializeComponent();
            EstiloGrilla_14OR();
            CargarGrilla_14OR();
            ModoInicial_14OR();
        }

        // ---- acrga y estilo de la grilla ----

        private void CargarGrilla_14OR()
        {
            try
            {
                var lista = bll.Listar_14OR().Select(pr => new
                {
                    pr.IdProveedor_14OR,
                    pr.Nombre_14OR,
                    pr.Telefono_14OR,
                    pr.Email_14OR
                }).ToList();

                dgvProveedores.DataSource = lista;

                if (dgvProveedores.Columns.Count > 0)
                {
                    dgvProveedores.Columns["IdProveedor_14OR"].HeaderText = "ID";
                    dgvProveedores.Columns["Nombre_14OR"].HeaderText = "Proveedor";
                    dgvProveedores.Columns["Telefono_14OR"].HeaderText = "Telefono";
                    dgvProveedores.Columns["Email_14OR"].HeaderText = "Email";
                    dgvProveedores.Columns["IdProveedor_14OR"].FillWeight = 30;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar los proveedores: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void EstiloGrilla_14OR()
        {
            dgvProveedores.EnableHeadersVisualStyles = false;
            dgvProveedores.BackgroundColor = Color.FromArgb(36, 36, 36);
            dgvProveedores.BorderStyle = BorderStyle.None;
            dgvProveedores.GridColor = Color.FromArgb(61, 61, 61);
            dgvProveedores.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvProveedores.MultiSelect = false;
            dgvProveedores.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvProveedores.RowTemplate.Height = 28;
            dgvProveedores.ColumnHeadersHeight = 30;

            dgvProveedores.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(46, 46, 46);
            dgvProveedores.ColumnHeadersDefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvProveedores.ColumnHeadersDefaultCellStyle.SelectionBackColor = Color.FromArgb(46, 46, 46);
            dgvProveedores.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI", 9.5F, FontStyle.Bold);

            dgvProveedores.DefaultCellStyle.BackColor = Color.FromArgb(36, 36, 36);
            dgvProveedores.DefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvProveedores.DefaultCellStyle.SelectionBackColor = Color.FromArgb(18, 58, 94);
            dgvProveedores.DefaultCellStyle.SelectionForeColor = Color.White;
            dgvProveedores.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(40, 40, 40);
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
            lblEstado.Text = "Selecciona una fila de la grilla, o toca NUEVO para cargar un proveedor.";
        }

        private void LimpiarCampos_14OR()
        {
            txtNombre.Clear();
            txtTelefono.Clear();
            txtEmail.Clear();
        }

        private void BloquearCampos_14OR(bool bloquear)
        {
            txtNombre.Enabled = !bloquear;
            txtTelefono.Enabled = !bloquear;
            txtEmail.Enabled = !bloquear;
        }

        // ---- eventos ----

        private void dgvProveedores_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvProveedores.CurrentRow == null) return;

            idSeleccionado_14OR = Convert.ToInt32(dgvProveedores.CurrentRow.Cells["IdProveedor_14OR"].Value);

            txtNombre.Text = dgvProveedores.CurrentRow.Cells["Nombre_14OR"].Value.ToString();
            txtTelefono.Text = dgvProveedores.CurrentRow.Cells["Telefono_14OR"].Value.ToString();
            txtEmail.Text = dgvProveedores.CurrentRow.Cells["Email_14OR"].Value.ToString();

            modo_14OR = "";
            BloquearCampos_14OR(true);
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnGuardar.Enabled = false;
            btnNuevo.Enabled = true;
            lblEstado.Text = "Proveedor " + idSeleccionado_14OR + " seleccionado. Podes MODIFICAR o ELIMINAR.";
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
            lblEstado.Text = "Modo MODIFICACION del proveedor " + idSeleccionado_14OR + ". Cambia lo que quieras y toca GUARDAR.";
            txtNombre.Focus();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Proveedor_14OR pr = new Proveedor_14OR();
                pr.Nombre_14OR = txtNombre.Text.Trim();
                pr.Telefono_14OR = txtTelefono.Text.Trim();
                pr.Email_14OR = txtEmail.Text.Trim();

                if (modo_14OR == "nuevo")
                {
                    bll.Alta_14OR(pr);
                    MessageBox.Show("Proveedor dado de alta.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (modo_14OR == "modif")
                {
                    pr.IdProveedor_14OR = idSeleccionado_14OR;
                    bll.Modificar_14OR(pr);
                    MessageBox.Show("Proveedor modificado.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            DialogResult r = MessageBox.Show("Seguro que queres eliminar el proveedor " + idSeleccionado_14OR + "?",
                "Confirmar", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (r != DialogResult.Yes) return;

            try
            {
                // baja logica, igual que productos
                bll.Baja_14OR(idSeleccionado_14OR);
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
    }
}

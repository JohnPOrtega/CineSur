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
    public partial class Proveedores : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllProveedor_14OR bll = new BllProveedor_14OR();

        private int idSeleccionado_14OR = 0;
        private string modo_14OR = "";

        // me guardo el ultimo estado apra volver a traducirlo si cambian el idioma
        private string estadoClave_14OR = null;
        private string estadoDefecto_14OR = "";
        private int estadoNumero_14OR = 0;

        public Proveedores()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            this.Text = T_14OR("proveedores_titulo", "Proveedores");
            EstiloGrilla_14OR();
            CargarGrilla_14OR();
            ModoInicial_14OR();
        }

        // ---- acrga y estilo de la grilla ----

        private void CargarGrilla_14OR()
        {
            try
            {
                var lista = bll.ListarProveedor_14OR().Select(pr => new
                {
                    pr.IdProveedor_14OR,
                    pr.Nombre_14OR,
                    pr.Cuit_14OR,
                    pr.Telefono_14OR,
                    pr.Email_14OR
                }).ToList();

                dgvProveedores.DataSource = lista;

                if (dgvProveedores.Columns.Count > 0)
                {
                    TraducirColumnas_14OR();
                    dgvProveedores.Columns["IdProveedor_14OR"].FillWeight = 30;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("proveedores_msg_errorcargar", "No pude cargar los proveedores: ") + ex.Message, T_14OR("titulo_error", "Error"),
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
            // alto fijo xq el automatico se pisa con las columnas Fill
            dgvProveedores.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            dgvProveedores.ColumnHeadersHeight = 44;

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
            MostrarEstado_14OR("proveedores_estado_inicial", "Selecciona una fila de la grilla, o toca NUEVO para cargar un proveedor.");
        }

        private void LimpiarCampos_14OR()
        {
            txtNombre.Clear();
            txtCuit.Clear();
            txtTelefono.Clear();
            txtEmail.Clear();
        }

        private void BloquearCampos_14OR(bool bloquear)
        {
            txtNombre.Enabled = !bloquear;
            txtCuit.Enabled = !bloquear;
            txtTelefono.Enabled = !bloquear;
            txtEmail.Enabled = !bloquear;
        }

        // ---- eventos ----

        private void dgvProveedores_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvProveedores.CurrentRow == null) return;

            idSeleccionado_14OR = Convert.ToInt32(dgvProveedores.CurrentRow.Cells["IdProveedor_14OR"].Value);

            txtNombre.Text = dgvProveedores.CurrentRow.Cells["Nombre_14OR"].Value.ToString();
            txtCuit.Text = Convert.ToString(dgvProveedores.CurrentRow.Cells["Cuit_14OR"].Value);
            txtTelefono.Text = dgvProveedores.CurrentRow.Cells["Telefono_14OR"].Value.ToString();
            txtEmail.Text = dgvProveedores.CurrentRow.Cells["Email_14OR"].Value.ToString();

            modo_14OR = "";
            BloquearCampos_14OR(true);
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnGuardar.Enabled = false;
            btnNuevo.Enabled = true;
            MostrarEstado_14OR("proveedores_estado_seleccionado", "Proveedor {0} seleccionado. Podes MODIFICAR o ELIMINAR.", idSeleccionado_14OR);
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
            MostrarEstado_14OR("pn2_estado_alta", "Modo ALTA: carga los datos y toca GUARDAR.");
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
            MostrarEstado_14OR("proveedores_estado_modif", "Modo MODIFICACION del proveedor {0}. Cambia lo que quieras y toca GUARDAR.", idSeleccionado_14OR);
            txtNombre.Focus();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Proveedor_14OR pr = new Proveedor_14OR();
                pr.Nombre_14OR = txtNombre.Text.Trim();
                pr.Cuit_14OR = txtCuit.Text.Trim();
                pr.Telefono_14OR = txtTelefono.Text.Trim();
                pr.Email_14OR = txtEmail.Text.Trim();

                if (modo_14OR == "nuevo")
                {
                    bll.AltaProveedor_14OR(pr);
                    MessageBox.Show(T_14OR("proveedores_msg_alta", "Proveedor dado de alta."), T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (modo_14OR == "modif")
                {
                    pr.IdProveedor_14OR = idSeleccionado_14OR;
                    bll.ModificarProveedor_14OR(pr);
                    MessageBox.Show(T_14OR("proveedores_msg_modificado", "Proveedor modificado."), T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);
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
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            DialogResult r = MessageBox.Show(string.Format(T_14OR("proveedores_msg_confirmareliminar", "Seguro que queres eliminar el proveedor {0}?"), idSeleccionado_14OR),
                T_14OR("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (r != DialogResult.Yes) return;

            try
            {
                // baja logica, igual que productos
                bll.BajaProveedor_14OR(idSeleccionado_14OR);
                MessageBox.Show(T_14OR("proveedores_msg_baja", "Proveedor dado de baja."), T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);
                CargarGrilla_14OR();
                ModoInicial_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            ModoInicial_14OR();
        }

        // atajo pa traducir cn el idioma actual, si falta la clave usa el texto x defecto
        private string T_14OR(string clave, string porDefecto)
        {
            return GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(clave, porDefecto);
        }

        // muestro el estado del abm y me lo acuerdo x si cambian de idioma
        private void MostrarEstado_14OR(string clave, string porDefecto, int numero = 0)
        {
            estadoClave_14OR = clave;
            estadoDefecto_14OR = porDefecto;
            estadoNumero_14OR = numero;
            lblEstado.Text = string.Format(T_14OR(clave, porDefecto), numero);
        }

        private void TraducirColumnas_14OR()
        {
            dgvProveedores.TituloColumna_43BO("IdProveedor_14OR", T_14OR("pn2_col_id", "ID"));
            dgvProveedores.TituloColumna_43BO("Nombre_14OR", T_14OR("pn2_col_razonsocial", "Razon social"));
            dgvProveedores.TituloColumna_43BO("Cuit_14OR", T_14OR("pn2_col_cuit", "CUIT"));
            dgvProveedores.TituloColumna_43BO("Telefono_14OR", T_14OR("pn2_col_telefono", "Telefono"));
            dgvProveedores.TituloColumna_43BO("Email_14OR", T_14OR("pn2_col_email", "Email"));
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            if (IsDisposed) return;
            this.TraducirAuto_43BO(dic);
            this.Text = T_14OR("proveedores_titulo", "Proveedores");
            TraducirColumnas_14OR();
            if (estadoClave_14OR != null)
                lblEstado.Text = string.Format(T_14OR(estadoClave_14OR, estadoDefecto_14OR), estadoNumero_14OR);
        }
    }
}

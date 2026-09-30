using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // ABM de Promociones (Master). El diseno esta en Promociones.Designer.cs.
    // las promos se administran aca; la venta las usa sola (no se tocan desde la venta).
    public partial class Promociones : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllPromocion_14OR bll = new BllPromocion_14OR();
        private List<Promocion_14OR> promosActuales_14OR = new List<Promocion_14OR>();
        private int idSeleccionado_14OR = 0;
        private string modo_14OR = "";

        public Promociones()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            CargarCombo_14OR();
            CargarGrilla_14OR();
            ModoInicial_14OR();
        }

        private void CargarCombo_14OR()
        {
            cmbTipo.Items.Clear();
            cmbTipo.Items.Add("Porcentaje");
            cmbTipo.Items.Add("2x1");
        }

        private void CargarGrilla_14OR()
        {
            try
            {
                promosActuales_14OR = bll.Listar_14OR();
                var lista = promosActuales_14OR.Select(p => new
                {
                    p.IdPromocion_14OR,
                    p.Nombre_14OR,
                    Tipo = (p.Tipo_14OR == TipoPromocion_14OR.DosPorUno ? "2x1" : "Porcentaje"),
                    Valor = (p.Tipo_14OR == TipoPromocion_14OR.DosPorUno ? "-" : p.Valor_14OR.ToString("0") + "%"),
                    Desde = p.FechaInicio_14OR.ToString("dd/MM/yyyy"),
                    Hasta = p.FechaFin_14OR.ToString("dd/MM/yyyy"),
                    Activa = (p.Activa_14OR ? "Si" : "No")
                }).ToList();

                dgvPromos.DataSource = lista;

                if (dgvPromos.Columns.Count > 0)
                {
                    dgvPromos.Columns["IdPromocion_14OR"].HeaderText = "ID";
                    dgvPromos.Columns["Nombre_14OR"].HeaderText = "Nombre";
                    dgvPromos.Columns["IdPromocion_14OR"].FillWeight = 30;
                    dgvPromos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar las promociones: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
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
            btnCancelar.Enabled = false;
            lblEstado.Text = "Toca NUEVO para crear una promocion, o elegi una de la lista.";
        }

        private void LimpiarCampos_14OR()
        {
            txtNombre.Text = "";
            cmbTipo.SelectedIndex = 0;
            numValor.Value = 0;
            dtpInicio.Value = DateTime.Today;
            dtpFin.Value = DateTime.Today;
            chkActiva.Checked = true;
            ActualizarValorSegunTipo_14OR();
        }

        private void BloquearCampos_14OR(bool bloquear)
        {
            txtNombre.Enabled = !bloquear;
            cmbTipo.Enabled = !bloquear;
            numValor.Enabled = !bloquear;
            dtpInicio.Enabled = !bloquear;
            dtpFin.Enabled = !bloquear;
            chkActiva.Enabled = !bloquear;
            if (!bloquear) ActualizarValorSegunTipo_14OR();
        }

        // el campo de % solo tiene sentido en Porcentaje; en 2x1 lo apago
        private void ActualizarValorSegunTipo_14OR()
        {
            bool esPorcentaje = cmbTipo.SelectedIndex == 0;
            numValor.Enabled = esPorcentaje && txtNombre.Enabled;
        }

        private void cmbTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            ActualizarValorSegunTipo_14OR();
        }

        // ---- eventos ----

        private void dgvPromos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvPromos.CurrentRow == null) return;

            idSeleccionado_14OR = Convert.ToInt32(dgvPromos.CurrentRow.Cells["IdPromocion_14OR"].Value);
            Promocion_14OR p = promosActuales_14OR.FirstOrDefault(x => x.IdPromocion_14OR == idSeleccionado_14OR);
            if (p == null) return;

            txtNombre.Text = p.Nombre_14OR;
            cmbTipo.SelectedIndex = (p.Tipo_14OR == TipoPromocion_14OR.DosPorUno) ? 1 : 0;
            numValor.Value = Math.Min((decimal)p.Valor_14OR, numValor.Maximum);
            dtpInicio.Value = p.FechaInicio_14OR;
            dtpFin.Value = p.FechaFin_14OR;
            chkActiva.Checked = p.Activa_14OR;

            modo_14OR = "";
            BloquearCampos_14OR(true);
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnGuardar.Enabled = false;
            btnCancelar.Enabled = false;
            btnNuevo.Enabled = true;
            lblEstado.Text = "Promocion " + idSeleccionado_14OR + " seleccionada. Podes MODIFICAR o ELIMINAR.";
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            modo_14OR = "nuevo";
            idSeleccionado_14OR = 0;
            LimpiarCampos_14OR();
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnCancelar.Enabled = true;
            btnNuevo.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo ALTA: carga la promocion y toca GUARDAR.";
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;
            modo_14OR = "modif";
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnCancelar.Enabled = true;
            btnNuevo.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo MODIFICACION de la promocion " + idSeleccionado_14OR + ".";
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Promocion_14OR p = new Promocion_14OR();
                p.Nombre_14OR = txtNombre.Text.Trim();
                p.Tipo_14OR = (cmbTipo.SelectedIndex == 1) ? TipoPromocion_14OR.DosPorUno : TipoPromocion_14OR.Porcentaje;
                p.Valor_14OR = (p.Tipo_14OR == TipoPromocion_14OR.DosPorUno) ? 0 : (double)numValor.Value;
                p.FechaInicio_14OR = dtpInicio.Value.Date;
                p.FechaFin_14OR = dtpFin.Value.Date;
                p.Activa_14OR = chkActiva.Checked;

                if (modo_14OR == "nuevo")
                {
                    bll.Alta_14OR(p);
                    MessageBox.Show("Promocion creada.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (modo_14OR == "modif")
                {
                    p.IdPromocion_14OR = idSeleccionado_14OR;
                    bll.Modificar_14OR(p);
                    MessageBox.Show("Promocion modificada.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
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

            DialogResult r = MessageBox.Show("Seguro que queres eliminar la promocion " + idSeleccionado_14OR + "?",
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
                // si alguna venta ya uso la promo, la fk lo frena; en ese caso conviene desactivarla (Activa=No)
                MessageBox.Show("No se pudo eliminar. Si ya se uso en una venta, desactivala en vez de borrarla.\n\nDetalle: " + ex.Message,
                    "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            ModoInicial_14OR();
        }
    
        // traduccion automatica: al cambiar idioma el gestor llama aca y se traducen
        // todos los controles estaticos que tengan clave en el JSON (patron observer).
        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
}
}

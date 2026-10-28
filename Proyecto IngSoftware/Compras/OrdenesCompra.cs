using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Lista de ordenes de compra. Por ahora (tanda A) es solo consulta: se ven las ordenes
    // generadas desde los presupuestos aceptados, en estado "Abierta".
    // El pago (tanda B) y la recepcion/cierre que sube el stock (tanda C) se agregan despues.
    public partial class OrdenesCompra : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllOrdenCompra_14OR bllOrden = new BllOrdenCompra_14OR();

        public OrdenesCompra()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            EstiloGrillas_14OR();
            CargarOrdenes_14OR();
        }

        private void CargarOrdenes_14OR()
        {
            try
            {
                var lista = bllOrden.Listar_14OR().Select(o => new
                {
                    o.IdOrdenCompra_14OR,
                    o.NumeroOrden_14OR,
                    o.NombreProveedor_14OR,
                    Fecha = o.FechaEmision_14OR.ToString("dd/MM/yyyy"),
                    o.Estado_14OR,
                    Importe = o.Importe_14OR
                }).ToList();

                dgvOrdenes.DataSource = lista;

                if (dgvOrdenes.Columns.Count > 0)
                {
                    dgvOrdenes.Columns["IdOrdenCompra_14OR"].Visible = false;
                    dgvOrdenes.Columns["NumeroOrden_14OR"].HeaderText = "N°";
                    dgvOrdenes.Columns["NombreProveedor_14OR"].HeaderText = "Proveedor";
                    dgvOrdenes.Columns["Fecha"].HeaderText = "Emision";
                    dgvOrdenes.Columns["Estado_14OR"].HeaderText = "Estado";
                    dgvOrdenes.Columns["Importe"].HeaderText = "Importe";
                    dgvOrdenes.Columns["Importe"].DefaultCellStyle.Format = "0.00";
                    dgvOrdenes.Columns["NumeroOrden_14OR"].FillWeight = 25;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar las ordenes: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void dgvOrdenes_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvOrdenes.CurrentRow == null) return;
            int id = Convert.ToInt32(dgvOrdenes.CurrentRow.Cells["IdOrdenCompra_14OR"].Value);

            try
            {
                var detalle = bllOrden.ObtenerDetalle_14OR(id).Select(d => new
                {
                    d.NombreProducto_14OR,
                    d.Cantidad_14OR,
                    PrecioCosto = d.PrecioCosto_14OR,
                    Subtotal = d.Subtotal_14OR
                }).ToList();

                dgvDetalleOrden.DataSource = detalle;

                if (dgvDetalleOrden.Columns.Count > 0)
                {
                    dgvDetalleOrden.Columns["NombreProducto_14OR"].HeaderText = "Producto";
                    dgvDetalleOrden.Columns["Cantidad_14OR"].HeaderText = "Cantidad";
                    dgvDetalleOrden.Columns["PrecioCosto"].HeaderText = "Precio costo";
                    dgvDetalleOrden.Columns["PrecioCosto"].DefaultCellStyle.Format = "0.00";
                    dgvDetalleOrden.Columns["Subtotal"].HeaderText = "Subtotal";
                    dgvDetalleOrden.Columns["Subtotal"].DefaultCellStyle.Format = "0.00";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar el detalle: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void EstiloGrillas_14OR()
        {
            foreach (DataGridView dgv in new[] { dgvOrdenes, dgvDetalleOrden })
            {
                dgv.EnableHeadersVisualStyles = false;
                dgv.BackgroundColor = Color.FromArgb(36, 36, 36);
                dgv.BorderStyle = BorderStyle.None;
                dgv.GridColor = Color.FromArgb(61, 61, 61);
                dgv.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
                dgv.MultiSelect = false;
                dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
                dgv.RowHeadersVisible = false;
                dgv.AllowUserToAddRows = false;
                dgv.ReadOnly = true;
                dgv.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(46, 46, 46);
                dgv.ColumnHeadersDefaultCellStyle.ForeColor = Color.Gainsboro;
                dgv.ColumnHeadersDefaultCellStyle.SelectionBackColor = Color.FromArgb(46, 46, 46);
                dgv.DefaultCellStyle.BackColor = Color.FromArgb(36, 36, 36);
                dgv.DefaultCellStyle.ForeColor = Color.Gainsboro;
                dgv.DefaultCellStyle.SelectionBackColor = Color.FromArgb(18, 58, 94);
                dgv.DefaultCellStyle.SelectionForeColor = Color.White;
            }
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
    }
}

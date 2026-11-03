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

        // la orden que elegi en la grilla y su estado, pa habilitar Pagar / Recepcion
        private int idOrdenSeleccionada_14OR = 0;
        private string estadoOrden_14OR = "";

        public OrdenesCompra()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            EstiloGrillas_14OR();
            CargarOrdenes_14OR();
            ActualizarBotones_14OR();
        }

        // atajo pa traducir los mensajes con el idioma actual (si falta la clave usa el texto por defecto)
        private string T_14OR(string clave, string porDefecto)
        {
            return GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(clave, porDefecto);
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
                MessageBox.Show(T_14OR("ordenescompra_msg_errorcargar", "No pude cargar las ordenes: ") + ex.Message,
                    T_14OR("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void dgvOrdenes_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvOrdenes.CurrentRow == null) return;
            int id = Convert.ToInt32(dgvOrdenes.CurrentRow.Cells["IdOrdenCompra_14OR"].Value);

            // me guardo la orden y el estado pa los botones
            idOrdenSeleccionada_14OR = id;
            estadoOrden_14OR = dgvOrdenes.CurrentRow.Cells["Estado_14OR"].Value.ToString();
            ActualizarBotones_14OR();

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
                MessageBox.Show(T_14OR("ordenescompra_msg_errordetalle", "No pude cargar el detalle: ") + ex.Message,
                    T_14OR("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // Pagar se prende solo si la orden esta abierta, y Recepcion solo si esta pagada
        private void ActualizarBotones_14OR()
        {
            bool hay = idOrdenSeleccionada_14OR > 0;
            btnPagar.Enabled = hay && estadoOrden_14OR == OrdenCompra_14OR.EstadoAbierta_14OR;
            btnRegistrarRecepcion.Enabled = hay && estadoOrden_14OR == OrdenCompra_14OR.EstadoPagada_14OR;
            txtRemito.Enabled = btnRegistrarRecepcion.Enabled;
        }

        private void LimpiarSeleccion_14OR()
        {
            idOrdenSeleccionada_14OR = 0;
            estadoOrden_14OR = "";
            dgvDetalleOrden.DataSource = null;
            ActualizarBotones_14OR();
        }

        // pago la orden elegida (abierta -> pagada)
        private void btnPagar_Click(object sender, EventArgs e)
        {
            if (idOrdenSeleccionada_14OR <= 0) return;

            if (MessageBox.Show(string.Format(T_14OR("ordenescompra_msg_confirmarpago", "Confirmar el pago de la orden {0}?"), idOrdenSeleccionada_14OR),
                T_14OR("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes) return;

            try
            {
                bllOrden.PagarCompra_14OR(idOrdenSeleccionada_14OR);
                MessageBox.Show(T_14OR("ordenescompra_msg_pagada", "Orden pagada. Quedo en estado 'Pagada'."),
                    T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);
                CargarOrdenes_14OR();
                LimpiarSeleccion_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        // registro la recepcion (pagada -> cerrada) y sumo el stock
        private void btnRegistrarRecepcion_Click(object sender, EventArgs e)
        {
            if (idOrdenSeleccionada_14OR <= 0) return;

            if (string.IsNullOrWhiteSpace(txtRemito.Text))
            {
                MessageBox.Show(T_14OR("ordenescompra_msg_faltaremito", "Ingresa el numero de remito."),
                    T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (MessageBox.Show(string.Format(T_14OR("ordenescompra_msg_confirmarrecepcion", "Registrar la recepcion de la orden {0}? Esto cierra la orden y suma el stock."), idOrdenSeleccionada_14OR),
                T_14OR("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes) return;

            try
            {
                bllOrden.RegistrarIngresoMercaderia_14OR(idOrdenSeleccionada_14OR, txtRemito.Text.Trim());
                MessageBox.Show(T_14OR("ordenescompra_msg_recibida", "Recepcion registrada. La orden quedo 'Cerrada' y se sumo el stock."),
                    T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtRemito.Clear();
                CargarOrdenes_14OR();
                LimpiarSeleccion_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
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

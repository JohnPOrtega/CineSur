using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Ordenes de compra: se ven las ordenes generadas desde los presupuestos aceptados,
    // se pagan (Abierta -> Pagada) y se recibe la mercaderia cargando lo que llego en la
    // columna "Recibido"; se compara contra la orden y si coincide se cierra y sube el stock.
    public partial class OrdenesCompra : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllOrdenCompra_14OR bllOrden = new BllOrdenCompra_14OR();

        // la orden que elegi en la grilla y su estado, pa habilitar Pagar / Recepcion
        private int idOrdenSeleccionada_14OR = 0;
        private string estadoOrden_14OR = "";

        // renglones de la orden elegida, aca el supervisor carga la cantidad recibida
        private List<DetalleOrdenCompra_14OR> detalleActual_14OR = new List<DetalleOrdenCompra_14OR>();

        public OrdenesCompra()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            this.Text = T_14OR("ordenescompra_titulo", "Ordenes de Compra");
            dgvOrdenes.CellFormatting += Estado_CellFormatting_14OR;
            dgvDetalleOrden.DataError += DetalleOrden_DataError_14OR;
            // al cargar la grilla windows marca sola la primer fila, la desmarco si no elegi nada
            dgvOrdenes.DataBindingComplete += (o, ev) => { if (idOrdenSeleccionada_14OR <= 0) { dgvOrdenes.ClearSelection(); dgvOrdenes.CurrentCell = null; } };
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
                    TraducirColumnas_14OR();
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
                CargarDetalle_14OR(id);
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("ordenescompra_msg_errordetalle", "No pude cargar el detalle: ") + ex.Message,
                    T_14OR("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // cargo los renglones de la orden. si esta pagada dejo editable solo la columna
        // "Recibido" pa que el supervisor cargue lo que llego segun el remito
        private void CargarDetalle_14OR(int idOrden)
        {
            detalleActual_14OR = bllOrden.ObtenerDetalle_14OR(idOrden);
            dgvDetalleOrden.DataSource = null;
            dgvDetalleOrden.DataSource = detalleActual_14OR;

            if (dgvDetalleOrden.Columns.Count == 0) return;

            dgvDetalleOrden.Columns["IdDetalleOrdenCompra_14OR"].Visible = false;
            dgvDetalleOrden.Columns["IdOrdenCompra_14OR"].Visible = false;
            dgvDetalleOrden.Columns["IdProducto_14OR"].Visible = false;
            dgvDetalleOrden.Columns["PrecioCosto_14OR"].DefaultCellStyle.Format = "0.00";
            dgvDetalleOrden.Columns["Subtotal_14OR"].DefaultCellStyle.Format = "0.00";
            dgvDetalleOrden.Columns["CantidadRecibida_14OR"].DisplayIndex = 2;
            // la columna Recibido solo tiene sentido cuando la mercaderia esta por llegar o ya llego
            dgvDetalleOrden.Columns["CantidadRecibida_14OR"].Visible =
                estadoOrden_14OR == OrdenCompra_14OR.EstadoPagada_14OR || estadoOrden_14OR == OrdenCompra_14OR.EstadoCerrada_14OR;
            TraducirColumnas_14OR();

            bool recibiendo = estadoOrden_14OR == OrdenCompra_14OR.EstadoPagada_14OR;
            dgvDetalleOrden.ReadOnly = !recibiendo;
            foreach (DataGridViewColumn col in dgvDetalleOrden.Columns)
                col.ReadOnly = col.Name != "CantidadRecibida_14OR" || !recibiendo;

            // la columna editable la pinto distinta pa que se note donde se escribe
            DataGridViewColumn colRecibida = dgvDetalleOrden.Columns["CantidadRecibida_14OR"];
            colRecibida.DefaultCellStyle.BackColor = recibiendo ? Color.FromArgb(42, 42, 42) : Color.FromArgb(36, 36, 36);
            colRecibida.DefaultCellStyle.ForeColor = recibiendo ? Color.White : Color.Gainsboro;
        }

        // si escriben algo que no es un numero en "Recibido" aviso en vez de que reviente la grilla
        private void DetalleOrden_DataError_14OR(object sender, DataGridViewDataErrorEventArgs e)
        {
            MessageBox.Show(T_14OR("ordenescompra_msg_cantidadinvalida", "Ingresa un numero entero valido en la cantidad recibida."),
                T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            e.Cancel = true;
        }

        // Pagar se prende solo si la orden esta abierta, y Recepcion solo si esta pagada
        private void ActualizarBotones_14OR()
        {
            bool hay = idOrdenSeleccionada_14OR > 0;
            btnPagar.Enabled = hay && estadoOrden_14OR == OrdenCompra_14OR.EstadoAbierta_14OR;
            btnRegistrarRecepcion.Enabled = hay && estadoOrden_14OR == OrdenCompra_14OR.EstadoPagada_14OR;
            // el remito solo aparece cuando hay que registrar la recepcion, si no confunde
            txtRemito.Visible = btnRegistrarRecepcion.Enabled;
            lblRemito.Visible = btnRegistrarRecepcion.Enabled;
            ActualizarProximoPaso_14OR();
        }

        // cartel que explica en criollo que hay que hacer con la orden elegida
        private void ActualizarProximoPaso_14OR()
        {
            string est = idOrdenSeleccionada_14OR > 0 ? estadoOrden_14OR : "";

            if (est == OrdenCompra_14OR.EstadoAbierta_14OR)
                lblProximoPaso.Text = T_14OR("ordenescompra_paso_abierta", "Esta orden todavía no se pagó. Cuando le pagues al proveedor, tocá \"Pagar orden\".");
            else if (est == OrdenCompra_14OR.EstadoPagada_14OR)
                lblProximoPaso.Text = T_14OR("ordenescompra_paso_pagada", "Ya está paga, falta que llegue la mercadería. Cuando llegue, anotá el número de remito y en la columna \"Recibido\" cuánto vino de cada producto. Después tocá \"Registrar recepción\".");
            else if (est == OrdenCompra_14OR.EstadoCerrada_14OR)
                lblProximoPaso.Text = T_14OR("ordenescompra_paso_cerrada", "Esta orden ya está cerrada: la mercadería llegó completa y el stock se actualizó.");
            else
                lblProximoPaso.Text = T_14OR("ordenescompra_paso_ninguna", "Elegí una orden de la lista para ver qué productos trae y qué falta hacer con ella.");
        }

        private void LimpiarSeleccion_14OR()
        {
            idOrdenSeleccionada_14OR = 0;
            estadoOrden_14OR = "";
            detalleActual_14OR = new List<DetalleOrdenCompra_14OR>();
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
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        // registro la recepcion (pagada -> cerrada) y sumo el stock. la comparacion de lo
        // recibido contra la orden la hace la bll
        private void btnRegistrarRecepcion_Click(object sender, EventArgs e)
        {
            if (idOrdenSeleccionada_14OR <= 0) return;

            // cierro la edicion de la celda por si quedo escribiendo en "Recibido"
            dgvDetalleOrden.EndEdit();

            if (string.IsNullOrWhiteSpace(txtRemito.Text))
            {
                MessageBox.Show(T_14OR("ordenescompra_msg_faltaremito", "Ingresa el numero de remito."),
                    T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (MessageBox.Show(string.Format(T_14OR("ordenescompra_msg_confirmarrecepcion", "Registrar la recepcion de la orden {0}? Se compara lo recibido contra la orden; si coincide se cierra y se suma el stock."), idOrdenSeleccionada_14OR),
                T_14OR("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes) return;

            try
            {
                bllOrden.RegistrarIngresoMercaderia_14OR(idOrdenSeleccionada_14OR, txtRemito.Text.Trim(), detalleActual_14OR);
                MessageBox.Show(T_14OR("ordenescompra_msg_recibida", "Recepcion registrada. La orden quedo 'Cerrada' y se sumo el stock."),
                    T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtRemito.Clear();
                CargarOrdenes_14OR();
                LimpiarSeleccion_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
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

        // muestro el estado traducido en la grila pero el valor real de la celda no lo toco
        private void Estado_CellFormatting_14OR(object sender, DataGridViewCellFormattingEventArgs e)
        {
            DataGridView dgv = (DataGridView)sender;
            if (e.RowIndex < 0 || e.Value == null) return;
            if (dgv.Columns[e.ColumnIndex].Name != "Estado_14OR") return;
            string estado = e.Value.ToString();

            // cada estado con su color, igual que en Cotizaciones
            if (estado == OrdenCompra_14OR.EstadoAbierta_14OR) e.CellStyle.ForeColor = Color.FromArgb(231, 168, 26);
            else if (estado == OrdenCompra_14OR.EstadoPagada_14OR) e.CellStyle.ForeColor = Color.FromArgb(120, 170, 230);
            else if (estado == OrdenCompra_14OR.EstadoCerrada_14OR) e.CellStyle.ForeColor = Color.FromArgb(90, 190, 120);

            e.Value = T_14OR("estado_" + estado.ToLower(), estado);
            e.FormattingApplied = true;
        }

        private void TraducirColumnas_14OR()
        {
            dgvOrdenes.TituloColumna_43BO("NumeroOrden_14OR", T_14OR("pn2_col_numero", "N°"));
            dgvOrdenes.TituloColumna_43BO("NombreProveedor_14OR", T_14OR("pn2_col_proveedor", "Proveedor"));
            dgvOrdenes.TituloColumna_43BO("Fecha", T_14OR("pn2_col_emision", "Emision"));
            dgvOrdenes.TituloColumna_43BO("Estado_14OR", T_14OR("pn2_col_estado", "Estado"));
            dgvOrdenes.TituloColumna_43BO("Importe", T_14OR("pn2_col_importe", "Importe"));
            dgvDetalleOrden.TituloColumna_43BO("NombreProducto_14OR", T_14OR("pn2_col_producto", "Producto"));
            dgvDetalleOrden.TituloColumna_43BO("Cantidad_14OR", T_14OR("pn2_col_cantidad", "Cantidad"));
            dgvDetalleOrden.TituloColumna_43BO("CantidadRecibida_14OR", T_14OR("pn2_col_recibida", "Recibido"));
            dgvDetalleOrden.TituloColumna_43BO("PrecioCosto_14OR", T_14OR("pn2_col_preciocosto", "Precio costo"));
            dgvDetalleOrden.TituloColumna_43BO("Subtotal_14OR", T_14OR("pn2_col_subtotal", "Subtotal"));
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            if (IsDisposed) return;
            this.TraducirAuto_43BO(dic);
            this.Text = T_14OR("ordenescompra_titulo", "Ordenes de Compra");
            TraducirColumnas_14OR();
            dgvOrdenes.Invalidate();
            ActualizarProximoPaso_14OR();
        }
    }
}

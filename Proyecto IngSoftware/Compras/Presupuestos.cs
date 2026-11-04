using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Pantalla de presupuestos (cotizaciones) del PN2.
    // Izquierda: armar un nuevo pedido de cotizacion a un proveedor (productos + cantidades)
    // Derecha: lista de presupuestos; al elegir uno se cargan los precios que cotizo el proveedor
    // ("Recibido") y despues se acepta (genera la Orden de Compra "Abierta") o se rechaza.
    public partial class Presupuestos : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllProveedor_14OR bllProv = new BllProveedor_14OR();
        private BllProducto_14OR bllProd = new BllProducto_14OR();
        private BllPresupuesto_14OR bllPre = new BllPresupuesto_14OR();
        private BllOrdenCompra_14OR bllOrden = new BllOrdenCompra_14OR();

        // renglones del pedido que estoy armando (izquierda)
        private List<DetallePresupuesto_14OR> nuevoDetalle_14OR = new List<DetallePresupuesto_14OR>();

        // lista completa de productos (para sacar nombre/precio al agregar)
        private List<Producto_14OR> productos_14OR = new List<Producto_14OR>();

        // presupuesto seleccionado en la grilla de la derecha y sus renglones
        private Presupuesto_14OR presuSeleccionado_14OR = null;
        private List<DetallePresupuesto_14OR> detalleActual_14OR = new List<DetallePresupuesto_14OR>();

        // apra no ir a la base mientras se arma el form
        private bool cargado_14OR = false;

        public Presupuestos()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            this.Text = T_14OR("presupuestos_titulo", "Presupuestos / Cotizaciones");
            dgvPresupuestos.CellFormatting += Estado_CellFormatting_14OR;
            EstiloGrillas_14OR();
            CargarCombos_14OR();
            MostrarCriticos_14OR();
            CargarPresupuestos_14OR();
            RefrescarNuevoDetalle_14OR();
            ActualizarBotones_14OR();
            ActualizarTotal_14OR();
            cargado_14OR = true;
        }

        // ---- carga inicial ----

        private void CargarCombos_14OR()
        {
            try
            {
                var proveedores = bllProv.ListarProveedor_14OR();
                cboProveedor.DataSource = proveedores;
                cboProveedor.DisplayMember = "Nombre_14OR";
                cboProveedor.ValueMember = "IdProveedor_14OR";
                cboProveedor.SelectedIndex = proveedores.Count > 0 ? 0 : -1;

                productos_14OR = bllProd.ListarProducto_14OR();
                cboProducto.DataSource = productos_14OR;
                cboProducto.DisplayMember = "Nombre_14OR";
                cboProducto.ValueMember = "IdProducto_14OR";
                cboProducto.SelectedIndex = productos_14OR.Count > 0 ? 0 : -1;
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("presupuestos_msg_errorcombos", "No pude cargar proveedores/productos: ") + ex.Message, T_14OR("titulo_error", "Error"),
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // muestra como ayuda los productos que estan en stock critico (lo que conviene reponer)
        private void MostrarCriticos_14OR()
        {
            try
            {
                var criticos = bllProd.ListarEnCritico_14OR();
                if (criticos.Count == 0)
                {
                    lblCriticos.Text = T_14OR("presupuestos_msg_sincriticos", "No hay productos en stock critico ahora mismo.");
                }
                else
                {
                    lblCriticos.Text = T_14OR("presupuestos_msg_criticos", "Conviene reponer (stock critico): ") +
                        string.Join(", ", criticos.Select(p => p.Nombre_14OR + " (" + p.Stock_14OR + ")"));
                }
            }
            catch
            {
                lblCriticos.Text = "";
            }
        }

        private void CargarPresupuestos_14OR()
        {
            try
            {
                var lista = bllPre.Listar_14OR().Select(p => new
                {
                    p.IdPresupuesto_14OR,
                    p.NumeroPresupuesto_14OR,
                    p.IdProveedor_14OR,
                    p.NombreProveedor_14OR,
                    Fecha = p.FechaPedido_14OR.ToString("dd/MM/yyyy"),
                    p.Estado_14OR
                }).ToList();

                dgvPresupuestos.DataSource = lista;

                if (dgvPresupuestos.Columns.Count > 0)
                {
                    dgvPresupuestos.Columns["IdPresupuesto_14OR"].Visible = false;
                    dgvPresupuestos.Columns["IdProveedor_14OR"].Visible = false;
                    TraducirColumnas_14OR();
                    dgvPresupuestos.Columns["NumeroPresupuesto_14OR"].FillWeight = 25;
                    SeleccionarPresupuesto_14OR();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("presupuestos_msg_errorcargar", "No pude cargar los presupuestos: ") + ex.Message, T_14OR("titulo_error", "Error"),
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // al recargar la grilla vuelve a la primer fila, asi que marco de nuevo el que estaba elegido
        private void SeleccionarPresupuesto_14OR()
        {
            if (presuSeleccionado_14OR == null) return;

            foreach (DataGridViewRow fila in dgvPresupuestos.Rows)
            {
                if (Convert.ToInt32(fila.Cells["IdPresupuesto_14OR"].Value) == presuSeleccionado_14OR.IdPresupuesto_14OR)
                {
                    dgvPresupuestos.CurrentCell = fila.Cells["NumeroPresupuesto_14OR"];
                    return;
                }
            }
        }

        // ---- nuevo pedido (izquierda) ----

        // extension del CUN-006: si el proveedor no existe lo das de alta aca mismo (CUN-009).
        // pide la misma patente que el menu Compra -> Proveedores
        private void btnNuevoProveedor_Click(object sender, EventArgs e)
        {
            if (Servicios.SessionManager_43BO.Instancia.Permisos == null ||
                !Servicios.SessionManager_43BO.Instancia.Permisos.Contains("Compra_Proveedores_Acceso"))
            {
                MessageBox.Show(T_14OR("menu.msg_acceso_denegado", "Acceso denegado"), T_14OR("titulo_error", "Error"),
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            using (Proveedores frm = new Proveedores())
            {
                frm.StartPosition = FormStartPosition.CenterParent;
                frm.ShowDialog(this);
            }

            // recargo xq puede haber agregado o dado de baja alguno
            CargarCombos_14OR();
        }

        private void btnAgregarItem_Click(object sender, EventArgs e)
        {
            if (cboProducto.SelectedValue == null) return;

            int idProd = (int)cboProducto.SelectedValue;
            Producto_14OR prod = productos_14OR.FirstOrDefault(x => x.IdProducto_14OR == idProd);
            if (prod == null) return;

            int cant = (int)numCantidad.Value;
            if (cant <= 0) return;

            DetallePresupuesto_14OR existente = nuevoDetalle_14OR.FirstOrDefault(d => d.IdProducto_14OR == idProd);
            if (existente != null)
            {
                existente.Cantidad_14OR += cant;
            }
            else
            {
                DetallePresupuesto_14OR d = new DetallePresupuesto_14OR();
                d.IdProducto_14OR = idProd;
                d.NombreProducto_14OR = prod.Nombre_14OR;
                d.Cantidad_14OR = cant;
                d.PrecioCotizado_14OR = 0;
                nuevoDetalle_14OR.Add(d);
            }

            RefrescarNuevoDetalle_14OR();
        }

        private void btnQuitarItem_Click(object sender, EventArgs e)
        {
            if (dgvNuevoDetalle.CurrentRow == null) return;
            string nombre = dgvNuevoDetalle.CurrentRow.Cells["NombreProducto_14OR"].Value?.ToString();
            DetallePresupuesto_14OR d = nuevoDetalle_14OR.FirstOrDefault(x => x.NombreProducto_14OR == nombre);
            if (d != null) nuevoDetalle_14OR.Remove(d);
            RefrescarNuevoDetalle_14OR();
        }

        private void RefrescarNuevoDetalle_14OR()
        {
            var vista = nuevoDetalle_14OR.Select(d => new
            {
                d.NombreProducto_14OR,
                d.Cantidad_14OR
            }).ToList();

            dgvNuevoDetalle.DataSource = null;
            dgvNuevoDetalle.DataSource = vista;

            if (dgvNuevoDetalle.Columns.Count > 0)
            {
                TraducirColumnas_14OR();
            }
        }

        private void btnPedir_Click(object sender, EventArgs e)
        {
            if (cboProveedor.SelectedValue == null)
            {
                MessageBox.Show(T_14OR("Elegi un proveedor.", "Elegi un proveedor."), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (nuevoDetalle_14OR.Count == 0)
            {
                MessageBox.Show(T_14OR("Agrega al menos un producto para cotizar.", "Agrega al menos un producto para cotizar."), T_14OR("titulo_atencion", "Atencion"),
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                int idProv = (int)cboProveedor.SelectedValue;
                // le paso una copia de los renglones (asi no comparto la lista que despues limpio).
                // autocompleto el precoi cotizado con el costo de referencia del producto + una
                // pequena variacion segun el proveedor, asi la cotizacion arranca con un valor con
                // sentido (en vez de 0) y distintos proveedores cotizan un poco distinto. Es editable.
                List<DetallePresupuesto_14OR> copia = nuevoDetalle_14OR.Select(d => new DetallePresupuesto_14OR
                {
                    IdProducto_14OR = d.IdProducto_14OR,
                    NombreProducto_14OR = d.NombreProducto_14OR,
                    Cantidad_14OR = d.Cantidad_14OR,
                    PrecioCotizado_14OR = SugerirPrecio_14OR(d.IdProducto_14OR, idProv)
                }).ToList();

                int id = bllPre.PedirPresupuesto_14OR(idProv, copia);

                MessageBox.Show(string.Format(T_14OR("presupuestos_msg_pedido", "Presupuesto N° {0} pedido al proveedor. Cuando te pase los precios, selecciónalo en la lista y cargalos."), id), T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);

                nuevoDetalle_14OR.Clear();
                RefrescarNuevoDetalle_14OR();
                CargarPresupuestos_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        // precio cotizado suegrido: costo de referencia del producto + un recargo chico segun el
        // proveedor (0% a 19%, estable para el mismo proveedor). Si el producto no tiene costo
        // cargado devuelve 0, y el vendedor lo completa a mano.
        private double SugerirPrecio_14OR(int idProducto, int idProveedor)
        {
            Producto_14OR prod = productos_14OR.FirstOrDefault(x => x.IdProducto_14OR == idProducto);
            if (prod == null || prod.PrecioCosto_14OR <= 0) return 0;

            double recargo = 1.0 + ((idProveedor * 7) % 20) / 100.0; // entre 1.00 y 1.19
            return Math.Round(prod.PrecioCosto_14OR * recargo, 2);
        }

        // ---- presupuesto seleccionado (derecha) ----

        private void dgvPresupuestos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvPresupuestos.CurrentRow == null) return;

            int id = Convert.ToInt32(dgvPresupuestos.CurrentRow.Cells["IdPresupuesto_14OR"].Value);
            string estado = dgvPresupuestos.CurrentRow.Cells["Estado_14OR"].Value.ToString();

            presuSeleccionado_14OR = new Presupuesto_14OR();
            presuSeleccionado_14OR.IdPresupuesto_14OR = id;
            // sin esto la orden se generaba cn proveedor 0 y saltaba la FK
            presuSeleccionado_14OR.IdProveedor_14OR = Convert.ToInt32(dgvPresupuestos.CurrentRow.Cells["IdProveedor_14OR"].Value);
            presuSeleccionado_14OR.Estado_14OR = estado;

            detalleActual_14OR = bllPre.ObtenerDetalle_14OR(id);
            MostrarDetalle_14OR();
            ActualizarBotones_14OR();
        }

        private void MostrarDetalle_14OR()
        {
            dgvDetalle.DataSource = null;
            dgvDetalle.DataSource = detalleActual_14OR;

            if (dgvDetalle.Columns.Count > 0)
            {
                dgvDetalle.Columns["IdDetallePresupuesto_14OR"].Visible = false;
                dgvDetalle.Columns["IdPresupuesto_14OR"].Visible = false;
                dgvDetalle.Columns["IdProducto_14OR"].Visible = false;
                dgvDetalle.Columns["Subtotal_14OR"].Visible = false;
                TraducirColumnas_14OR();
                dgvDetalle.Columns["NombreProducto_14OR"].ReadOnly = true;
                dgvDetalle.Columns["Cantidad_14OR"].ReadOnly = true;
                dgvDetalle.Columns["PrecioCotizado_14OR"].DefaultCellStyle.Format = "0.00";
                // el precio solo se puede editar si el presupuesto todavia no fue aceptado/rechazado
                bool editable = presuSeleccionado_14OR != null &&
                    (presuSeleccionado_14OR.Estado_14OR == Presupuesto_14OR.EstadoPedido_14OR ||
                     presuSeleccionado_14OR.Estado_14OR == Presupuesto_14OR.EstadoRecibido_14OR);
                dgvDetalle.Columns["PrecioCotizado_14OR"].ReadOnly = !editable;
            }

            ActualizarTotal_14OR();
        }

        private void ActualizarTotal_14OR()
        {
            double total = detalleActual_14OR.Sum(d => d.Subtotal_14OR);
            lblTotalPresu.Text = T_14OR("presupuestos_lbltotal", "Total cotizado: $ ") + total.ToString("0.00");
        }

        private void dgvDetalle_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            // al terminar de editar un precio, recalculo el total (los objetos ya quedaron actualizados)
            ActualizarTotal_14OR();
        }

        private void btnCargarPrecios_Click(object sender, EventArgs e)
        {
            if (presuSeleccionado_14OR == null) return;

            try
            {
                // obligo a confirmar la edicion en curso de la grilla
                dgvDetalle.EndEdit();

                presuSeleccionado_14OR.Detalles = detalleActual_14OR;
                bllPre.CargarCotizacion_14OR(presuSeleccionado_14OR);

                MessageBox.Show(T_14OR("presupuestos_msg_precios", "Precios cargados. El presupuesto quedo en 'Recibido' y ya se puede aceptar."),
                    T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);

                presuSeleccionado_14OR.Estado_14OR = Presupuesto_14OR.EstadoRecibido_14OR;
                CargarPresupuestos_14OR();
                MostrarDetalle_14OR();
                ActualizarBotones_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            if (presuSeleccionado_14OR == null) return;

            if (MessageBox.Show(T_14OR("presupuestos_msg_confirmaraceptar", "Aceptar este presupuesto y generar la orden de compra?"),
                T_14OR("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes)
                return;

            try
            {
                int idOrden = bllOrden.GenerarDesdePresupuesto_14OR(presuSeleccionado_14OR);

                MessageBox.Show(string.Format(T_14OR("presupuestos_msg_ordengenerada", "Orden de compra N° {0} generada en estado 'Abierta'.\nLa podes ver y pagar desde Compra > Ordenes de Compra."), idOrden),
                    T_14OR("presupuestos_tit_ordengenerada", "Orden generada"), MessageBoxButtons.OK, MessageBoxIcon.Information);

                CargarPresupuestos_14OR();
                detalleActual_14OR = new List<DetallePresupuesto_14OR>();
                presuSeleccionado_14OR = null;
                dgvDetalle.DataSource = null;
                ActualizarTotal_14OR();
                ActualizarBotones_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnRechazar_Click(object sender, EventArgs e)
        {
            if (presuSeleccionado_14OR == null) return;

            if (MessageBox.Show(T_14OR("presupuestos_msg_confirmarrechazar", "Rechazar este presupuesto?"),
                T_14OR("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes)
                return;

            try
            {
                bllPre.Rechazar_14OR(presuSeleccionado_14OR.IdPresupuesto_14OR);
                CargarPresupuestos_14OR();
                detalleActual_14OR = new List<DetallePresupuesto_14OR>();
                presuSeleccionado_14OR = null;
                dgvDetalle.DataSource = null;
                ActualizarTotal_14OR();
                ActualizarBotones_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        // habilita/deshabilita los botones de la derecha segun el estado del presupuesto elegido
        private void ActualizarBotones_14OR()
        {
            bool hay = presuSeleccionado_14OR != null;
            string est = hay ? presuSeleccionado_14OR.Estado_14OR : "";

            btnCargarPrecios.Enabled = hay && (est == Presupuesto_14OR.EstadoPedido_14OR || est == Presupuesto_14OR.EstadoRecibido_14OR);
            btnAceptar.Enabled = hay && est == Presupuesto_14OR.EstadoRecibido_14OR;
            btnRechazar.Enabled = hay && (est == Presupuesto_14OR.EstadoPedido_14OR || est == Presupuesto_14OR.EstadoRecibido_14OR);
        }

        private void EstiloGrillas_14OR()
        {
            foreach (DataGridView dgv in new[] { dgvNuevoDetalle, dgvPresupuestos, dgvDetalle })
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
                dgv.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(46, 46, 46);
                dgv.ColumnHeadersDefaultCellStyle.ForeColor = Color.Gainsboro;
                dgv.ColumnHeadersDefaultCellStyle.SelectionBackColor = Color.FromArgb(46, 46, 46);
                dgv.DefaultCellStyle.BackColor = Color.FromArgb(36, 36, 36);
                dgv.DefaultCellStyle.ForeColor = Color.Gainsboro;
                dgv.DefaultCellStyle.SelectionBackColor = Color.FromArgb(18, 58, 94);
                dgv.DefaultCellStyle.SelectionForeColor = Color.White;
            }
            // la grilla de detalle permite editar (el precio); las otras no
            dgvNuevoDetalle.ReadOnly = true;
            dgvPresupuestos.ReadOnly = true;
            dgvDetalle.ReadOnly = false;
        }

        // atajo pa traducir cn el idioma actual, si falta la clave usa el texto x defecto
        private string T_14OR(string clave, string porDefecto)
        {
            return GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(clave, porDefecto);
        }

        // muestro el estado traducido en la grila pero el valor real de la celda no lo toco
        private void Estado_CellFormatting_14OR(object sender, DataGridViewCellFormattingEventArgs e)
        {
            DataGridView dgv = (DataGridView)sender;
            if (e.RowIndex < 0 || e.Value == null) return;
            if (dgv.Columns[e.ColumnIndex].Name != "Estado_14OR") return;
            string estado = e.Value.ToString();
            e.Value = T_14OR("estado_" + estado.ToLower(), estado);
            e.FormattingApplied = true;
        }

        private void TraducirColumnas_14OR()
        {
            dgvPresupuestos.TituloColumna_43BO("NumeroPresupuesto_14OR", T_14OR("pn2_col_numero", "N°"));
            dgvPresupuestos.TituloColumna_43BO("NombreProveedor_14OR", T_14OR("pn2_col_proveedor", "Proveedor"));
            dgvPresupuestos.TituloColumna_43BO("Fecha", T_14OR("pn2_col_fecha", "Fecha"));
            dgvPresupuestos.TituloColumna_43BO("Estado_14OR", T_14OR("pn2_col_estado", "Estado"));
            dgvNuevoDetalle.TituloColumna_43BO("NombreProducto_14OR", T_14OR("pn2_col_producto", "Producto"));
            dgvNuevoDetalle.TituloColumna_43BO("Cantidad_14OR", T_14OR("pn2_col_cantidad", "Cantidad"));
            dgvDetalle.TituloColumna_43BO("NombreProducto_14OR", T_14OR("pn2_col_producto", "Producto"));
            dgvDetalle.TituloColumna_43BO("Cantidad_14OR", T_14OR("pn2_col_cantidad", "Cantidad"));
            dgvDetalle.TituloColumna_43BO("PrecioCotizado_14OR", T_14OR("pn2_col_preciocotizado", "Precio cotizado"));
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            if (IsDisposed) return;
            this.TraducirAuto_43BO(dic);
            this.Text = T_14OR("presupuestos_titulo", "Presupuestos / Cotizaciones");
            TraducirColumnas_14OR();
            dgvPresupuestos.Invalidate();
            if (!cargado_14OR) return;
            MostrarCriticos_14OR();
            ActualizarTotal_14OR();
        }
    }
}

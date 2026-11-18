using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Pantalla de cotizaciones del PN2 (en la base la tabla sigue llamandose Presupuesto).
    // Izquierda: solicitar cotizacion a un proveedor (productos + cantidades) -> queda "Solicitada"
    // Derecha: lista de cotizaciones (Pendientes / Historial). Al elegir una se cargan los precios
    // que paso el proveedor ("Registrar cotizacion" -> "Cotizada") y despues se compra
    // ("Comprar insumos" genera la Orden de Compra "Abierta") o se rechaza.
    // Abajo un cartel dice cual es el proximo paso segun el estado de la cotizacion elegida.
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
            this.Text = T_14OR("presupuestos_titulo", "Cotizaciones");
            dgvPresupuestos.CellFormatting += Estado_CellFormatting_14OR;
            // eventos del detalle: que no reviente si escriben cualquier cosa en el precio
            dgvDetalle.DataError += Detalle_DataError_14OR;
            dgvDetalle.CellParsing += Detalle_CellParsing_14OR;
            dgvDetalle.CellFormatting += Detalle_CellFormatting_14OR;
            // al cargar la grilla windows marca sola la primer fila, la desmarco si no elegi nada
            dgvPresupuestos.DataBindingComplete += (o, ev) => { if (presuSeleccionado_14OR == null) { dgvPresupuestos.ClearSelection(); dgvPresupuestos.CurrentCell = null; } };
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
                // pendientes = solicitadas y cotizadas; historial = compradas y rechazadas
                var lista = bllPre.ListarPorVista_14OR(rbPendientes.Checked).Select(p => new
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

        // al recargar la grilla vuelve a la primer fila, asi que marco de nuevo el que estaba elegido.
        // si no habia ninguno elegido (o ya no esta en esta vista) no dejo nada marcado, asi no
        // parece que hay una cotizacion seleccionada cuando en realidad no
        private void SeleccionarPresupuesto_14OR()
        {
            if (presuSeleccionado_14OR != null)
            {
                foreach (DataGridViewRow fila in dgvPresupuestos.Rows)
                {
                    if (Convert.ToInt32(fila.Cells["IdPresupuesto_14OR"].Value) == presuSeleccionado_14OR.IdPresupuesto_14OR)
                    {
                        dgvPresupuestos.CurrentCell = fila.Cells["NumeroPresupuesto_14OR"];
                        return;
                    }
                }
            }

            dgvPresupuestos.ClearSelection();
            dgvPresupuestos.CurrentCell = null;
            LimpiarSeleccion_14OR();
        }

        private void LimpiarSeleccion_14OR()
        {
            presuSeleccionado_14OR = null;
            detalleActual_14OR = new List<DetallePresupuesto_14OR>();
            dgvDetalle.DataSource = null;
            ActualizarTotal_14OR();
            ActualizarBotones_14OR();
        }

        // marca y muestra una cotizacion puntual (la uso despues de solicitar una nueva)
        private void ElegirPresupuesto_14OR(int id)
        {
            foreach (DataGridViewRow fila in dgvPresupuestos.Rows)
            {
                if (Convert.ToInt32(fila.Cells["IdPresupuesto_14OR"].Value) == id)
                {
                    dgvPresupuestos.CurrentCell = fila.Cells["NumeroPresupuesto_14OR"];
                    dgvPresupuestos_CellClick(dgvPresupuestos, new DataGridViewCellEventArgs(0, fila.Index));
                    return;
                }
            }
        }

        // cambio entre Pendientes e Historial
        private void rbFiltro_CheckedChanged(object sender, EventArgs e)
        {
            if (!cargado_14OR || !((RadioButton)sender).Checked) return;
            presuSeleccionado_14OR = null;
            CargarPresupuestos_14OR();
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
                // el precio arranca vacio: lo carga el supervisor cuando el proveedor le pasa la cotizacion
                List<DetallePresupuesto_14OR> copia = nuevoDetalle_14OR.Select(d => new DetallePresupuesto_14OR
                {
                    IdProducto_14OR = d.IdProducto_14OR,
                    NombreProducto_14OR = d.NombreProducto_14OR,
                    Cantidad_14OR = d.Cantidad_14OR,
                    PrecioCotizado_14OR = 0
                }).ToList();

                int id = bllPre.PedirPresupuesto_14OR(idProv, copia);

                MessageBox.Show(string.Format(T_14OR("presupuestos_msg_pedido", "Solicitud de cotizacion N° {0} registrada. Cuando el proveedor te pase los precios, cargalos en el detalle y toca 'Registrar cotizacion'."), id), T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);

                nuevoDetalle_14OR.Clear();
                RefrescarNuevoDetalle_14OR();

                // la dejo elegida en Pendientes pa que se vea el siguiente paso
                presuSeleccionado_14OR = null;
                if (!rbPendientes.Checked) rbPendientes.Checked = true; else CargarPresupuestos_14OR();
                ElegirPresupuesto_14OR(id);
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
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

                // la columna donde se escribe el precio la marco distinta y con un titulo que lo diga
                DataGridViewColumn colPrecio = dgvDetalle.Columns["PrecioCotizado_14OR"];
                colPrecio.DefaultCellStyle.BackColor = editable ? Color.FromArgb(52, 58, 72) : Color.FromArgb(36, 36, 36);
                colPrecio.DefaultCellStyle.ForeColor = editable ? Color.White : Color.Gainsboro;
                colPrecio.HeaderText = editable
                    ? T_14OR("presupuestos_col_precioeditable", "Precio que pasó el proveedor (escribilo acá)")
                    : T_14OR("pn2_col_preciocotizado", "Precio cotizado");

                // si todavia no tiene precios dejo el cursor parado en el primer precio pa escribir directo
                if (editable && dgvDetalle.Rows.Count > 0)
                    dgvDetalle.CurrentCell = dgvDetalle.Rows[0].Cells["PrecioCotizado_14OR"];
            }

            ActualizarTotal_14OR();
        }

        // si escriben letras o simbolos en el precio aviso en criollo en vez del cartel feo de windows
        private void Detalle_DataError_14OR(object sender, DataGridViewDataErrorEventArgs e)
        {
            MessageBox.Show(T_14OR("presupuestos_msg_precioinvalido", "En el precio escribí solo números, por ejemplo 1500 o 1500,50."),
                T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            e.Cancel = true;
        }

        // si dejan el precio vacio lo tomo como 0 (despues la bll avisa que falta)
        private void Detalle_CellParsing_14OR(object sender, DataGridViewCellParsingEventArgs e)
        {
            if (dgvDetalle.Columns[e.ColumnIndex].Name != "PrecioCotizado_14OR") return;
            if (e.Value == null || string.IsNullOrWhiteSpace(e.Value.ToString()))
            {
                e.Value = 0.0;
                e.ParsingApplied = true;
            }
        }

        // un precio en 0 lo muestro vacio, asi se nota que falta cargarlo
        private void Detalle_CellFormatting_14OR(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (e.RowIndex < 0 || e.Value == null) return;
            if (dgvDetalle.Columns[e.ColumnIndex].Name != "PrecioCotizado_14OR") return;
            double v;
            if (double.TryParse(e.Value.ToString(), out v) && v == 0)
            {
                e.Value = "";
                e.FormattingApplied = true;
            }
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

                MessageBox.Show(T_14OR("presupuestos_msg_precios", "Cotizacion registrada. Ahora podes comprar los insumos (genera la orden de compra) o rechazarla."),
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

            if (MessageBox.Show(T_14OR("presupuestos_msg_confirmaraceptar", "Comprar los insumos de esta cotizacion? Se genera la orden de compra."),
                T_14OR("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes)
                return;

            try
            {
                int idOrden = bllOrden.GenerarDesdePresupuesto_14OR(presuSeleccionado_14OR);

                MessageBox.Show(string.Format(T_14OR("presupuestos_msg_ordengenerada", "Orden de compra N° {0} generada en estado 'Abierta'.\nLa podes ver y pagar desde Compra > Ordenes de Compra."), idOrden),
                    T_14OR("presupuestos_tit_ordengenerada", "Orden generada"), MessageBoxButtons.OK, MessageBoxIcon.Information);

                // ya no esta pendiente: sale de la lista (queda en Historial)
                presuSeleccionado_14OR = null;
                CargarPresupuestos_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR(ex.Message, ex.Message), T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnRechazar_Click(object sender, EventArgs e)
        {
            if (presuSeleccionado_14OR == null) return;

            if (MessageBox.Show(T_14OR("presupuestos_msg_confirmarrechazar", "Rechazar esta cotizacion? No se genera orden de compra."),
                T_14OR("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes)
                return;

            try
            {
                bllPre.Rechazar_14OR(presuSeleccionado_14OR.IdPresupuesto_14OR);
                MessageBox.Show(T_14OR("presupuestos_msg_rechazada", "Cotizacion rechazada. Ya no aparece en Pendientes; la podes ver en Historial."),
                    T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);

                presuSeleccionado_14OR = null;
                CargarPresupuestos_14OR();
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
            ActualizarProximoPaso_14OR();
        }

        // cartel que explica que hay que hacer con la cotizacion elegida
        private void ActualizarProximoPaso_14OR()
        {
            string est = presuSeleccionado_14OR != null ? presuSeleccionado_14OR.Estado_14OR : "";

            if (est == Presupuesto_14OR.EstadoPedido_14OR)
                lblProximoPaso.Text = T_14OR("presupuestos_paso_pedido", "Proximo paso: cuando el proveedor te pase los precios, escribi el precio unitario de cada producto en el detalle y toca 'Registrar cotizacion'.");
            else if (est == Presupuesto_14OR.EstadoRecibido_14OR)
                lblProximoPaso.Text = T_14OR("presupuestos_paso_recibido", "Proximo paso: revisa los precios. Si te conviene toca 'Comprar insumos' (genera la orden de compra); si no, 'Rechazar'.");
            else if (est == Presupuesto_14OR.EstadoAceptado_14OR)
                lblProximoPaso.Text = T_14OR("presupuestos_paso_aceptado", "Esta cotizacion ya genero su orden de compra. Segui en Compra > Ordenes de Compra (pagar y recibir la mercaderia).");
            else if (est == Presupuesto_14OR.EstadoRechazado_14OR)
                lblProximoPaso.Text = T_14OR("presupuestos_paso_rechazado", "Esta cotizacion fue rechazada, no genero orden de compra. Queda solo como registro.");
            else
                lblProximoPaso.Text = T_14OR("presupuestos_paso_ninguno", "Elegi una cotizacion de la lista para ver su detalle y el proximo paso, o arma una nueva solicitud a la izquierda.");
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

            // cada estado con su color pa ubicarlo de un vistazo
            if (estado == Presupuesto_14OR.EstadoPedido_14OR) e.CellStyle.ForeColor = Color.FromArgb(231, 168, 26);
            else if (estado == Presupuesto_14OR.EstadoRecibido_14OR) e.CellStyle.ForeColor = Color.FromArgb(120, 170, 230);
            else if (estado == Presupuesto_14OR.EstadoAceptado_14OR) e.CellStyle.ForeColor = Color.FromArgb(90, 190, 120);
            else if (estado == Presupuesto_14OR.EstadoRechazado_14OR) e.CellStyle.ForeColor = Color.FromArgb(220, 90, 90);

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
            this.Text = T_14OR("presupuestos_titulo", "Cotizaciones");
            TraducirColumnas_14OR();
            dgvPresupuestos.Invalidate();
            if (!cargado_14OR) return;
            MostrarCriticos_14OR();
            ActualizarTotal_14OR();
            ActualizarProximoPaso_14OR();
        }
    }
}

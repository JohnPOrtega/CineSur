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

        public Presupuestos()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            EstiloGrillas_14OR();
            CargarCombos_14OR();
            MostrarCriticos_14OR();
            CargarPresupuestos_14OR();
            RefrescarNuevoDetalle_14OR();
            ActualizarBotones_14OR();
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
                MessageBox.Show("No pude cargar proveedores/productos: " + ex.Message, "Error",
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
                    lblCriticos.Text = "No hay productos en stock critico ahora mismo.";
                }
                else
                {
                    lblCriticos.Text = "Conviene reponer (stock critico): " +
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
                    p.NombreProveedor_14OR,
                    Fecha = p.FechaPedido_14OR.ToString("dd/MM/yyyy"),
                    p.Estado_14OR
                }).ToList();

                dgvPresupuestos.DataSource = lista;

                if (dgvPresupuestos.Columns.Count > 0)
                {
                    dgvPresupuestos.Columns["IdPresupuesto_14OR"].Visible = false;
                    dgvPresupuestos.Columns["NumeroPresupuesto_14OR"].HeaderText = "N°";
                    dgvPresupuestos.Columns["NombreProveedor_14OR"].HeaderText = "Proveedor";
                    dgvPresupuestos.Columns["Fecha"].HeaderText = "Fecha";
                    dgvPresupuestos.Columns["Estado_14OR"].HeaderText = "Estado";
                    dgvPresupuestos.Columns["NumeroPresupuesto_14OR"].FillWeight = 25;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar los presupuestos: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // ---- nuevo pedido (izquierda) ----

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
                dgvNuevoDetalle.Columns["NombreProducto_14OR"].HeaderText = "Producto";
                dgvNuevoDetalle.Columns["Cantidad_14OR"].HeaderText = "Cantidad";
            }
        }

        private void btnPedir_Click(object sender, EventArgs e)
        {
            if (cboProveedor.SelectedValue == null)
            {
                MessageBox.Show("Elegi un proveedor.", "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (nuevoDetalle_14OR.Count == 0)
            {
                MessageBox.Show("Agrega al menos un producto para cotizar.", "Atencion",
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

                MessageBox.Show("Presupuesto N° " + id + " pedido al proveedor. Cuando te pase los precios, " +
                    "selecciónalo en la lista y cargalos.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);

                nuevoDetalle_14OR.Clear();
                RefrescarNuevoDetalle_14OR();
                CargarPresupuestos_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                dgvDetalle.Columns["NombreProducto_14OR"].HeaderText = "Producto";
                dgvDetalle.Columns["NombreProducto_14OR"].ReadOnly = true;
                dgvDetalle.Columns["Cantidad_14OR"].HeaderText = "Cantidad";
                dgvDetalle.Columns["Cantidad_14OR"].ReadOnly = true;
                dgvDetalle.Columns["PrecioCotizado_14OR"].HeaderText = "Precio cotizado";
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
            lblTotalPresu.Text = "Total cotizado: $ " + total.ToString("0.00");
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

                MessageBox.Show("Precios cargados. El presupuesto quedo en 'Recibido' y ya se puede aceptar.",
                    "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);

                presuSeleccionado_14OR.Estado_14OR = Presupuesto_14OR.EstadoRecibido_14OR;
                CargarPresupuestos_14OR();
                MostrarDetalle_14OR();
                ActualizarBotones_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            if (presuSeleccionado_14OR == null) return;

            if (MessageBox.Show("Aceptar este presupuesto y generar la orden de compra?",
                "Confirmar", MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes)
                return;

            try
            {
                int idOrden = bllOrden.GenerarDesdePresupuesto_14OR(presuSeleccionado_14OR);

                MessageBox.Show("Orden de compra N° " + idOrden + " generada en estado 'Abierta'.\n" +
                    "La podes ver y pagar desde Compra > Ordenes de Compra.",
                    "Orden generada", MessageBoxButtons.OK, MessageBoxIcon.Information);

                CargarPresupuestos_14OR();
                detalleActual_14OR = new List<DetallePresupuesto_14OR>();
                presuSeleccionado_14OR = null;
                dgvDetalle.DataSource = null;
                lblTotalPresu.Text = "Total cotizado: $ 0.00";
                ActualizarBotones_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnRechazar_Click(object sender, EventArgs e)
        {
            if (presuSeleccionado_14OR == null) return;

            if (MessageBox.Show("Rechazar este presupuesto?",
                "Confirmar", MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes)
                return;

            try
            {
                bllPre.Rechazar_14OR(presuSeleccionado_14OR.IdPresupuesto_14OR);
                CargarPresupuestos_14OR();
                detalleActual_14OR = new List<DetallePresupuesto_14OR>();
                presuSeleccionado_14OR = null;
                dgvDetalle.DataSource = null;
                lblTotalPresu.Text = "Total cotizado: $ 0.00";
                ActualizarBotones_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
    }
}

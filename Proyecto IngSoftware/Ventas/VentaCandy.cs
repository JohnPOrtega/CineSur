using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Pantalla de venta del Candy Bar (POS). Muestra los productos como tarjetas con imagen
    // (estilo Cartelera), arma el "Pedido actual" a la izquierda y cobra con Efectivo o Tarjeta
    // reutilizando la misma validacion que la venta de entradas. Al cobrar, descuenta stock.
    public partial class VentaCandy : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllProducto_14OR bllProd = new BllProducto_14OR();
        private BllVentaCandy_14OR bllVentaCandy = new BllVentaCandy_14OR();
        private BllVenta_14OR bllVenta = new BllVenta_14OR();   // lo uso solo para ValidarTarjeta_14OR

        // el pedido actual (carrito): un renglon por producto
        private List<DetalleVentaCandy_14OR> carrito = new List<DetalleVentaCandy_14OR>();

        // carpeta donde se guardan las imagenes de los productos (al lado del exe)
        private const string CARPETA_IMAGENES_14OR = "ProductosCandy";

        // apra no ir a la base mientras se arma el form
        private bool cargado_14OR = false;

        public VentaCandy()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            this.Text = T_14OR("ventacandy_titulo", "Venta Candy Bar");
            CargarProductos_14OR();
            RefrescarPedido_14OR();
            Actualizar_14OR(null, null);
            cargado_14OR = true;
        }

        // ---- tarjetas de productos ----

        private void CargarProductos_14OR()
        {
            flpProductos.Controls.Clear();

            try
            {
                List<Producto_14OR> productos = bllProd.ListarProducto_14OR();

                if (productos.Count == 0)
                {
                    Label vacio = new Label();
                    vacio.Text = T_14OR("ventacandy_msg_sinproductos", "No hay productos cargados. Cargalos desde Compra > Productos.");
                    vacio.ForeColor = Color.Gainsboro;
                    vacio.Font = new Font("Segoe UI", 11F);
                    vacio.AutoSize = true;
                    flpProductos.Controls.Add(vacio);
                    return;
                }

                foreach (Producto_14OR p in productos)
                    flpProductos.Controls.Add(ArmarTarjeta_14OR(p));
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("ventacandy_msg_errorcargar", "No pude cargar los productos: ") + ex.Message, T_14OR("titulo_error", "Error"),
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private Panel ArmarTarjeta_14OR(Producto_14OR p)
        {
            Panel card = new Panel();
            card.Size = new Size(150, 180);
            card.Margin = new Padding(8);
            card.BackColor = Color.FromArgb(36, 39, 48);
            card.Cursor = Cursors.Hand;

            PictureBox pic = new PictureBox();
            pic.Size = new Size(150, 100);
            pic.Location = new Point(0, 0);
            pic.SizeMode = PictureBoxSizeMode.Zoom;
            pic.BackColor = Color.FromArgb(50, 54, 66);
            CargarImagen_14OR(pic, p.Imagen_14OR);
            card.Controls.Add(pic);

            Label lblNom = new Label();
            lblNom.Text = p.Nombre_14OR;
            lblNom.ForeColor = Color.White;
            lblNom.Font = new Font("Segoe UI", 9F, FontStyle.Bold);
            lblNom.Location = new Point(6, 104);
            lblNom.Size = new Size(138, 34);
            card.Controls.Add(lblNom);

            Label lblPrecio = new Label();
            lblPrecio.Text = "$ " + p.PrecioVenta_14OR.ToString("0.00");
            lblPrecio.ForeColor = Color.FromArgb(120, 200, 130);
            lblPrecio.Font = new Font("Segoe UI", 10F, FontStyle.Bold);
            lblPrecio.Location = new Point(6, 140);
            lblPrecio.Size = new Size(90, 18);
            card.Controls.Add(lblPrecio);

            Label lblStock = new Label();
            lblStock.Text = T_14OR("ventacandy_stock", "Stock: ") + p.Stock_14OR;
            // si esta en o por debajo del critico lo marco en rojo
            lblStock.ForeColor = (p.Stock_14OR <= p.StockCritico_14OR)
                ? Color.FromArgb(220, 120, 120) : Color.Gainsboro;
            lblStock.Font = new Font("Segoe UI", 8F);
            lblStock.Location = new Point(6, 160);
            lblStock.Size = new Size(138, 16);
            card.Controls.Add(lblStock);

            // click en la tarjeta (y en sus hijos) agrega una unidad al pedido
            EventHandler agregar = (s, e) => AgregarAlPedido_14OR(p);
            card.Click += agregar;
            foreach (Control hijo in card.Controls)
                hijo.Click += agregar;

            return card;
        }

        private void CargarImagen_14OR(PictureBox pic, string archivo)
        {
            if (string.IsNullOrEmpty(archivo)) return;
            try
            {
                string ruta = Path.Combine(Application.StartupPath, CARPETA_IMAGENES_14OR, archivo);
                if (File.Exists(ruta))
                {
                    using (var fs = new FileStream(ruta, FileMode.Open, FileAccess.Read))
                    {
                        pic.Image = Image.FromStream(fs);
                    }
                }
            }
            catch
            {
                // si la imagen esta rota no pasa nada queda el fondo
            }
        }

        // ---- pedido actual (carrito) ----

        private void AgregarAlPedido_14OR(Producto_14OR p)
        {
            DetalleVentaCandy_14OR renglon = carrito.FirstOrDefault(d => d.IdProducto_14OR == p.IdProducto_14OR);

            int cantidadActual = renglon != null ? renglon.Cantidad_14OR : 0;

            // no dejo cargar mas unidades de las que hay en stock
            if (cantidadActual + 1 > p.Stock_14OR)
            {
                MessageBox.Show(string.Format(T_14OR("ventacandy_msg_sinstock", "No hay mas stock de {0}."), p.Nombre_14OR), T_14OR("titulo_atencion", "Atencion"),
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (renglon == null)
            {
                renglon = new DetalleVentaCandy_14OR();
                renglon.IdProducto_14OR = p.IdProducto_14OR;
                renglon.NombreProducto_14OR = p.Nombre_14OR;
                renglon.PrecioUnitario_14OR = p.PrecioVenta_14OR;
                renglon.Cantidad_14OR = 1;
                carrito.Add(renglon);
            }
            else
            {
                renglon.Cantidad_14OR++;
            }

            RefrescarPedido_14OR();
        }

        private void RefrescarPedido_14OR()
        {
            var vista = carrito.Select(d => new
            {
                d.NombreProducto_14OR,
                d.Cantidad_14OR,
                Subtotal = d.Subtotal_14OR
            }).ToList();

            dgvPedido.DataSource = null;
            dgvPedido.DataSource = vista;

            if (dgvPedido.Columns.Count > 0)
            {
                TraducirColumnas_14OR();
                dgvPedido.Columns["Cantidad_14OR"].FillWeight = 35;
                dgvPedido.Columns["Subtotal"].FillWeight = 45;
                dgvPedido.Columns["Subtotal"].DefaultCellStyle.Format = "0.00";
            }

            Actualizar_14OR(null, null);
        }

        private double TotalPedido_14OR()
        {
            return carrito.Sum(d => d.Subtotal_14OR);
        }

        // saca una unidad del renglon seleccionado (si queda en 0, lo elimina)
        private void btnQuitarUno_Click(object sender, EventArgs e)
        {
            DetalleVentaCandy_14OR r = RenglonSeleccionado_14OR();
            if (r == null) return;

            r.Cantidad_14OR--;
            if (r.Cantidad_14OR <= 0)
                carrito.Remove(r);

            RefrescarPedido_14OR();
        }

        // elimina el renglon seleccionado completo
        private void btnEliminar_Click(object sender, EventArgs e)
        {
            DetalleVentaCandy_14OR r = RenglonSeleccionado_14OR();
            if (r == null) return;

            carrito.Remove(r);
            RefrescarPedido_14OR();
        }

        private DetalleVentaCandy_14OR RenglonSeleccionado_14OR()
        {
            if (dgvPedido.CurrentRow == null) return null;
            string nombre = dgvPedido.CurrentRow.Cells["NombreProducto_14OR"].Value?.ToString();
            return carrito.FirstOrDefault(d => d.NombreProducto_14OR == nombre);
        }

        // ---- cobro (copiado de la venta de entradas) ----

        private void Actualizar_14OR(object sender, EventArgs e)
        {
            double total = TotalPedido_14OR();
            lblTotal.Text = T_14OR("ventacandy_lbltotal", "Total: $ ") + total.ToString("0.00");

            panelEfectivo.Visible = rbEfectivo.Checked;
            panelTarjeta.Visible = rbTarjeta.Checked;

            if (rbEfectivo.Checked)
                CalcularVuelto_14OR();
        }

        private void CalcularVuelto_14OR()
        {
            double total = TotalPedido_14OR();
            double paga;
            if (double.TryParse(txtPaga.Text, out paga) && paga >= total)
            {
                lblVuelto.Text = T_14OR("ventacandy_lblvuelto", "Vuelto: $ ") + (paga - total).ToString("0.00");
                lblVuelto.ForeColor = Color.FromArgb(120, 200, 130);
            }
            else
            {
                lblVuelto.Text = T_14OR("ventacandy_lblvuelto", "Vuelto: $ ") + "0.00";
                lblVuelto.ForeColor = Color.FromArgb(200, 120, 120);
            }
        }

        private void btnCobrar_Click(object sender, EventArgs e)
        {
            var g = GestorIdioma_43BO.Instancia;

            if (carrito.Count == 0)
            {
                MessageBox.Show(T_14OR("ventacandy_msg_pedidovacio", "El pedido esta vacio. Agrega productos tocando las tarjetas."), T_14OR("titulo_atencion", "Atencion"),
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            double total = TotalPedido_14OR();
            string metodo = rbEfectivo.Checked ? "Efectivo" : "Tarjeta";

            if (rbEfectivo.Checked)
            {
                double paga;
                if (!double.TryParse(txtPaga.Text, out paga))
                {
                    MessageBox.Show(T_14OR("ventacandy_msg_faltapaga", "Ingresa con cuanto paga el cliente."), T_14OR("titulo_atencion", "Atencion"),
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                if (paga < total)
                {
                    MessageBox.Show(T_14OR("ventacandy_msg_noalcanza", "El monto con el que paga no alcanza para cubrir el total."), T_14OR("titulo_atencion", "Atencion"),
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
            else
            {
                // misma validacion de tarjeta que la venta de entradas (formato, sin API)
                try
                {
                    bllVenta.ValidarTarjeta_14OR(txtNumero.Text, txtVenc.Text, txtCvv.Text);
                    MessageBox.Show(g.ObtenerTexto_43BO("cobro_msg_tarjetaok", "Pago con tarjeta aprobado."), T_14OR("ventacandy_tit_tarjeta", "Tarjeta"),
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception exCard)
                {
                    string mensaje = g.ObtenerTexto_43BO(exCard.Message, exCard.Message);
                    MessageBox.Show(mensaje, T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }

            try
            {
                int idVenta = bllVentaCandy.ConfirmarVenta_14OR(carrito, metodo, total);

                string extra = "";
                if (rbEfectivo.Checked)
                {
                    double paga = double.Parse(txtPaga.Text);
                    extra = "\n" + T_14OR("ventacandy_lblvuelto", "Vuelto: $ ") + (paga - total).ToString("0.00");
                }

                MessageBox.Show(string.Format(T_14OR("ventacandy_msg_venta", "Venta N° {0} registrada. Total: $ {1}."), idVenta, total.ToString("0.00")) + extra,
                    T_14OR("ventacandy_tit_venta", "Venta confirmada"), MessageBoxButtons.OK, MessageBoxIcon.Information);

                // limpio el pedido y refresco las tarjetas (el stock cambio)
                carrito.Clear();
                txtPaga.Clear();
                txtNumero.Clear();
                txtVenc.Clear();
                txtCvv.Clear();
                CargarProductos_14OR();
                RefrescarPedido_14OR();
            }
            catch (Exception ex)
            {
                // puede venir "candy_msg_sinstock|Nombre": traduzco la clave y le agrego el nombre
                string msg = ex.Message;
                if (msg.StartsWith("candy_msg_sinstock|"))
                {
                    string nombre = msg.Substring("candy_msg_sinstock|".Length);
                    string plantilla = g.ObtenerTexto_43BO("candy_msg_sinstock", "No hay stock suficiente de: {0}");
                    msg = string.Format(plantilla, nombre);
                }
                else
                {
                    msg = g.ObtenerTexto_43BO(msg, msg);
                }
                MessageBox.Show(msg, T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            carrito.Clear();
            RefrescarPedido_14OR();
        }

        // atajo pa traducir cn el idioma actual, si falta la clave usa el texto x defecto
        private string T_14OR(string clave, string porDefecto)
        {
            return GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(clave, porDefecto);
        }

        private void TraducirColumnas_14OR()
        {
            dgvPedido.TituloColumna_43BO("NombreProducto_14OR", T_14OR("pn2_col_producto", "Producto"));
            dgvPedido.TituloColumna_43BO("Cantidad_14OR", T_14OR("pn2_col_cant", "Cant."));
            dgvPedido.TituloColumna_43BO("Subtotal", T_14OR("pn2_col_subtotal", "Subtotal"));
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            if (IsDisposed) return;
            this.TraducirAuto_43BO(dic);
            this.Text = T_14OR("ventacandy_titulo", "Venta Candy Bar");
            TraducirColumnas_14OR();
            if (!cargado_14OR) return;
            CargarProductos_14OR();
            Actualizar_14OR(null, null);
        }
    }
}

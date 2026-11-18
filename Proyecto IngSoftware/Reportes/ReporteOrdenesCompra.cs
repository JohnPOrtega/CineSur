using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using iTextSharp.text;
using iTextSharp.text.pdf;

using iTextFont = iTextSharp.text.Font;

namespace Proyecto_IngSoftware
{
    // RF2 - Detalle de Orden de Compra y Recepcion.
    // Arriba las ordenes (nro, proveedor, emision, recepcion, estado, total); abajo, al elegir una,
    // los productos de esa orden (cantidad pedida, recibida, costo unitario, subtotal).
    // La cantidad "recibida" solo tiene valor cuando la orden ya esta Cerrada (recepcion confirmada).
    public partial class ReporteOrdenesCompra : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllOrdenCompra_14OR bllOrden = new BllOrdenCompra_14OR();
        // todas: lo que vino de la base; ordenes: lo que queda despues de los filtros (se ve y se exporta)
        private List<OrdenCompra_14OR> todas_14OR = new List<OrdenCompra_14OR>();
        private List<OrdenCompra_14OR> ordenes = new List<OrdenCompra_14OR>();
        private bool cargando_14OR = false;
        private const string TODOS_14OR = "(Todos)";

        public ReporteOrdenesCompra()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            cboEstado.SelectedIndex = 0;
            CargarReporte_14OR();
        }

        // atajo pa traducir los mensajes con el idioma actual
        private string T_14OR(string clave, string porDefecto)
        {
            return GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(clave, porDefecto);
        }

        // trae de la base y vuelve a aplicar los filtros que esten puestos
        private void CargarReporte_14OR()
        {
            try
            {
                todas_14OR = bllOrden.Listar_14OR();
                LlenarProveedores_14OR();
                AplicarFiltros_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("reporteordenescompra_msg_errorcargar", "No pude cargar el reporte: ") + ex.Message,
                    T_14OR("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // combo de proveedores con los que tienen ordenes (sin perder lo elegido)
        private void LlenarProveedores_14OR()
        {
            cargando_14OR = true;
            string elegido = cboProveedor.SelectedItem as string;

            cboProveedor.Items.Clear();
            cboProveedor.Items.Add(TODOS_14OR);
            foreach (string p in todas_14OR.Select(o => o.NombreProveedor_14OR).Where(p => !string.IsNullOrEmpty(p)).Distinct().OrderBy(p => p))
                cboProveedor.Items.Add(p);

            cboProveedor.SelectedItem = elegido != null && cboProveedor.Items.Contains(elegido) ? elegido : TODOS_14OR;
            cargando_14OR = false;
        }

        // filtra en memoria (emision desde/hasta si estan tildadas, estado y proveedor) y refresca todo
        private void AplicarFiltros_14OR()
        {
            IEnumerable<OrdenCompra_14OR> q = todas_14OR;

            if (dtpDesde.Checked) q = q.Where(o => o.FechaEmision_14OR.Date >= dtpDesde.Value.Date);
            if (dtpHasta.Checked) q = q.Where(o => o.FechaEmision_14OR.Date <= dtpHasta.Value.Date);

            string estado = cboEstado.SelectedItem as string;
            if (estado != null && estado != TODOS_14OR) q = q.Where(o => o.Estado_14OR == estado);

            string prov = cboProveedor.SelectedItem as string;
            if (prov != null && prov != TODOS_14OR) q = q.Where(o => o.NombreProveedor_14OR == prov);

            ordenes = q.ToList();

            var lista = ordenes.Select(o => new
            {
                o.IdOrdenCompra_14OR,
                Numero = o.NumeroOrden_14OR,
                Proveedor = o.NombreProveedor_14OR,
                Emision = o.FechaEmision_14OR.ToString("dd/MM/yyyy"),
                Recepcion = o.FechaRecepcion_14OR.HasValue ? o.FechaRecepcion_14OR.Value.ToString("dd/MM/yyyy") : "-",
                o.Estado_14OR,
                Total = "$ " + o.Importe_14OR.ToString("0")
            }).ToList();

            dgvOrdenes.DataSource = lista;

            if (dgvOrdenes.Columns.Count > 0)
            {
                dgvOrdenes.Columns["IdOrdenCompra_14OR"].Visible = false;
                dgvOrdenes.Columns["Numero"].HeaderText = "N°";
                dgvOrdenes.Columns["Numero"].FillWeight = 30;
                dgvOrdenes.Columns["Proveedor"].FillWeight = 70;
                dgvOrdenes.Columns["Emision"].HeaderText = "Emision";
                dgvOrdenes.Columns["Recepcion"].HeaderText = "Recepcion";
                dgvOrdenes.Columns["Estado_14OR"].HeaderText = "Estado";
                dgvOrdenes.Columns["Total"].HeaderText = "Total";
            }

            dgvDetalle.DataSource = null;

            // tarjetas: cuantas ordenes, pendientes (no cerradas) vs cerradas y el total comprado
            int pendientes = ordenes.Count(o => o.Estado_14OR != OrdenCompra_14OR.EstadoCerrada_14OR);
            int cerradas = ordenes.Count(o => o.Estado_14OR == OrdenCompra_14OR.EstadoCerrada_14OR);
            double totalComprado = ordenes.Sum(o => o.Importe_14OR);

            lblCardValor1.Text = ordenes.Count.ToString();
            lblCardValor2.Text = pendientes.ToString();
            lblCardValor3.Text = cerradas.ToString();
            lblCardValor4.Text = "$ " + totalComprado.ToString("N0");

            lblTotales.Text = "Mostrando " + ordenes.Count + " de " + todas_14OR.Count + " ordenes";
        }

        // texto de los filtros activos, para el pdf
        private string TextoFiltros_14OR()
        {
            List<string> partes = new List<string>();
            if (dtpDesde.Checked) partes.Add("emision desde " + dtpDesde.Value.ToString("dd/MM/yyyy"));
            if (dtpHasta.Checked) partes.Add("hasta " + dtpHasta.Value.ToString("dd/MM/yyyy"));
            string estado = cboEstado.SelectedItem as string;
            if (estado != null && estado != TODOS_14OR) partes.Add("estado: " + estado);
            string prov = cboProveedor.SelectedItem as string;
            if (prov != null && prov != TODOS_14OR) partes.Add("proveedor: " + prov);
            return partes.Count == 0 ? "sin filtros" : string.Join(", ", partes);
        }

        // cualquier cambio en un filtro (fechas o combos) refresca la grilla y las tarjetas
        private void Filtro_Changed(object sender, EventArgs e)
        {
            if (cargando_14OR) return;
            AplicarFiltros_14OR();
        }

        private void btnLimpiarFiltros_Click(object sender, EventArgs e)
        {
            cargando_14OR = true;
            dtpDesde.Checked = false;
            dtpHasta.Checked = false;
            cboEstado.SelectedIndex = 0;
            if (cboProveedor.Items.Count > 0) cboProveedor.SelectedIndex = 0;
            cargando_14OR = false;
            AplicarFiltros_14OR();
        }

        // al elegir una orden muestro sus productos abajo
        private void dgvOrdenes_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvOrdenes.CurrentRow == null) return;

            int id = Convert.ToInt32(dgvOrdenes.CurrentRow.Cells["IdOrdenCompra_14OR"].Value);
            string estado = dgvOrdenes.CurrentRow.Cells["Estado_14OR"].Value.ToString();
            bool cerrada = estado == OrdenCompra_14OR.EstadoCerrada_14OR;

            try
            {
                var det = bllOrden.ObtenerDetalle_14OR(id).Select(d => new
                {
                    Producto = d.NombreProducto_14OR,
                    Pedida = d.Cantidad_14OR,
                    // la recibida solo se conoce cuando la orden ya se cerro (se confirmo la recepcion)
                    Recibida = cerrada ? d.Cantidad_14OR : 0,
                    CostoUnit = "$ " + d.PrecioCosto_14OR.ToString("0.00"),
                    Subtotal = "$ " + d.Subtotal_14OR.ToString("0.00")
                }).ToList();

                dgvDetalle.DataSource = det;

                if (dgvDetalle.Columns.Count > 0)
                {
                    dgvDetalle.Columns["Pedida"].HeaderText = "Cant. pedida";
                    dgvDetalle.Columns["Recibida"].HeaderText = "Cant. recibida";
                    dgvDetalle.Columns["CostoUnit"].HeaderText = "Costo unitario";
                    dgvDetalle.Columns["Subtotal"].HeaderText = "Subtotal";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("reporteordenescompra_msg_errorcargar", "No pude cargar el reporte: ") + ex.Message,
                    T_14OR("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            CargarReporte_14OR();
        }

        private void btnExportarPdf_Click(object sender, EventArgs e)
        {
            if (ordenes == null || ordenes.Count == 0)
            {
                MessageBox.Show(T_14OR("reporteordenescompra_msg_sindatos", "No hay datos para exportar."),
                    T_14OR("titulo_atencion", "Atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                string carpeta = Path.Combine(Application.StartupPath, "Reportes");
                if (!Directory.Exists(carpeta)) Directory.CreateDirectory(carpeta);

                string archivo = "RF2_OrdenesCompra_" + DateTime.Now.ToString("yyyyMMdd_HHmm") + ".pdf";
                string ruta = Path.Combine(carpeta, archivo);

                GenerarPdf_14OR(ruta);

                MessageBox.Show(string.Format(T_14OR("reporteordenescompra_msg_exportado", "Reporte exportado en:\n{0}"), ruta),
                    T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);

                try { Process.Start(ruta); } catch { }
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("reporteordenescompra_msg_errorexportar", "No pude exportar el PDF: ") + ex.Message,
                    T_14OR("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // arma el PDF: una seccion por orden (cabecera + tabla de sus productos) en A4 apaisada
        private void GenerarPdf_14OR(string ruta)
        {
            Document doc = new Document(PageSize.A4.Rotate(), 30, 30, 30, 30);

            using (FileStream fs = new FileStream(ruta, FileMode.Create))
            {
                PdfWriter.GetInstance(doc, fs);
                doc.Open();

                iTextFont fTitulo = FontFactory.GetFont("Helvetica", 16, iTextFont.BOLD);
                iTextFont fSub = FontFactory.GetFont("Helvetica", 9, iTextFont.NORMAL);
                iTextFont fOrden = FontFactory.GetFont("Helvetica", 11, iTextFont.BOLD);
                iTextFont fCab = FontFactory.GetFont("Helvetica", 9, iTextFont.BOLD, BaseColor.WHITE);
                iTextFont fCelda = FontFactory.GetFont("Helvetica", 9, iTextFont.NORMAL);
                iTextFont fTotal = FontFactory.GetFont("Helvetica", 10, iTextFont.BOLD);

                Paragraph pTit = new Paragraph("CineSur - RF2 Detalle de Orden de Compra y Recepcion", fTitulo);
                pTit.SpacingAfter = 4;
                doc.Add(pTit);

                Paragraph pFecha = new Paragraph("Emitido: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm") +
                                                 "     Filtros: " + TextoFiltros_14OR(), fSub);
                pFecha.SpacingAfter = 12;
                doc.Add(pFecha);

                BaseColor azul = new BaseColor(58, 114, 176);

                foreach (OrdenCompra_14OR o in ordenes)
                {
                    bool cerrada = o.Estado_14OR == OrdenCompra_14OR.EstadoCerrada_14OR;
                    string recep = o.FechaRecepcion_14OR.HasValue ? o.FechaRecepcion_14OR.Value.ToString("dd/MM/yyyy") : "-";

                    Paragraph pOrd = new Paragraph(
                        "Orden N° " + o.NumeroOrden_14OR + "  -  " + o.NombreProveedor_14OR +
                        "   |  Emision: " + o.FechaEmision_14OR.ToString("dd/MM/yyyy") +
                        "   |  Recepcion: " + recep +
                        "   |  Estado: " + o.Estado_14OR +
                        "   |  Total: $ " + o.Importe_14OR.ToString("0"), fOrden);
                    pOrd.SpacingBefore = 10;
                    pOrd.SpacingAfter = 4;
                    doc.Add(pOrd);

                    PdfPTable tabla = new PdfPTable(5);
                    tabla.WidthPercentage = 100;
                    tabla.SetWidths(new float[] { 40, 15, 15, 15, 15 });

                    string[] cabeceras = { "Producto", "Cant. pedida", "Cant. recibida", "Costo unitario", "Subtotal" };
                    foreach (string c in cabeceras)
                    {
                        PdfPCell cel = new PdfPCell(new Phrase(c, fCab));
                        cel.BackgroundColor = azul;
                        cel.Padding = 5;
                        tabla.AddCell(cel);
                    }

                    List<DetalleOrdenCompra_14OR> det = bllOrden.ObtenerDetalle_14OR(o.IdOrdenCompra_14OR);
                    foreach (DetalleOrdenCompra_14OR d in det)
                    {
                        tabla.AddCell(Celda_14OR(d.NombreProducto_14OR, fCelda));
                        tabla.AddCell(Celda_14OR(d.Cantidad_14OR.ToString(), fCelda));
                        tabla.AddCell(Celda_14OR((cerrada ? d.Cantidad_14OR : 0).ToString(), fCelda));
                        tabla.AddCell(Celda_14OR("$ " + d.PrecioCosto_14OR.ToString("0.00"), fCelda));
                        tabla.AddCell(Celda_14OR("$ " + d.Subtotal_14OR.ToString("0.00"), fCelda));
                    }

                    doc.Add(tabla);
                }

                int cerradasTot = ordenes.Count(o => o.Estado_14OR == OrdenCompra_14OR.EstadoCerrada_14OR);
                double totalComprado = ordenes.Sum(o => o.Importe_14OR);
                Paragraph pTot = new Paragraph(
                    "\nOrdenes: " + ordenes.Count +
                    "     Cerradas: " + cerradasTot +
                    "     Total comprado: $ " + totalComprado.ToString("0"), fTotal);
                doc.Add(pTot);

                doc.Close();
            }
        }

        private PdfPCell Celda_14OR(string texto, iTextFont f)
        {
            PdfPCell c = new PdfPCell(new Phrase(texto, f));
            c.Padding = 4;
            return c;
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
    }
}

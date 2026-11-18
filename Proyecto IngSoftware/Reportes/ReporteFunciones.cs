using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using iTextSharp.text;
using iTextSharp.text.pdf;



using iTextFont = iTextSharp.text.Font;

namespace Proyecto_IngSoftware
{
   
    public partial class ReporteFunciones : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllReporte_14OR bll = new BllReporte_14OR();
        // todos: lo que vino de la base; datos: lo que queda despues de los filtros (es lo que se ve y se exporta)
        private List<ReporteFuncionOcupacion_14OR> todos_14OR = new List<ReporteFuncionOcupacion_14OR>();
        private List<ReporteFuncionOcupacion_14OR> datos = new List<ReporteFuncionOcupacion_14OR>();
        private bool cargando_14OR = false;
        private const string TODAS_14OR = "(Todas)";

        public ReporteFunciones()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            CargarReporte_14OR();
        }

        // trae de la base y vuelve a aplicar los filtros que esten puestos
        private void CargarReporte_14OR()
        {
            try
            {
                todos_14OR = bll.ListadoFuncionesOcupacion_14OR();
                LlenarCombos_14OR();
                AplicarFiltros_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar el reporte: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // combos de pelicula y sala con lo que hay en el reporte (sin perder lo elegido)
        private void LlenarCombos_14OR()
        {
            cargando_14OR = true;

            string peliElegida = cboPelicula.SelectedItem as string;
            string salaElegida = cboSala.SelectedItem as string;

            cboPelicula.Items.Clear();
            cboPelicula.Items.Add(TODAS_14OR);
            foreach (string p in todos_14OR.Select(r => r.Pelicula_14OR).Distinct().OrderBy(p => p))
                cboPelicula.Items.Add(p);

            cboSala.Items.Clear();
            cboSala.Items.Add(TODAS_14OR);
            foreach (int sala in todos_14OR.Select(r => r.Sala_14OR).Distinct().OrderBy(x => x))
                cboSala.Items.Add(sala.ToString());

            cboPelicula.SelectedItem = peliElegida != null && cboPelicula.Items.Contains(peliElegida) ? peliElegida : TODAS_14OR;
            cboSala.SelectedItem = salaElegida != null && cboSala.Items.Contains(salaElegida) ? salaElegida : TODAS_14OR;

            cargando_14OR = false;
        }

        // filtra en memoria (fecha desde/hasta solo si estan tildadas, pelicula y sala) y refresca todo
        private void AplicarFiltros_14OR()
        {
            IEnumerable<ReporteFuncionOcupacion_14OR> q = todos_14OR;

            if (dtpDesde.Checked) q = q.Where(r => r.Fecha_14OR.Date >= dtpDesde.Value.Date);
            if (dtpHasta.Checked) q = q.Where(r => r.Fecha_14OR.Date <= dtpHasta.Value.Date);

            string peli = cboPelicula.SelectedItem as string;
            if (peli != null && peli != TODAS_14OR) q = q.Where(r => r.Pelicula_14OR == peli);

            string sala = cboSala.SelectedItem as string;
            if (sala != null && sala != TODAS_14OR) q = q.Where(r => r.Sala_14OR.ToString() == sala);

            datos = q.ToList();

            var lista = datos.Select(r => new
            {
                r.IdFuncion_14OR,
                Pelicula = r.Pelicula_14OR,
                Sala = r.Sala_14OR,
                Fecha = r.Fecha_14OR.ToString("dd/MM/yyyy"),
                Hora = r.Horario_14OR.ToString("HH:mm"),
                Vendidos = r.TicketsVendidos_14OR,
                Disponibles = r.ButacasDisponibles_14OR,
                Recaudacion = "$ " + r.RecaudacionParcial_14OR.ToString("0")
            }).ToList();

            dgvReporte.DataSource = lista;

            if (dgvReporte.Columns.Count > 0)
            {
                dgvReporte.Columns["IdFuncion_14OR"].HeaderText = "ID";
                dgvReporte.Columns["IdFuncion_14OR"].FillWeight = 25;
                dgvReporte.Columns["Pelicula"].FillWeight = 70;
                dgvReporte.Columns["Vendidos"].HeaderText = "Tickets vendidos";
                dgvReporte.Columns["Disponibles"].HeaderText = "Butacas disponibles";
                dgvReporte.Columns["Recaudacion"].HeaderText = "Recaudacion parcial";
                dgvReporte.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            }

            // tarjetas de arriba
            int totalVendidos = datos.Sum(r => r.TicketsVendidos_14OR);
            int totalButacas = datos.Sum(r => r.TicketsVendidos_14OR + r.ButacasDisponibles_14OR);
            double totalRecaudacion = datos.Sum(r => r.RecaudacionParcial_14OR);

            lblCardValor1.Text = datos.Count.ToString();
            lblCardValor2.Text = totalVendidos.ToString();
            lblCardValor3.Text = Ocupacion_14OR(totalVendidos, totalButacas);
            lblCardValor4.Text = "$ " + totalRecaudacion.ToString("N0");

            lblTotales.Text = "Mostrando " + datos.Count + " de " + todos_14OR.Count + " funciones";
        }

        private string Ocupacion_14OR(int vendidos, int butacas)
        {
            if (butacas <= 0) return "0 %";
            return (vendidos * 100.0 / butacas).ToString("0.0") + " %";
        }

        // texto de los filtros activos, para el pie del pdf
        private string TextoFiltros_14OR()
        {
            List<string> partes = new List<string>();
            if (dtpDesde.Checked) partes.Add("desde " + dtpDesde.Value.ToString("dd/MM/yyyy"));
            if (dtpHasta.Checked) partes.Add("hasta " + dtpHasta.Value.ToString("dd/MM/yyyy"));
            string peli = cboPelicula.SelectedItem as string;
            if (peli != null && peli != TODAS_14OR) partes.Add("pelicula: " + peli);
            string sala = cboSala.SelectedItem as string;
            if (sala != null && sala != TODAS_14OR) partes.Add("sala " + sala);
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
            if (cboPelicula.Items.Count > 0) cboPelicula.SelectedIndex = 0;
            if (cboSala.Items.Count > 0) cboSala.SelectedIndex = 0;
            cargando_14OR = false;
            AplicarFiltros_14OR();
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            CargarReporte_14OR();
        }

        private void btnExportarPdf_Click(object sender, EventArgs e)
        {
            if (datos == null || datos.Count == 0)
            {
                MessageBox.Show("No hay datos para exportar.", "Atencion",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                string carpeta = Path.Combine(Application.StartupPath, "Reportes");
                if (!Directory.Exists(carpeta)) Directory.CreateDirectory(carpeta);

                string archivo = "RF1_Funciones_" + DateTime.Now.ToString("yyyyMMdd_HHmm") + ".pdf";
                string ruta = Path.Combine(carpeta, archivo);

                GenerarPdf_14OR(ruta);

                MessageBox.Show("Reporte exportado en:\n" + ruta, "Listo",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);

                // lo abro para que lo vea de una
                try { Process.Start(ruta); } catch { }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude exportar el PDF: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // arma el PDF del reporte con una tabla (una hoja A4 apaisada)
        private void GenerarPdf_14OR(string ruta)
        {
            Document doc = new Document(PageSize.A4.Rotate(), 30, 30, 30, 30);

            using (FileStream fs = new FileStream(ruta, FileMode.Create))
            {
                PdfWriter.GetInstance(doc, fs);
                doc.Open();

                iTextFont fTitulo = FontFactory.GetFont("Helvetica", 16, iTextFont.BOLD);
                iTextFont fSub = FontFactory.GetFont("Helvetica", 9, iTextFont.NORMAL);
                iTextFont fCab = FontFactory.GetFont("Helvetica", 9, iTextFont.BOLD, BaseColor.WHITE);
                iTextFont fCelda = FontFactory.GetFont("Helvetica", 9, iTextFont.NORMAL);
                iTextFont fTotal = FontFactory.GetFont("Helvetica", 10, iTextFont.BOLD);

                Paragraph pTit = new Paragraph("CineSur - RF1 Listado de Funciones y Ocupacion de Sala", fTitulo);
                pTit.SpacingAfter = 4;
                doc.Add(pTit);

                Paragraph pFecha = new Paragraph("Emitido: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm") +
                                                 "     Filtros: " + TextoFiltros_14OR(), fSub);
                pFecha.SpacingAfter = 12;
                doc.Add(pFecha);

                PdfPTable tabla = new PdfPTable(8);
                tabla.WidthPercentage = 100;
                tabla.SetWidths(new float[] { 6, 28, 8, 13, 10, 12, 13, 15 });

                BaseColor azul = new BaseColor(58, 114, 176);
                string[] cabeceras = { "ID", "Pelicula", "Sala", "Fecha", "Hora", "Vendidos", "Disponibles", "Recaudacion" };
                foreach (string c in cabeceras)
                {
                    PdfPCell cel = new PdfPCell(new Phrase(c, fCab));
                    cel.BackgroundColor = azul;
                    cel.Padding = 5;
                    tabla.AddCell(cel);
                }

                foreach (ReporteFuncionOcupacion_14OR r in datos)
                {
                    tabla.AddCell(Celda_14OR(r.IdFuncion_14OR.ToString(), fCelda));
                    tabla.AddCell(Celda_14OR(r.Pelicula_14OR, fCelda));
                    tabla.AddCell(Celda_14OR(r.Sala_14OR.ToString(), fCelda));
                    tabla.AddCell(Celda_14OR(r.Fecha_14OR.ToString("dd/MM/yyyy"), fCelda));
                    tabla.AddCell(Celda_14OR(r.Horario_14OR.ToString("HH:mm"), fCelda));
                    tabla.AddCell(Celda_14OR(r.TicketsVendidos_14OR.ToString(), fCelda));
                    tabla.AddCell(Celda_14OR(r.ButacasDisponibles_14OR.ToString(), fCelda));
                    tabla.AddCell(Celda_14OR("$ " + r.RecaudacionParcial_14OR.ToString("0"), fCelda));
                }

                doc.Add(tabla);

                int totalVendidos = datos.Sum(r => r.TicketsVendidos_14OR);
                int totalButacas = datos.Sum(r => r.TicketsVendidos_14OR + r.ButacasDisponibles_14OR);
                double totalRec = datos.Sum(r => r.RecaudacionParcial_14OR);

                Paragraph pTot = new Paragraph(
                    "\nFunciones: " + datos.Count +
                    "     Tickets vendidos: " + totalVendidos +
                    "     Ocupacion: " + Ocupacion_14OR(totalVendidos, totalButacas) +
                    "     Recaudacion total: $ " + totalRec.ToString("0"), fTotal);
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
    
        // traduccion automatica: al cambiar idioma el gestor llama aca y se traducen
        // todos los controles estaticos que tengan clave en el JSON (patron observer).
        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
}
}

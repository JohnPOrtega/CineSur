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
        private List<ReporteFuncionOcupacion_14OR> datos = new List<ReporteFuncionOcupacion_14OR>();

        public ReporteFunciones()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            CargarReporte_14OR();
        }

        private void CargarReporte_14OR()
        {
            try
            {
                datos = bll.ListadoFuncionesOcupacion_14OR();

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

                // totales del pie
                int totalVendidos = datos.Sum(r => r.TicketsVendidos_14OR);
                double totalRecaudacion = datos.Sum(r => r.RecaudacionParcial_14OR);
                lblTotales.Text = "Funciones: " + datos.Count +
                                  "     Tickets vendidos: " + totalVendidos +
                                  "     Recaudacion total: $ " + totalRecaudacion.ToString("0");
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar el reporte: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
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

                Paragraph pFecha = new Paragraph("Emitido: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm"), fSub);
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
                double totalRec = datos.Sum(r => r.RecaudacionParcial_14OR);

                Paragraph pTot = new Paragraph(
                    "\nFunciones: " + datos.Count +
                    "     Tickets vendidos: " + totalVendidos +
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

using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;
using iTextSharp.text;
using iTextSharp.text.pdf;

using iTextFont = iTextSharp.text.Font;
// itextsharp tambien tiene Font y Rectangle, asi que le digo que en la pantalla use los de windows
using Font = System.Drawing.Font;
using Rectangle = System.Drawing.Rectangle;

namespace Proyecto_IngSoftware
{
    // Panel de Control (reporte inteligente): arriba el periodo (combo + fechas), a la izquierda el
    // resumen del periodo en filas, a la derecha la ocupacion de las salas como barra y los ingresos
    // por origen (entradas vs candy) en barras horizontales. Abajo, lo "inteligente": las conclusiones
    // que saca la BLL cruzando funciones, ventas, socios, candy, stock, ordenes y proveedores,
    // pintadas por urgencia. Colores de CineSur: azul noche + azules.
    // Toda la parte fija (titulos, paneles, barra, grafico) esta en el Designer; por codigo solo se
    // arman las filas que dependen de los datos (resumen y recomendaciones).
    public partial class PanelInteligente : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllReporte_14OR bll = new BllReporte_14OR();

        private double ocupacion_14OR = 0;
        private bool cargado_14OR = false;

        // paleta CineSur (la misma de los otros formularios)
        private readonly Color FILA = Color.FromArgb(34, 37, 48);
        private readonly Color AZUL = Color.FromArgb(58, 114, 176);
        private readonly Color AZUL_CLARO = Color.FromArgb(120, 170, 230);
        // colores de urgencia de las recomendaciones (1 urgente, 2 revisar, 3 dato util)
        private readonly Color URGENTE = Color.FromArgb(220, 85, 85);
        private readonly Color REVISAR = Color.FromArgb(231, 168, 26);

        public PanelInteligente()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            TraducirTitulos_14OR();
            CargarPeriodos_14OR(2); // arranca en "ultimos 30 dias"
            cargado_14OR = true;
            AplicarPeriodo_14OR();
        }

        private string T_14OR(string clave, string porDefecto)
        {
            return GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(clave, porDefecto);
        }

        // ============ periodo ============
        private void CargarPeriodos_14OR(int indice)
        {
            cboPeriodo.Items.Clear();
            cboPeriodo.Items.Add(T_14OR("panelinteligente_per_hoy", "Hoy"));
            cboPeriodo.Items.Add(T_14OR("panelinteligente_per_7", "Últimos 7 días"));
            cboPeriodo.Items.Add(T_14OR("panelinteligente_per_30", "Últimos 30 días"));
            cboPeriodo.Items.Add(T_14OR("panelinteligente_per_mes", "Este mes"));
            cboPeriodo.Items.Add(T_14OR("panelinteligente_per_hist", "Histórico total"));
            cboPeriodo.Items.Add(T_14OR("panelinteligente_per_personalizado", "Personalizado"));
            cboPeriodo.SelectedIndex = indice;
        }

        private void cboPeriodo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!cargado_14OR) return;
            AplicarPeriodo_14OR();
        }

        // pone las fechas segun lo elegido; en "Personalizado" deja elegirlas y espera a Actualizar
        private void AplicarPeriodo_14OR()
        {
            DateTime hoy = DateTime.Today;
            bool personalizado = cboPeriodo.SelectedIndex == 5;
            dtpDesde.Enabled = personalizado;
            dtpHasta.Enabled = personalizado;
            if (personalizado) return;

            switch (cboPeriodo.SelectedIndex)
            {
                case 0: dtpDesde.Value = hoy; break;
                case 1: dtpDesde.Value = hoy.AddDays(-6); break;
                case 2: dtpDesde.Value = hoy.AddDays(-29); break;
                case 3: dtpDesde.Value = new DateTime(hoy.Year, hoy.Month, 1); break;
                case 4: dtpDesde.Value = new DateTime(2000, 1, 1); break;
            }
            dtpHasta.Value = hoy;
            CargarDatos_14OR();
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            CargarDatos_14OR();
        }

        // los titulos de las secciones estan en el Designer y guardan su clave de idioma en el Tag
        private void TraducirTitulos_14OR()
        {
            foreach (Control c in pnlGeneral.Controls)
                if (c is Label && c.Tag is string) c.Text = T_14OR((string)c.Tag, c.Text);
        }

        // ============ carga de datos ============
        private void CargarDatos_14OR()
        {
            try
            {
                DashboardGeneral_14OR g = bll.ObtenerGeneral_14OR(dtpDesde.Value, dtpHasta.Value);
                double total = g.RecaudacionEntradas_14OR + g.VentasCandy_14OR;

                lblSubtitulo.Text = string.Format(T_14OR("panelinteligente_subtitulo", "Del {0} al {1}"),
                    dtpDesde.Value.ToString("dd/MM/yyyy"), dtpHasta.Value.ToString("dd/MM/yyyy"));

                // resumen en filas, la ultima (total) resaltada en azul
                pnlResumen.Controls.Clear();
                int y = 0;
                y = FilaResumen_14OR(T_14OR("panelinteligente_kpi_funciones", "Funciones del período"), g.FuncionesPeriodo_14OR.ToString(), y, false);
                y = FilaResumen_14OR(T_14OR("panelinteligente_kpi_tickets", "Tickets vendidos"), g.TicketsVendidos_14OR.ToString(), y, false);
                y = FilaResumen_14OR(T_14OR("panelinteligente_kpi_ticketprom", "Ticket promedio"), "$ " + g.TicketPromedio_14OR.ToString("0.00"), y, false);
                y = FilaResumen_14OR(T_14OR("panelinteligente_kpi_recaudacion", "Recaudación entradas"), "$ " + g.RecaudacionEntradas_14OR.ToString("0"), y, false);
                y = FilaResumen_14OR(T_14OR("panelinteligente_kpi_candy", "Ventas candy"), "$ " + g.VentasCandy_14OR.ToString("0"), y, false);
                FilaResumen_14OR(T_14OR("panelinteligente_kpi_total", "Ingreso total"), "$ " + total.ToString("0"), y, true);

                // ocupacion
                ocupacion_14OR = Math.Max(0, Math.Min(100, g.TasaOcupacion_14OR));
                lblOcupacionValor.Text = g.TasaOcupacion_14OR.ToString("0.0") + " %";
                lblOcupacionDetalle.Text = string.Format(T_14OR("panelinteligente_ocupacion_detalle", "{0} entradas vendidas en {1} funciones"),
                    g.TicketsVendidos_14OR, g.FuncionesPeriodo_14OR);
                pnlOcupacionBarra.Invalidate();

                // ingresos por origen
                ArmarGraficoIngresos_14OR(g.RecaudacionEntradas_14OR, g.VentasCandy_14OR, total);

                // conclusiones cruzando las tablas
                CargarRecomendaciones_14OR(bll.GenerarRecomendaciones_14OR(dtpDesde.Value, dtpHasta.Value));
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("panelinteligente_msg_error", "No pude cargar el panel: ") + ex.Message,
                    T_14OR("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // una fila por recomendacion: rayita del color de la urgencia, el area y el texto
        private void CargarRecomendaciones_14OR(List<Recomendacion_14OR> recs)
        {
            pnlRecomendaciones.SuspendLayout();
            pnlRecomendaciones.Controls.Clear();
            int y = 0;
            foreach (Recomendacion_14OR r in recs)
            {
                Color color = ColorPrioridad_14OR(r.Prioridad_14OR);
                Panel fila = new Panel { Location = new Point(0, y), Size = new Size(1120, 40), BackColor = FILA };
                Panel marca = new Panel { Location = new Point(0, 0), Size = new Size(5, 40), BackColor = color };
                Label lArea = new Label
                {
                    Text = T_14OR(r.ClaveArea_14OR, r.AreaPorDefecto_14OR).ToUpper(),
                    AutoSize = false, Size = new Size(170, 40), Location = new Point(16, 0),
                    TextAlign = ContentAlignment.MiddleLeft,
                    Font = new Font("Segoe UI", 8.5F, FontStyle.Bold), ForeColor = color, BackColor = Color.Transparent
                };
                Label lTexto = new Label
                {
                    Text = TextoRecomendacion_14OR(r),
                    AutoSize = false, Size = new Size(920, 40), Location = new Point(192, 0),
                    TextAlign = ContentAlignment.MiddleLeft,
                    Font = new Font("Segoe UI", 9.5F), ForeColor = Color.White, BackColor = Color.Transparent
                };
                fila.Controls.Add(marca);
                fila.Controls.Add(lArea);
                fila.Controls.Add(lTexto);
                pnlRecomendaciones.Controls.Add(fila);
                y += 40 + 5;
            }
            pnlRecomendaciones.Height = Math.Max(60, y);
            pnlRecomendaciones.ResumeLayout();
        }

        private Color ColorPrioridad_14OR(int prioridad)
        {
            if (prioridad == 1) return URGENTE;
            if (prioridad == 2) return REVISAR;
            return AZUL_CLARO;
        }

        // arma el texto en el idioma elegido: la plantilla sale del json y los datos se meten con Format.
        // Un dato que empieza con "@" es "clave|por defecto" y tambien se traduce (ej. la franja horaria)
        private string TextoRecomendacion_14OR(Recomendacion_14OR r)
        {
            string[] datos = r.Datos_14OR ?? new string[0];
            object[] valores = new object[datos.Length];
            for (int i = 0; i < datos.Length; i++)
            {
                string d = datos[i] ?? "";
                if (d.StartsWith("@") && d.Contains("|"))
                {
                    string[] partes = d.Substring(1).Split(new[] { '|' }, 2);
                    d = T_14OR(partes[0], partes[1]);
                }
                valores[i] = d;
            }
            try { return string.Format(T_14OR(r.Clave_14OR, r.TextoPorDefecto_14OR), valores); }
            catch (FormatException) { return string.Format(r.TextoPorDefecto_14OR, valores); }
        }

        // una fila del resumen: rayita azul a la izquierda, nombre y valor a la derecha. devuelve el y siguiente
        private int FilaResumen_14OR(string nombre, string valor, int y, bool destacada)
        {
            Panel fila = new Panel { Location = new Point(0, y), Size = new Size(390, 46), BackColor = destacada ? AZUL : FILA };
            Panel marca = new Panel { Location = new Point(0, 0), Size = new Size(4, 46), BackColor = destacada ? AZUL_CLARO : AZUL };
            Label lNom = new Label { Text = nombre, AutoSize = true, Font = new Font("Segoe UI", 9.5F), ForeColor = destacada ? Color.White : Color.Gainsboro, Location = new Point(16, 14), BackColor = Color.Transparent };
            Label lVal = new Label { Text = valor, AutoSize = false, Size = new Size(170, 46), Location = new Point(206, 0), TextAlign = ContentAlignment.MiddleRight, Font = new Font("Segoe UI", 13F, FontStyle.Bold), ForeColor = Color.White, BackColor = Color.Transparent };
            fila.Controls.Add(marca);
            fila.Controls.Add(lNom);
            fila.Controls.Add(lVal);
            pnlResumen.Controls.Add(fila);
            return y + 46 + 6;
        }

        // dibuja la barra de ocupacion: fondo gris y la parte ocupada en azul
        private void PintarBarraOcupacion_14OR(object sender, PaintEventArgs e)
        {
            Panel p = (Panel)sender;
            e.Graphics.SmoothingMode = SmoothingMode.AntiAlias;
            using (SolidBrush fondo = new SolidBrush(Color.FromArgb(48, 52, 66)))
                e.Graphics.FillRectangle(fondo, 0, 0, p.Width, p.Height);
            int ancho = (int)(p.Width * ocupacion_14OR / 100.0);
            if (ancho > 0)
                using (SolidBrush lleno = new SolidBrush(AZUL_CLARO))
                    e.Graphics.FillRectangle(lleno, 0, 0, ancho, p.Height);
        }

        // barras horizontales entradas vs candy, con el monto y el % de cada uno
        private void ArmarGraficoIngresos_14OR(double entradas, double candy, double total)
        {
            Chart ch = chartIngresos;
            ch.Series.Clear();
            ch.ChartAreas.Clear();
            ch.Legends.Clear();
            ch.BackColor = FILA;

            ChartArea area = new ChartArea("area");
            area.BackColor = FILA;
            area.AxisX.LabelStyle.ForeColor = Color.Gainsboro;
            area.AxisX.LabelStyle.Font = new Font("Segoe UI", 10F, FontStyle.Bold);
            area.AxisX.LineColor = Color.FromArgb(70, 75, 95);
            area.AxisX.MajorGrid.Enabled = false;
            area.AxisX.MajorTickMark.Enabled = false;
            area.AxisY.Enabled = AxisEnabled.False;
            area.AxisY.MajorGrid.Enabled = false;
            area.AxisY.Maximum = Math.Max(entradas, candy) * 1.35 + 1; // aire pa la etiqueta del valor
            area.Position = new ElementPosition(2, 8, 96, 84);
            ch.ChartAreas.Add(area);

            Series s = new Series("Ingresos") { ChartType = SeriesChartType.Bar, IsValueShownAsLabel = true, LabelForeColor = Color.White, Font = new Font("Segoe UI", 10F, FontStyle.Bold) };
            s["PointWidth"] = "0.55";
            int iCandy = s.Points.AddXY(T_14OR("panelinteligente_origen_candy", "Candy Bar"), candy);
            int iEnt = s.Points.AddXY(T_14OR("panelinteligente_origen_entradas", "Entradas"), entradas);
            s.Points[iEnt].Color = AZUL;
            s.Points[iCandy].Color = AZUL_CLARO;
            s.Points[iEnt].Label = "$ " + entradas.ToString("0") + "  (" + Porcentaje_14OR(entradas, total) + ")";
            s.Points[iCandy].Label = "$ " + candy.ToString("0") + "  (" + Porcentaje_14OR(candy, total) + ")";
            ch.Series.Add(s);
        }

        private string Porcentaje_14OR(double parte, double total)
        {
            if (total <= 0) return "0 %";
            return (parte * 100.0 / total).ToString("0") + " %";
        }

        // ============ generar reporte PDF del periodo ============
        private void btnExportar_Click(object sender, EventArgs e)
        {
            try
            {
                DashboardGeneral_14OR g = bll.ObtenerGeneral_14OR(dtpDesde.Value, dtpHasta.Value);

                string carpeta = Path.Combine(Application.StartupPath, "Reportes");
                if (!Directory.Exists(carpeta)) Directory.CreateDirectory(carpeta);
                string ruta = Path.Combine(carpeta, "PanelControl_" + DateTime.Now.ToString("yyyyMMdd_HHmm") + ".pdf");

                Document doc = new Document(PageSize.A4, 40, 40, 40, 40);
                using (FileStream fs = new FileStream(ruta, FileMode.Create))
                {
                    PdfWriter.GetInstance(doc, fs);
                    doc.Open();

                    iTextFont fTit = FontFactory.GetFont("Helvetica", 16, iTextFont.BOLD);
                    iTextFont fSub = FontFactory.GetFont("Helvetica", 9, iTextFont.NORMAL);
                    iTextFont fCab = FontFactory.GetFont("Helvetica", 10, iTextFont.BOLD, BaseColor.WHITE);
                    iTextFont fCel = FontFactory.GetFont("Helvetica", 10, iTextFont.NORMAL);

                    Paragraph pt = new Paragraph("CineSur - Panel de Control (General)", fTit); pt.SpacingAfter = 4; doc.Add(pt);
                    doc.Add(new Paragraph("Periodo: " + dtpDesde.Value.ToString("dd/MM/yyyy") + " a " + dtpHasta.Value.ToString("dd/MM/yyyy"), fSub));
                    Paragraph pe = new Paragraph("Emitido: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm"), fSub); pe.SpacingAfter = 12; doc.Add(pe);

                    PdfPTable t = new PdfPTable(2); t.WidthPercentage = 70; t.HorizontalAlignment = Element.ALIGN_LEFT;
                    t.SetWidths(new float[] { 60, 40 });
                    BaseColor azul = new BaseColor(58, 114, 176);
                    CeldaCab_14OR(t, "Indicador", fCab, azul); CeldaCab_14OR(t, "Valor", fCab, azul);
                    Fila_14OR(t, "Funciones del periodo", g.FuncionesPeriodo_14OR.ToString(), fCel);
                    Fila_14OR(t, "Tickets vendidos", g.TicketsVendidos_14OR.ToString(), fCel);
                    Fila_14OR(t, "Tasa de ocupacion", g.TasaOcupacion_14OR.ToString("0.0") + " %", fCel);
                    Fila_14OR(t, "Recaudacion entradas", "$ " + g.RecaudacionEntradas_14OR.ToString("0"), fCel);
                    Fila_14OR(t, "Ventas candy", "$ " + g.VentasCandy_14OR.ToString("0"), fCel);
                    Fila_14OR(t, "Ticket promedio", "$ " + g.TicketPromedio_14OR.ToString("0.00"), fCel);
                    Fila_14OR(t, "Ingreso total", "$ " + (g.RecaudacionEntradas_14OR + g.VentasCandy_14OR).ToString("0"), fCel);
                    doc.Add(t);

                    // lo que el sistema detecto, en el orden de urgencia
                    Paragraph pr = new Paragraph(T_14OR("panelinteligente_recomendaciones", "LO QUE EL SISTEMA DETECTÓ"), FontFactory.GetFont("Helvetica", 12, iTextFont.BOLD));
                    pr.SpacingBefore = 16; pr.SpacingAfter = 6; doc.Add(pr);
                    PdfPTable tr = new PdfPTable(3); tr.WidthPercentage = 100;
                    tr.SetWidths(new float[] { 14, 20, 66 });
                    CeldaCab_14OR(tr, T_14OR("panelinteligente_pdf_prioridad", "Prioridad"), fCab, azul);
                    CeldaCab_14OR(tr, T_14OR("panelinteligente_pdf_area", "Área"), fCab, azul);
                    CeldaCab_14OR(tr, T_14OR("panelinteligente_pdf_detalle", "Detalle"), fCab, azul);
                    foreach (Recomendacion_14OR r in bll.GenerarRecomendaciones_14OR(dtpDesde.Value, dtpHasta.Value))
                    {
                        Color c = ColorPrioridad_14OR(r.Prioridad_14OR);
                        PdfPCell cp = new PdfPCell(new Phrase(NombrePrioridad_14OR(r.Prioridad_14OR), FontFactory.GetFont("Helvetica", 9, iTextFont.BOLD, BaseColor.WHITE)));
                        cp.BackgroundColor = new BaseColor(c.R, c.G, c.B); cp.Padding = 5; tr.AddCell(cp);
                        PdfPCell ca = new PdfPCell(new Phrase(T_14OR(r.ClaveArea_14OR, r.AreaPorDefecto_14OR), fCel)); ca.Padding = 5; tr.AddCell(ca);
                        PdfPCell cd = new PdfPCell(new Phrase(TextoRecomendacion_14OR(r), fCel)); cd.Padding = 5; tr.AddCell(cd);
                    }
                    doc.Add(tr);

                    doc.Close();
                }

                MessageBox.Show(string.Format(T_14OR("panelinteligente_msg_exportado", "Reporte exportado en:\n{0}"), ruta),
                    T_14OR("titulo_listo", "Listo"), MessageBoxButtons.OK, MessageBoxIcon.Information);
                try { Process.Start(ruta); } catch { }
            }
            catch (Exception ex)
            {
                MessageBox.Show(T_14OR("panelinteligente_msg_errorpdf", "No pude generar el reporte: ") + ex.Message,
                    T_14OR("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private string NombrePrioridad_14OR(int prioridad)
        {
            if (prioridad == 1) return T_14OR("panelinteligente_prio_urgente", "Urgente");
            if (prioridad == 2) return T_14OR("panelinteligente_prio_revisar", "Revisar");
            return T_14OR("panelinteligente_prio_dato", "Dato");
        }

        private void CeldaCab_14OR(PdfPTable t, string txt, iTextFont f, BaseColor bg)
        {
            PdfPCell c = new PdfPCell(new Phrase(txt, f)); c.BackgroundColor = bg; c.Padding = 6; t.AddCell(c);
        }
        private void Fila_14OR(PdfPTable t, string a, string b, iTextFont f)
        {
            PdfPCell c1 = new PdfPCell(new Phrase(a, f)); c1.Padding = 5; t.AddCell(c1);
            PdfPCell c2 = new PdfPCell(new Phrase(b, f)); c2.Padding = 5; t.AddCell(c2);
        }

        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            if (IsDisposed) return;
            this.TraducirAuto_43BO(dic);
            if (!cargado_14OR) return;

            // titulos de secciones (guardan su clave en el Tag)
            TraducirTitulos_14OR();

            // el combo se rearma con los textos nuevos sin perder lo elegido
            cargado_14OR = false;
            CargarPeriodos_14OR(cboPeriodo.SelectedIndex < 0 ? 2 : cboPeriodo.SelectedIndex);
            cargado_14OR = true;
            CargarDatos_14OR();
        }
    }
}

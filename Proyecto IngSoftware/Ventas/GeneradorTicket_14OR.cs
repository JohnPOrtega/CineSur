using BE;
using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace Proyecto_IngSoftware
{
    public static class GeneradorTicket_14OR
    {
        // genera una entrada por cada butaca de la venta. devuelve la carpeta donde quedaron.
        public
            static string GenerarEntradas_14OR(int numeroVenta, Funcion_14OR funcion,
            List<Butaca_14OR> butacas, double precioPorEntrada, string metodoPago)
        {
            // carpeta Entradas al lado del exe (si no existe la creo) y la amquina impresora deberia imprimir directamente loq ue lea de ahi 
            // 
            string carpeta = Path.Combine(Application.StartupPath, "Entradas");
            if (!Directory.Exists(carpeta)) Directory.CreateDirectory(carpeta);

            foreach (Butaca_14OR b in butacas)
            {
                string codigo = ((char)('A' + b.NumeroFila_14OR - 1)).ToString() + b.NumeroAsiento_14OR;
                string archivo = "Entrada_V" + numeroVenta + "_" + codigo + ".pdf";
                string ruta = Path.Combine(carpeta, archivo);
                GenerarUna_14OR(ruta, numeroVenta, funcion, codigo, precioPorEntrada, metodoPago);
            }

            return carpeta;
        }

        // arma un ticket chico para una butaca
        private static void GenerarUna_14OR(string ruta, int numeroVenta, Funcion_14OR f,
            string codigo, double precio, string metodoPago)
        {
            // hoja pequela tipo comprobante , probe cono ourier asi se ve como ticket
            Document doc = new Document(new Rectangle(220, 400), 14, 14, 14, 14);

            using (FileStream fs = new FileStream(ruta, FileMode.Create))
            {
                PdfWriter.GetInstance(doc, fs);
                doc.Open();

                Font fTitulo = FontFactory.GetFont("Courier", 15, Font.BOLD);
                Font fPeli = FontFactory.GetFont("Courier", 11, Font.BOLD);
                Font fNorm = FontFactory.GetFont("Courier", 9, Font.NORMAL);
                Font fChico = FontFactory.GetFont("Courier", 7, Font.NORMAL);

                Paragraph pTit = new Paragraph("CINESUR", fTitulo);
                pTit.Alignment = Element.ALIGN_CENTER;
                doc.Add(pTit);

                Paragraph pSala = new Paragraph("Sala " + f.Sala.Numero_14OR, fNorm);
                pSala.Alignment = Element.ALIGN_CENTER;
                doc.Add(pSala);

                doc.Add(new Paragraph("--------------------------", fNorm));
                doc.Add(new Paragraph(f.Pelicula.Titulo_14OR, fPeli));
                doc.Add(new Paragraph("Fecha: " + f.Fecha_14OR.ToString("dd-MM-yyyy"), fNorm));
                doc.Add(new Paragraph("Funcion: " + f.Horario_14OR.ToString("HH:mm"), fNorm));
                doc.Add(new Paragraph("Formato: " + FormatoTexto_14OR(f.Formato_14OR) + "  Idioma: " + f.Idioma_14OR, fNorm));
                doc.Add(new Paragraph(" ", fNorm));

                doc.Add(new Paragraph("Fila-Asiento: " + codigo, fPeli));
                doc.Add(new Paragraph("$ " + precio.ToString("0.00"), fPeli));

                doc.Add(new Paragraph("--------------------------", fNorm));
                doc.Add(new Paragraph("Venta N: " + numeroVenta, fNorm));
                doc.Add(new Paragraph("Pago: " + metodoPago, fNorm));
                doc.Add(new Paragraph("Ref: " + numeroVenta + "-" + codigo, fChico));
                doc.Add(new Paragraph("Emision: " + DateTime.Now.ToString("dd-MM-yyyy HH:mm"), fChico));
                doc.Add(new Paragraph(" ", fChico));

                Paragraph pPie = new Paragraph("Talon para el espectador", fChico);
                pPie.Alignment = Element.ALIGN_CENTER;
                doc.Add(pPie);

                doc.Close();
            }
        }

        private static string FormatoTexto_14OR(FormatoFuncion_14OR formato)
        {
            if (formato == FormatoFuncion_14OR.TresD) return "3D";
            if (formato == FormatoFuncion_14OR.CuatroDX) return "4DX";
            return "2D";
        }
    }
}
